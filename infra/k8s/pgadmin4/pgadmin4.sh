#!/bin/bash
helm repo add cetic https://cetic.github.io/helm-charts
helm repo update
helm install --name codebank-pgadmin4 cetic/pgadmin