# Helm Chart for deployment on Kubernetes

This is a [Helm](https://github.com/kubernetes/helm) chart to deploy automatically [Docker-like Name Generator](https://github.com/pracan/docker-like-name-generator) on [Kubernetes](https://kubernetes.io/).

It was made to be used with [Kustomize](https://kustomize.io/) but it can be used on its own for debug purposes.

### Usage

> This chart was made for helm 3

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add pracan-dlng https://pracan.github.io/docker-like-name-generator-deploy

If you had already added this repo earlier, run `helm repo update` to retrieve the latest versions of the packages.  You can then run : 
`helm search repo pracan-dlng` to see the charts.

To install the docker-like-name-generator chart:

    helm install my-docker-like-name-generator pracan-dlng/docker-like-name-generator

To uninstall the chart:

    helm uninstall my-docker-like-name-generator

### Files description
```
helm/
├── .helmignore                         # A file is used to specify the files and folders that helm should ignore.
├── Chart.yaml                          # A YAML file containing information about the chart
├── README.md                           # The file you're currently reading
├── templates
│   ├── NOTES.txt                       # The "help text" of the chart. This will be displayed to the users when they run "helm install"
│   ├── _helpers.tpl                    # Local values definitions that are used in the other templates
│   ├── deployment.yaml                 # Template defining deployment of the app
│   ├── hpa.yaml                        # Template defining a HPA for the app if needed.
│   ├── service.yaml                    # Template defining a basic service for the app
│   └── tests
│       └── test-connection.yaml        # Test file to validate chart deployment using "helm test"
└── values.yaml                         # The default configuration values for this chart

2 directories, 10 files
```

## Configuring the Chart for your Application
### Chart default values
The table below lists the default values included with this Helm chart. If these parameters are not overwritten in your own `values.yaml` they will default to these values.

| Parameter                  | Default                                    |
| -----------------------    | ---------------------------------------------   |
| `service.type`             |`ClusterIP`                                  |
| `service.port`             |`80`                                  |
| `replicaCount`             |`1`                                  |
| `editdefaultSecurityContext.webServerUID`             |`1001`                                  |
| `editdefaultSecurityContext.appUID`             |`1002`                                  |
| `editdefaultSecurityContext.groupForBoth`             |`3000`                                  |
| `image.repository`             |`pracan`                                  |
| `image.name`             |`docker-like-name-generator`                                  |
| `image.tag`             |`latest`                                  |
| `debug.enabled`             |`false`                                  |
| `debug.image`             |`busybox:latest`                                  |

### Full Chart parameters breakdown
The following table provides a full list of the configurable parameters of this Helm chart and provides an example value for each of them.

| Parameter                  | Description                                     | Example values                                                    |
| -----------------------    | ---------------------------------------------   | ------------------------------------------- |
| `service.type`             | Kubernetes service type exposing port           | `NodePort`                                  |
| `service.port`             | TCP Port for this service                       | `8080`                                      |
| `service.nodePort`         | If Service is a NodePort, specifies nodePort number  | `30007`                                |
| `replicaCount`             | If you need more than 1 replica and don't use horizontal_pod_autoscaling | `1`                |
| `horizontal_pod_autoscaling`  | If you need more than 1 replica and don't use replicaCount    |                            |
| `horizontal_pod_autoscaling.enabled`  | Conveniently enable/disable HPA      | `false`                                     |
| `horizontal_pod_autoscaling.minReplicas`  | HPA minimum number of pod replicas    | `1`                                    |
| `horizontal_pod_autoscaling.maxReplicas`  | HPA maximum number of pod replicas    | `3`                                    |
| `horizontal_pod_autoscaling.targetCPUUtilizationPercentage`   | Deploy more pod replicas if CPU utilization % is above this value | `50`  |
| `podAnnotations`           | ( YAML object ) If you need additional Kubernetes Annotations for your pods            | `{}` |
| `podLabels`                | ( YAML object ) If you need additional Kubernetes Labels for your pods                 | `{}` |
| `debug`                    | Adds another container to the pod for debug purposes |                                        |
| `debug.enabled`            | Conveniently enable/disable debug container     | `false`                                     |
| `debug.image`              | Debug container image                           | `python:3.13.2-alpine3.21`                  |
| `image.registry`           | Image registry                                  | `ghcr.io`                                   |
| `image.repository`         | Image repository                                | `pracan`                                    |
| `image.name`               | Image name                                      | `docker-like-name-generator`                |
| `image.tag`                | Image tag                                       | `latest`                                    |
| `image.pullPolicy`         | Image pull policy                               | `IfNotPresent`                              |
| `editdefaultSecurityContext`  | Overwrites containers default UIDs and GIDs  |                                             |
| `editdefaultSecurityContext.webServerUID` | Overwrites the web-server container default UID   | `1001`                     |
| `editdefaultSecurityContext.appUID`   | Overwrites the docker-like-name-generator container default UID   | `1002`         |
| `editdefaultSecurityContext.groupForBoth` | Overwrites the default GID for both containers    | `3000`                     |
| `imagePullSecrets`         | ( YAML object ) If you need secrets for pulling an image from a private repository   | `[]`   |
| `livenessProbe`            | ( YAML object ) Configuration for liveness probe, simple httpGet probe provided  | [See source code](values.yaml) |
| `readinessProbe`           | ( YAML object ) Configuration for readiness probe, simple httpGet probe provided | [See source code](values.yaml) |
| `nameOverride`             | If not empty, overrides the chart name          | `""`                                        |
| `fullnameOverride`         | If not empty, overrides the release name and chart name  | `""`                               |
