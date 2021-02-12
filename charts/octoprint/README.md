# This is a Helmchart for Octoprint 

I was able to run this on a Raspberry Pi 4 Cluster running K3s with dedicated IoT nodes.
You need to read the documentation carefully because you need to configure everything (including your nodes) correctly.

Thanks to [nunofgs](https://github.com/nunofgs) for his work on an [ARM compatible docker image for Octoprint](https://github.com/nunofgs/docker-octoprint).

## Tested Setups

| Device | Camera | Kubernetes Distribution | Status |
|---|---|---|---|
| Raspberry PI 4| Rnaspberry Pi Camera | K3s (v1.17.2) | Tested  ✅  |


## Installation / Configuration:

Read this part carefully and prepare your values otherwise you will have no access!
Then run:

```
helm install octokube --namespace octoprint -f your-values.yaml ./ 
```

NOTE: Do not use octoprint as release name (see: Known Issues) 

### NodeSelector
If you are running a Kubernetes Cluster with more than one node you need to configure a Node Selector to make sure your
octoprint is running on the node that is connected to your printer.

Simply label your node with:

```bash
kubectl label nodes my-worker printer-worker=my-printer
```
### Access from the internet

Do not expose your octoprint instance if you are not sure what you are doing! 

There are two ways to secure your octoprint instance.
1. Enable Octoprint User Management on first start
2. Enable Basicauth during deployment (see: Variables). Secret can be generated with the following command:
```
htpasswd -nb <username> <password> | base64`
```

In case you want to make your instance accesable from the internet I recommand using both. You will also need Ingress to be installed. 
The default settings for ingress in this chart are tested with traefik.

### Variables

| Parameter | Description | Default |
|---|---|---|
| image.repository | Image repository url | nunofgs/octoprint |
| image.pullPolicy | Image pull policy | IfNotPresent |
| image.pullSecrets | It will store the repository's credentials to pull image | nil |
| livenessProbe.path | Liveness probe path  | "/" |
| livenessProbe.port | Liveness probe path  | http |
| readinessProbe.path | Readiness probe path | "/" |
| readinessProbe.port | Readiness probe port | http |
| service.type | Backend service type | ClusterIP |
| service.port | Backend service port | 5000 |
| videoservice.type | Video service type | ClusterIP |
| videoservice.port | Video service port | 5000 |

## Known Issues:

### Do not install the chart with the following command:

```
helm install octoprint ...
```
This release name causes kubernetes to create environment variables that affect the startup of octoprint.

### Octoprint container needs privileged rights

I know this is never a good Idea but currently I was not able to access the camera or usb without privileged rights.
I am looking forward to solve this by mounting them somehow.
