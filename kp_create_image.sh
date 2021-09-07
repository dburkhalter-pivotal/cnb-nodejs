#
export KUBECONFIG=~/.kube/config-tkg-dev-cluster.yml 
#
# kp image save  cnb-nodejs \
# --sub-path cnb-nodejs
kp image patch cnb-nodejs \
--tag harbor.withtanzu.com/pa-dburkhalter/cnb-nodejs \
--sub-path cnb-nodejs \
--cluster-builder default \
--env BP_OCI_DESCRIPTION="NodeJS cnb-nodejs"  \
--env BP_OCI_AUTHORS="Tanzu-South-EMEA-se-team"  \
--env BP_OCI_TITLE="cnb-nodejs" \
--env BP_OCI_SOURCE="https://github.com/dburkhalter-pivotal/cnb-nodejs" \
--env BP_OCI_DOCUMENTATION="updated on 2021-09-07" \
--env BP_OCI_VERSION="v0.10.5-2021-09-07"  \
--env 'BP_IMAGE_LABELS=relise="cnb-nodejs-v0.10.5-2021-09-07" io.packeto.maintainer="platform-team" maintainer="product-team"' \
--env "BP_OCI_DESCRIPTION=CNB NodeJS Demo Application"  \
--git https://github.com/dburkhalter-pivotal/cnb-nodejs  --git-revision master \
--output yaml --dry-run-with-image-upload > cnb-nodejs_image.yaml
#
kubectl apply -f cnb-nodejs_image.yaml
#
kp build logs  cnb-nodejs
#
# https://paketo.io/docs/howto/bom/#see-build-time-dependencies-in-the-bom
#
# pack inspect-image harbor.withtanzu.com/pa-dburkhalter/k8s-demo-app:latest --bom | jq '.remote[] | select(.name=="jre") | .metadata.version, .metadata.uri'
#
kp image status cnb-nodejs
#
# kp image list --filter ready=false
#
# docker pull harbor.withtanzu.com/pa-dburkhalter/k8s-demo-app:latest
# docker inspect harbor.withtanzu.com/pa-dburkhalter/k8s-demo-app:latest | jq '.[].Config.Labels["org.opencontainers.image.description"]'