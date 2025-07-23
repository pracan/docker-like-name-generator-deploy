# docker-like-name-generator-deploy
[K8s artifacts repo for testing CI/CD](https://github.com/pracan/docker-like-name-generator-deploy)

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add pracan-dlng https://pracan.github.io/docker-like-name-generator-deploy

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
pracan-dlng` to see the charts.

To install the docker-like-name-generator chart:

    helm install my-docker-like-name-generator pracan-dlng/docker-like-name-generator

To uninstall the chart:

    helm uninstall my-docker-like-name-generator