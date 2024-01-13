# Charts - InvenTree


## Parameters

### Global parameters

| Name                      | Description                                       | Value |
| ------------------------- | ------------------------------------------------- | ----- |
| `global.imageRegistry`    | Global container image registry                   | `""`  |
| `global.imagePullSecrets` | Global container image pull secret                | `[]`  |
| `global.storageClass`     | Global storageClass to use for persistent volumes | `""`  |

### Common parameters

| Name                | Description                                                                              | Value     |
| ------------------- | ---------------------------------------------------------------------------------------- | --------- |
| `kubeVersion`       | Force target Kubernetes version (using Helm capabilities if not set)                     | `""`      |
| `nameOverride`      | String to partially override inventree.fullname include (will maintain the release name) | `""`      |
| `fullnameOverride`  | String to fully override inventree.fullname template                                     | `""`      |
| `commonLabels`      | Add labels to all the deployed resources                                                 | `{}`      |
| `commonAnnotations` | Add annotations to all the deployed resources                                            | `{}`      |
| `tolerations`       | Tolerations for pod assignment                                                           | `[]`      |
| `affinity`          | Affinity for pod assignment                                                              | `{}`      |
| `imageRegistry`     | Container registry to use for all Inventree images                                       | `ghcr.io` |

### Inventree parameters


### Workers parameters

| Name                         | Description                                                                                                      | Value                              |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| `workers.enabled`            |                                                                                                                  | `true`                             |
| `workers.nameOverride`       | String to partially override inventree.fullname include (will maintain the release name)                         | `""`                               |
| `workers.fullnameOverride`   | String to fully override inventree.fullname template                                                             | `""`                               |
| `workers.commonLabels`       | Add labels to all the deployed resources                                                                         | `{}`                               |
| `workers.commonAnnotations`  | Add annotations to all the deployed resources                                                                    | `{}`                               |
| `workers.tolerations`        | Tolerations for pod assignment                                                                                   | `[]`                               |
| `workers.affinity`           | Affinity for pod assignment                                                                                      | `{}`                               |
| `workers.imageRegistry`      | Container registry to use for all Inventree images                                                               | `ghcr.io`                          |
| `workers.image.registry`     | inventree worker image registry                                                                                  | `REGISTRY_NAME`                    |
| `workers.image.repository`   | inventree worker image repository                                                                                | `REPOSITORY_NAME/inventree worker` |
| `workers.image.digest`       | inventree worker image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                               |
| `workers.image.pullPolicy`   | inventree worker image pull policy                                                                               | `IfNotPresent`                     |
| `workers.image.pullSecrets`  | Specify docker-registry secret names as an array                                                                 | `[]`                               |
| `workers.command`            | Override default container command (useful when using custom images)                                             | `[]`                               |
| `workers.args`               | Override default container args (useful when using custom images)                                                | `[]`                               |
| `workers.extraEnvVars`       | Extra environment variables to be set on Inventree containers                                                    | `[]`                               |
| `workers.extraEnvVarsCM`     | ConfigMap with extra environment variables                                                                       | `""`                               |
| `workers.extraEnvVarsSecret` | Secret with extra environment variables                                                                          | `""`                               |

### Inventree deployment parameters

| Name                   | Description                            | Value |
| ---------------------- | -------------------------------------- | ----- |
| `workers.replicaCount` | Number of Inventree replicas to deploy | `1`   |

### Storage parameters

