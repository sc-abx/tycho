resource "kubernetes_config_map" "aws_cloudwatch_metrics" {
  metadata {
    name      = "aws-cloudwatch-metrics"
    namespace = "amazon-cloudwatch"

    labels = {
      "app.kubernetes.io/name" = "aws-cloudwatch-metrics"
    }
  }

  data = {
    "cwagentconfig.json" = jsonencode({
      "agent": {
        "region": data.aws_region.current.name
      },
      "logs": {
        "metrics_collected": {
          "kubernetes": {
            "cluster_name": "tf-development-tycho",
            "metrics_collection_interval": 60
          }
        },
        "force_flush_interval": 5,
        "endpoint_override": "logs.eu-west-2.amazonaws.com"
      },
      "metrics": {
        "metrics_collected": {
          "statsd": {
            "service_address": ":8125",
            "metrics_collection_interval": 30
          },
          "disk": {
            "measurement": [
              "used_percent"
            ],
            "resources": [
              "*"
            ],
            "drop_device": true
          }
        }
      },
    })
  }
}