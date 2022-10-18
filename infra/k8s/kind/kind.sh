#!/bin/bash
kind create cluster --name codebank --config ./k8s/kind/clusterconfig.yaml
kubectl cluster-info --context kind-codebank
