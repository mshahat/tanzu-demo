#!/usr/bin/env bash

. magic.sh

load_config

echo '----------------------------------------------'
echo '     Configuring Credentials in Dev cluster'
echo '----------------------------------------------'

echo ''
echo 'Continue to switch to the Dev Cluster...'
pe "kubectx ${DEV_CLUSTER}"

echo ''
echo 'Continue to create required namespaces'
pe "kubectl create ns ${DEV_NAMESPACE}"
pe "kubectl create ns ${DEV_DATA_NAMESPACE}"

echo ''
echo 'Creating Dev credentials'
cat kubernetes/cicd/argocd/rabbit-secret.template.yml | sed "s/RABBITMQ_PASSWORD/$DEV_RABBITMQ_PASSWORD/" | kubectl create -n ${DEV_NAMESPACE} -f -
cat kubernetes/cicd/argocd/rabbit-secret.template.yml | sed "s/RABBITMQ_PASSWORD/$DEV_RABBITMQ_PASSWORD/" | kubectl create -n ${DEV_DATA_NAMESPACE} -f -

cat kubernetes/cicd/argocd/redis-secret.template.yml | sed "s/REDIS_PASSWORD/$DEV_REDIS_PASSWORD/" | kubectl create -n ${DEV_NAMESPACE} -f -
cat kubernetes/cicd/argocd/redis-secret.template.yml | sed "s/REDIS_PASSWORD/$DEV_REDIS_PASSWORD/" | kubectl create -n ${DEV_DATA_NAMESPACE} -f -

cat kubernetes/cicd/argocd/wavefront-token.template.yml | sed "s/WAVEFRONT_TOKEN/$DEV_WAVEFRONT_TOKEN/" | kubectl create -n ${DEV_NAMESPACE} -f -