| Name                                         | Description                                                                        | Value       |
| -------------------------------------------- | ---------------------------------------------------------------------------------- | ----------- |
| `externalDatabase.enabled`                   | Set to true to use an external database                                            | `false`     |
| `externalDatabase.type`                      | Type of the external database for inventree (`mysql`/`postgresql`)                 | `""`        |
| `externalDatabase.host`                      | Hostname of the database                                                           | `""`        |
| `externalDatabase.port`                      | Port of the database                                                               | `3306`      |
| `externalDatabase.database`                  | Name of the database                                                               | `inventree` |
| `externalDatabase.username`                  | Username to use for the database                                                   | `inventree` |
| `externalDatabase.password`                  | Password to use for the database                                                   | `""`        |
| `externalDatabase.existingSecret`            | Name of the secret containing the database credentials                             | `""`        |
| `externalDatabase.existingSecretDatabaseKey` | Key in the secret containing the database name                                     | `database`  |
| `externalDatabase.existingSecretUsernameKey` | Key in the secret containing the database username                                 | `username`  |
| `externalDatabase.existingSecretPasswordKey` | Key in the secret containing the database password                                 | `password`  |
| `externalRedis.enabled`                      | Set to true to use an external Redis instance (ignored if `redis.enabled` is true) | `false`     |
| `externalRedis.host`                         | Hostname of the external Redis instance                                            | `""`        |
| `externalRedis.port`                         | Port of the external Redis instance                                                | `6379`      |
| `externalRedis.adminQuotaDbId`               | Redis database ID for the quota storage on the admin pod                           | `1`         |
| `externalRedis.adminRateLimitDbId`           | Redis database ID for the rate limit storage on the admin pod                      | `2`         |
| `externalRedis.rspamdDbId`                   | Redis database ID for the rspamd storage on the rspamd pod                         | `0`         |

### PostgreSQL parameters

| Name                                                | Description                                                                                                                                                                                               | Value                  |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| `postgresql.enabled`                                | Enable PostgreSQL deployment                                                                                                                                                                              | `false`                |
| `postgresql.architecture`                           | PostgreSQL architecture. Allowed values: standalone or replication                                                                                                                                        | `standalone`           |
| `postgresql.auth.enablePostgresUser`                | Assign a password to the "postgres" admin user. Otherwise, remote access will be blocked for this user                                                                                                    | `true`                 |
| `postgresql.auth.postgresPassword`                  | Password for the "postgres" admin user. Ignored if `auth.existingSecret` with key `postgres-password` is provided                                                                                         | `postgres`             |
| `postgresql.auth.username`                          | Name for a custom user to create                                                                                                                                                                          | `inventree`            |
| `postgresql.auth.password`                          | Password for the custom user to create. Ignored if `auth.existingSecret` with key `password` is provided                                                                                                  | `""`                   |
| `postgresql.auth.database`                          | Name for a custom database to create                                                                                                                                                                      | `inventree`            |
| `postgresql.auth.existingSecret`                    | Use existing secret for password details (`auth.postgresPassword`, `auth.password` will be ignored and picked up from this secret). The secret has to contain the keys `postgres-password` and `password` | `""`                   |
| `postgresql.auth.secretKeys.adminPasswordKey`       | Name of key in existing secret to use for PostgreSQL credentials. Only used when `auth.existingSecret` is set.                                                                                            | `postgres-password`    |
| `postgresql.auth.secretKeys.userPasswordKey`        | Name of key in existing secret to use for PostgreSQL credentials. Only used when `auth.existingSecret` is set.                                                                                            | `password`             |
| `postgresql.auth.secretKeys.replicationPasswordKey` | Name of key in existing secret to use for PostgreSQL credentials. Only used when `auth.existingSecret` is set.                                                                                            | `replication-password` |
| `postgresql.primary.persistence.enabled`            | Enable PostgreSQL Primary data persistence using PVC                                                                                                                                                      | `true`                 |
| `postgresql.primary.persistence.existingClaim`      | Name of an existing PVC to use                                                                                                                                                                            | `""`                   |
| `postgresql.primary.persistence.storageClass`       | PVC Storage Class for PostgreSQL Primary data volume                                                                                                                                                      | `""`                   |
| `postgresql.primary.persistence.accessModes`        | PVC Access Mode for PostgreSQL volume                                                                                                                                                                     | `["ReadWriteOnce"]`    |
| `postgresql.primary.persistence.size`               | PVC Storage Request for PostgreSQL volume                                                                                                                                                                 | `8Gi`                  |
| `postgresql.primary.persistence.annotations`        | Annotations for the PVC                                                                                                                                                                                   | `{}`                   |
| `postgresql.primary.persistence.labels`             | Labels for the PVC                                                                                                                                                                                        | `{}`                   |
| `postgresql.primary.persistence.selector`           | Selector to match an existing Persistent Volume (this value is evaluated as a template)                                                                                                                   | `{}`                   |
| `postgresql.primary.persistence.dataSource`         | Custom PVC data source                                                                                                                                                                                    | `{}`                   |

