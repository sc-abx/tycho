#!/bin/bash

function Restart_AllDeploymentsInNamespace {
    namespace=$1

    echo "Working in namespace $namespace"
    data=$(kubectl get deployments --namespace "$namespace" --output json | jq -r '.items[].metadata.name')

    while IFS= read -r name; do
        echo "$name"
        kubectl rollout restart deployment "$name" --namespace "$namespace"
    done <<< "$data"

    echo "========================================"
}

# Main

namespaces=$(kubectl get namespaces --output custom-columns=NAME:metadata.name | tail -n +2)

while IFS= read -r namespace; do
    case "$namespace" in
        "cert-manager") echo "ignore: cert-manager" ;;
        "databases") echo "ignore: databases" ;;
        "default") echo "ignore: default" ;;
        "devtools") echo "ignore: devtools" ;;
        "flux-system") echo "ignore: flux-system" ;;
        "ingress-nginx") echo "ignore: ingress-nginx" ;;
        "kafka") echo "ignore: kafka" ;;
        "kube-node-lease") echo "ignore: kube-node-lease" ;;
        "kube-public") echo "ignore: kube-public" ;;
        "kube-system") echo "ignore: kube-system" ;;
        "linkerd") echo "ignore: linkerd" ;;
        "linkerd-viz") echo "ignore: linkerd-viz" ;;
        *) 
            echo "$namespace"
            Restart_AllDeploymentsInNamespace "$namespace"
            ;;
    esac
done <<< "$namespaces"
