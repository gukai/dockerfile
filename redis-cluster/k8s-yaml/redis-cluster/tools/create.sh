#!/bin/bash
echo "Try to create new cluster."
kubectl create -f /home/redis-cluster/redis-cluster-rc.yaml