### Redis parameters

| Name                                     | Description                                                                                                | Value                   |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ----------------------- |
| `redis.enabled`                          | Enable redis deployment through the redis subchart                                                         | `true`                  |
| `redis.architecture`                     | Redis architecture. Allowed values: `standalone` or `replication`                                          | `standalone`            |
| `redis.auth.enabled`                     | DON'T CHANGE THIS VALUE. Mailu doesn't support Redis authentication                                        | `false`                 |
| `redis.master.enabled`                   | DON'T CHANGE THIS VALUE. Enable redis master                                                               | `true`                  |
| `redis.master.count`                     | Number of redis master replicas                                                                            | `1`                     |
| `redis.master.persistence.enabled`       | Enable persistence using Persistent Volume Claims                                                          | `true`                  |
| `redis.master.persistence.size`          | Pod pvc size                                                                                               | `8Gi`                   |
| `redis.master.persistence.storageClass`  | Pod pvc storage class                                                                                      | `""`                    |
| `redis.master.persistence.accessModes`   | Pod pvc access modes                                                                                       | `["ReadWriteOnce"]`     |
| `redis.master.persistence.annotations`   | Pod pvc annotations                                                                                        | `{}`                    |
| `redis.master.persistence.existingClaim` | Pod pvc existing claim; necessary if using single_pvc                                                      | `""`                    |
| `redis.master.persistence.subPath`       | Subpath in PVC; necessary if using single_pvc (set it to `/redis`)                                         | `""`                    |
| `redis.replica.count`                    | Number of redis replicas (only if `redis.architecture=replication`)                                        | `0`                     |
| `redis.image.registry`                   | Redis&reg; image registry                                                                                  | `REGISTRY_NAME`         |
| `redis.image.repository`                 | Redis&reg; image repository                                                                                | `REPOSITORY_NAME/redis` |
| `redis.image.tag`                        | Redis&reg; image tag (immutable tags are recommended)                                                      | `7.2.4`                 |
| `redis.image.digest`                     | Redis&reg; image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                    |
| `redis.image.pullPolicy`                 | Redis&reg; image pull policy                                                                               | `IfNotPresent`          |
| `redis.image.pullSecrets`                | Redis&reg; image pull secrets                                                                              | `[]`                    |

### Proxy parameters

