# Valheim Server Helm Chart

I found a pretty good docker container for hosting Valheim servers in docker.
I used the Docker container described in [this article](https://hackersvanguard.com/valheim-dedicated-server-on-kubernetes/) to create a helm chart.

## TBD

* Readyness Checks
* Configurable Service Ports !?
* Split data and backup volume

## Installation

Read the documentation for the Docker container above. Also check the described Values below for configuration options.
Install the Chart:
```
helm repo add denktmit https://schmidtdenktmit.github.io/charts/
helm install <RELEASE_NAME> denktmit/<CHARTNAME>
```

### Values

| Parameter | Description | Default |
|---|---|---|
| image.repository | Image repository url | lloesche/valheim-server (tested multiple containers but this one has the best features) |
| image.pullPolicy | Image pull policy | IfNotPresent |
| image.pullSecrets | It will store the repository's credentials to pull image | nil |
| env.SERVER_NAME | The name of your server that will be shwon in the server browser | MyKubernetesValheim |
| env.WORLD_NAME| The name of your generated world | World |
| env.SERVER_PASS| password for joining your server | secret |
| env.SERVER_PORT| The port of your server. This should not be changed at the moment. Somehow the container needs the same ports that are used for public access. Might be fixed later. | 32456 |
| env.BACKUPS_INTERVAL| Backup Interval in sseconds | 3600 |
| env.BACKUPS_DIRECTORY| Backup Directory | /config/backups |
| env.BACKUPS_MAX_AGE| Backup Retention Time in Days | 7 |
| env.UPDATE_INTERVAL| Update check interval in seconds | 900 |
| env.BACKUPS_DIRECTORY_PERMISSIONS| backup directory permisssions | 755 |
| env.CONFIG_DIRECTORY_PERMISSIONS| config directory permisssions | 755 |
| env.WORLDS_DIRECTORY_PERMISSIONS| world directory permisssions | 755 |
| env.WORLDS_FILE_PERMISSIONS| world file permisssions | 644 |
| env.BACKUPS_FILE_PERMISSIONS| world file permisssions | 644 |
| persistence.enabled | needs to be enable to save your world data | true |
| persistence.storageClass | storage class to be used | ""  (default) |
| persistence.size | volume size for server data | 50Gi |







