resource "aws_cloudwatch_dashboard" "pvc_usage_dashboard" {
  dashboard_name = "pvc-usage-dashboard"
  dashboard_body = jsonencode({
    "widgets": [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
          "metrics": [
            [
              "CWAgent",
              "disk_used_percent",
              "path",
              "/rootfs/var/lib/kubelet/pods/${data.kubernetes_pod.mysql_pod.metadata[0].uid}/volumes/kubernetes.io~csi/${data.kubernetes_persistent_volume_claim.ebs-mysql-pv-claim.spec[0].volume_name}/mount",
              "fstype",
              "ext4",
              {
                "region": data.aws_region.current.name
              }
            ]
          ],
          "period": 300,
          "title": "PVC Disk Usage",
          "view": "timeSeries",
          "stacked": false,
          "region": data.aws_region.current.name,
          "stat": "Average",
          "yAxis": {
              "left": {
                  "max": 100,
                  "min": 0
              }
          }
        }
      }
    ]
  })
}
