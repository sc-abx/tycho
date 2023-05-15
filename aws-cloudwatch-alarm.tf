data "kubernetes_persistent_volume_claim" "ebs-mysql-pv-claim" {
  metadata {
    name = "ebs-mysql-pv-claim"
    namespace = "amazon-cloudwatch"
  }
}

data "external" "mysql_pod" {
  program = ["sh", "-c", "kubectl get -n amazon-cloudwatch pod -l app=mysql -o json | jq '{ result: .items[0].metadata.name }'"]
}

output "mysql_pod" {
  value = data.external.mysql_pod.result
}

data "kubernetes_pod" "mysql_pod" {
  metadata {
    name      = data.external.mysql_pod.result["result"]
    namespace = "amazon-cloudwatch"
  }
}

output "pod_uid" {
  value = data.kubernetes_pod.mysql_pod.metadata[0].uid
}


resource "aws_cloudwatch_metric_alarm" "pvc-disk-usage-alarm" {
  alarm_name          = "pvc-disk-usage-alarm"
  alarm_description   = "Alarm when PVC disk usage is greater than or equal to 80%"
  alarm_actions       = [aws_sns_topic.pvc_disk_usage_alert.arn]
  namespace           = "CWAgent"
  metric_name         = "disk_used_percent"
  statistic           = "Average"
  dimensions = {
    path   = "/rootfs/var/lib/kubelet/pods/${data.kubernetes_pod.mysql_pod.metadata[0].uid}/volumes/kubernetes.io~csi/${data.kubernetes_persistent_volume_claim.ebs-mysql-pv-claim.spec[0].volume_name}/mount"
    fstype = "ext4"
  }
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 80
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "missing"
}


resource "aws_sns_topic" "pvc_disk_usage_alert" {
  name = "pvc-disk-usage-alert-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.pvc_disk_usage_alert.arn
  protocol  = "email"
  endpoint  = "shaun.carter@airboxsystems.com"
}