| Name                                 | Description                                                                                           | Value                       |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------- | --------------------------- |
| `proxy.enabled`                      | Enable nginx proxy through nginx subchart.                                                            | `false`                     |
| `proxy.nameOverride`                 | String to partially override nginx.fullname template (will maintain the release name)                 | `""`                        |
| `proxy.fullnameOverride`             | String to fully override nginx.fullname template                                                      | `""`                        |
| `proxy.namespaceOverride`            | String to fully override common.names.namespace                                                       | `""`                        |
| `proxy.kubeVersion`                  | Force target Kubernetes version (using Helm capabilities if not set)                                  | `""`                        |
| `proxy.clusterDomain`                | Kubernetes Cluster Domain                                                                             | `cluster.local`             |
| `proxy.extraDeploy`                  | Extra objects to deploy (value evaluated as a template)                                               | `[]`                        |
| `proxy.commonLabels`                 | Add labels to all the deployed resources                                                              | `{}`                        |
| `proxy.commonAnnotations`            | Add annotations to all the deployed resources                                                         | `{}`                        |
| `proxy.replicaCount`                 | Number of NGINX replicas to deploy                                                                    | `1`                         |
| `proxy.image.registry`               | NGINX image registry                                                                                  | `REGISTRY_NAME`             |
| `proxy.image.repository`             | NGINX image repository                                                                                | `REPOSITORY_NAME/nginx`     |
| `proxy.image.digest`                 | NGINX image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                        |
| `proxy.image.pullPolicy`             | NGINX image pull policy                                                                               | `IfNotPresent`              |
| `proxy.image.pullSecrets`            | Specify docker-registry secret names as an array                                                      | `[]`                        |
| `proxy.extraEnvVars`                 | Extra environment variables to be set on NGINX containers                                             | `[]`                        |
| `proxy.extraEnvVarsCM`               | ConfigMap with extra environment variables                                                            | `""`                        |
| `proxy.extraEnvVarsSecret`           | Secret with extra environment variables                                                               | `""`                        |
| `proxy.podLabels`                    | Additional labels for NGINX pods                                                                      | `{}`                        |
| `proxy.podAnnotations`               | Annotations for NGINX pods                                                                            | `{}`                        |
| `proxy.podAffinityPreset`            | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                   | `""`                        |
| `proxy.podAntiAffinityPreset`        | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`              | `soft`                      |
| `proxy.nodeAffinityPreset.type`      | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`             | `""`                        |
| `proxy.nodeAffinityPreset.key`       | Node label key to match Ignored if `affinity` is set.                                                 | `""`                        |
| `proxy.nodeAffinityPreset.values`    | Node label values to match. Ignored if `affinity` is set.                                             | `[]`                        |
| `proxy.affinity`                     | Affinity for pod assignment                                                                           | `{}`                        |
| `proxy.extraVolumes`                 | Array to add extra volumes                                                                            | `[]`                        |
| `proxy.extraVolumeMounts`            | Array to add extra mount                                                                              | `[]`                        |
| `proxy.serverBlock`                  | Custom server block to be added to NGINX configuration                                                | `""`                        |
| `proxy.existingServerBlockConfigmap` | ConfigMap with custom server block to be added to NGINX configuration                                 | `inventree-proxy-prod-conf` |
| `proxy.staticSiteConfigmap`          | Name of existing ConfigMap with the server static site content                                        | `""`                        |
| `proxy.staticSitePVC`                | Name of existing PVC with the server static site content                                              | `""`                        |

### Traffic Exposure parameters

| Name                                     | Description                                                                                 | Value          |
| ---------------------------------------- | ------------------------------------------------------------------------------------------- | -------------- |
| `proxy.service.type`                     | Service type                                                                                | `LoadBalancer` |
| `proxy.service.ports.http`               | Service HTTP port                                                                           | `80`           |
| `proxy.service.ports.https`              | Service HTTPS port                                                                          | `443`          |
| `proxy.service.nodePorts`                | Specify the nodePort(s) value(s) for the LoadBalancer and NodePort service types.           | `{}`           |
| `proxy.service.targetPort`               | Target port reference value for the Loadbalancer service types can be specified explicitly. | `{}`           |
| `proxy.service.clusterIP`                | NGINX service Cluster IP                                                                    | `""`           |
| `proxy.service.loadBalancerIP`           | LoadBalancer service IP address                                                             | `""`           |
| `proxy.service.loadBalancerSourceRanges` | NGINX service Load Balancer sources                                                         | `[]`           |
| `proxy.service.loadBalancerClass`        | service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)    | `""`           |
| `proxy.service.extraPorts`               | Extra ports to expose (normally used with the `sidecar` value)                              | `[]`           |
| `proxy.service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                        | `None`         |
| `proxy.service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                 | `{}`           |
| `proxy.service.annotations`              | Service annotations                                                                         | `{}`           |
| `proxy.service.externalTrafficPolicy`    | Enable client source IP preservation                                                        | `Cluster`      |
