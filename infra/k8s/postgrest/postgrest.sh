#!/bin/bash
helm repo add colearendt https://colearendt.github.io/helm
helm install codebank-postgrest colearendt/postgrest --version=0.3.2