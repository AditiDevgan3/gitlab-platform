# backbase-app

![Version: 0.24.2](https://img.shields.io/badge/Version-0.24.2-informational?style=flat-square)

A Common Helm Chart that represents typical Backbase Java Application based on Spring Boot.
This chart should be used in other [umbrella](https://helm.sh/docs/charts_tips_and_tricks/#complex-charts-with-many-dependencies) charts as a [dependency](https://helm.sh/docs/developing_charts/#chart-dependencies) with [alias](https://helm.sh/docs/developing_charts/#alias-field-in-requirements-yaml).
This chart is highly dependent on Helm [global values](https://helm.sh/docs/developing_charts/#global-values) functionality.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq | object | `{}` | JMS / ActiveMQ related configuration.  See `global.activemq` for more details of the available options |
| activemqEnvVarsMap | object | `{}` | JMS / ActiveMQ env var map related configuration.  See `global.activemqEnvVarsMap` for more details of the available options |
| additionalContainers | list | `[]` | Additional containers. This is useful when working with proxies and sidecars. Container definition will printed as Yaml and passed trough the tpl function. |
| app.image | object | `{"tagFrom":""}` | Docker image reference for application container; of form `registry/repository:tag` |
| app.image.tagFrom | string | `""` | Reference to key name in `.global` scope (`.Values.global.keyname`). Key value will be used as Docker image tag. Must be string, no nesting. When specified - `image.tag` value will be ignored. |
| app.metadata | object | `{}` | Metadata labels to apply to the Pod definition.  Keys prefixed with `app.backbase.com/` |
| app.name | string | `"backbase-application"` | Application name, mandatory.  Will be used as main container name in Pod |
| app.ports | list | `[{"name":"http","port":8080}]` | Kubernetes port definitions to apply to the Pod's main container |
| app.resources.cpu.maxShares | int | `1000` | (int) Amount of shares of a CPU unit to limit to (where 1000=1 CPU). |
| app.resources.cpu.minShares | int | `100` | (int) Amount of shares of a CPU unit to request (where 1000=1 CPU). |
| app.resources.memory.containerReserve | int | `0` | (int) Extra memory reserved for container use (in Mi unit). |
| app.resources.memory.ram | int | `512` | (int) Amount of container memory resource to request (in Mi unit). This results in a Kubernetes memory resource request on the Pod defintion. |
| bbclient | object | `{}` | Token converter OIDC client credential configuration. See `global.bbclient` for more details of the available options |
| bbclientEnvVarsMap | object | `{}` | Token converter OIDC env var map related configuration.  See `global.bbclientEnvVarsMap` for more details of the available options |
| customFiles | object | `{}` | Allows for some small text payloads to be mounted as files that are accessible to the containers.  Typically used to deploy some additional config file. Note that this is not a recommended approach; the use of environment variables is preferred. A `ConfigMap` will be generated taking this object's keys as filename and values as the content.  The `ConfigMap` will be mounted at `customFilesPath`. |
| customFilesPath | string | `"/customfiles/"` | Path where custom files `ConfigMap` entries will be mounted.  See `customFiles` |
| database | object | `{}` | Database related configuration.  See `global.database` for more details of the available options |
| databaseEnvVarsMap | object | `{}` | Database env var map related configuration.  See `global.databaseEnvVarsMap` for more details of the available options |
| debug.suspend | string | `"n"` | Suspend process on startup (`y` or `n`) |
| env | object | `{}` | Key-value pairs representing [environment variables for application container](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). It is possible to use templates as value here (will be evaluated using tpl function) |
| global.activemq.checkEnabled | bool | `false` | if enabled - an `initContainer` with activemq check will be added to Pod |
| global.activemq.checkInitContainerCpu | string | `"100m"` | initContainer CPU allocation set for limit and requests |
| global.activemq.checkInitContainerImage | string | `"busybox"` | Container Image to use for the check type as specified by checkType |
| global.activemq.checkInitContainerMemory | string | `"100Mi"` | initContainer memory allocation set for limit and requests |
| global.activemq.checkType | string | `"netcat"` | Type of check - `curl` / `netcat` / `nslookup` |
| global.activemq.enabled | bool | `false` | If enabled - will set corresponding JMS/ActiveMQ environment variables: `SPRING_ACTIVEMQ_BROKER_URL, SPRING_ACTIVEMQ_USER, SPRING_ACTIVEMQ_PASSWORD` |
| global.activemq.existingSecret | string | `""` | Name of external kubernetes secret with activemq values |
| global.activemq.existingSecretKey | string | `"ACTIVEMQ_PASSWORD"` | data key in existing kubernetes secret to reference as `SPRING_ACTIVEMQ_PASSWORD` value |
| global.activemq.host | string | `"activemq"` | ActiveMQ host |
| global.activemq.password | string | `"CHANGEME"` | ActiveMQ password.  Will be used if `existingSecret` not specified |
| global.activemq.port | int | `61616` | ActiveMQ JMS port |
| global.activemq.urlTemplate | string | `""` | Custom URL template.  Template must reference values in `.activemq` scope: `tcp://{{.activemq.host}}:{{.activemq.port}}` |
| global.activemq.username | string | `"admin"` | ActiveMQ username |
| global.activemqEnvVarsMap.PASSWORD | string | `"SPRING_ACTIVEMQ_PASSWORD"` | Active MQ Broker password environment variable name |
| global.activemqEnvVarsMap.URL | string | `"SPRING_ACTIVEMQ_BROKER_URL"` | Active MQ Broker URL environment variable name |
| global.activemqEnvVarsMap.USERNAME | string | `"SPRING_ACTIVEMQ_USER"` | Active MQ Broker username environment variable name |
| global.affinity | object | `{}` | Kuberenetes [Affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) |
| global.app.image | object | `{"pullPolicy":"IfNotPresent","registry":"","repository":"","tag":""}` | Docker image reference for application container; of form `registry/repository:tag` |
| global.app.image.pullPolicy | string | `"IfNotPresent"` | [Pull policy](https://kubernetes.io/docs/concepts/containers/images/#updating-images) for docker image |
| global.app.image.registry | string | `""` | Docker [registry](https://microsoft.github.io/AzureTipsAndTricks/blog/tip57.html#docker-registry-vs-docker-repository) (optional) name. `registry` and `repository` will be concatenated using `/` if `registry` is provided, otherwise `repository` will be used |
| global.app.image.repository | string | `""` | Docker [repository](https://microsoft.github.io/AzureTipsAndTricks/blog/tip57.html#docker-registry-vs-docker-repository) (mandatory) name. `registry` and `repository` will be concatenated using `/` if `registry` is provided, otherwise `repository` will be used |
| global.app.image.tag | string | `""` | Docker image tag |
| global.app.metadata | object | `{}` | key-value pairs used for additional `app.backbase.com/key: value` labels for deployments |
| global.bbclient.clientIdFromSecret | bool | `false` | If clientIdFromSecret is true - `bb-client-id` data field from existingSecret will be used for the env variable `backbase.communication.http.client-id` |
| global.bbclient.clientIdValue | string | `"bb-client"` | If clientIdFromSecret is false - this clientIdValue will be used for the env variable `backbase.communication.http.client-id` |
| global.bbclient.clientSecretFromSecret | bool | `false` | If clientSecretFromSecret is true - `bb-client-secret` data field from existingSecret will be used for the env variable `backbase.communication.http.client-secret` |
| global.bbclient.clientSecretValue | string | `"bb-secret"` | If clientSecretFromSecret is false - this clientSecretValue will be used for the env variable `backbase.communication.http.client-secret` |
| global.bbclient.enabled | bool | `false` | If enabled - will set corresponding oidc client environment variables |
| global.bbclient.existingSecret | string | `""` | Name of external Kubernetes secret. Should contain the following data fields: `bb-client-id, bb-client-secret` |
| global.bbclientEnvVarsMap | object | `{"CLIENTID":"backbase.communication.http.client-id","CLIENTSECRET":"backbase.communication.http.client-secret"}` | Use this to map default bbclient environment variable names to alternatives. For example, this will set var name `keycloak.backbase.oidc-token-converter.client-id` instead of `backbase.communication.http.client-id`:   bbclientEnvVarsMap:     CLIENTID: "keycloak.backbase.oidc-token-converter.client-id" |
| global.bbclientEnvVarsMap.CLIENTID | string | `"backbase.communication.http.client-id"` | Client ID environment variable name |
| global.bbclientEnvVarsMap.CLIENTSECRET | string | `"backbase.communication.http.client-secret"` | Client secret environment variable name |
| global.chartName | string | `""` | Reference to umbrella chart name. |
| global.database.checkEnabled | bool | `false` | if enabled - initContainer with database check will be added to Pod |
| global.database.checkInitContainerCpu | string | `"100m"` | initContainer CPU allocation set for limit and requests |
| global.database.checkInitContainerImage | string | `"busybox"` | Container Image to use for the check type as specified by `checkType` |
| global.database.checkInitContainerMemory | string | `"100Mi"` | initContainer memory allocation set for limit and requests |
| global.database.checkType | string | `"netcat"` | Type of check - `curl` / `netcat` / `nslookup` |
| global.database.enabled | bool | `false` | If enabled - will set corresponding database environment variables: `SPRING_DATASOURCE_URL, SPRING_DATASOURCE_USERNAME, SPRING_DATASOURCE_PASSWORD, SPRING_DATASOURCE_DRIVER_CLASS_NAME` |
| global.database.existingSecret | string | `""` | Name of external kubernetes secret with database values |
| global.database.existingSecretKey | string | `"mysql-password"` | Data key in existing kubernetes secret to reference as `SPRING_DATASOURCE_PASSWORD` value |
| global.database.host | string | `"mysql"` | Database host |
| global.database.parameters | object | `{"mariadb":"","mssql":"","mysql":"","oracle":""}` | JDBC URL database parameters |
| global.database.parameters.mariadb | string | `""` | MariaDB JDBC URL database parameters to be appended to the end of the URL.  Should begin with a parameter separator. |
| global.database.parameters.mssql | string | `""` | MSSQL JDBC URL database parameters to be appended to the end of the URL.  Should begin with a parameter separator. |
| global.database.parameters.mysql | string | `""` | MySQL JDBC URL database parameters to be appended to the end of the URL.  Should begin with a parameter separator. |
| global.database.parameters.oracle | string | `""` | Oracle JDBC URL database parameters to be appended to the end of the URL.  Should begin with a parameter separator. |
| global.database.password | string | `"CHANGEME"` | Database password.  Will be used if `existingSecret` not specified |
| global.database.port | int | `3306` | Database port |
| global.database.sid | string | `""` | Database name/SID |
| global.database.type | string | `"mysql"` | Database type.  Supported values: mysql / mariadb / oracle / mssql |
| global.database.urlTemplate | string | `""` | Custom Database URL template. Template must reference values in .database scope: `db://{{.database.host}}:{{.database.port}}/{{.database.sid}}{{.database.parameters.mysql}}?useSSL=true` |
| global.database.username | string | `"backbase"` | Database username |
| global.databaseEnvVarsMap.DRIVER_CLASS_NAME | string | `"SPRING_DATASOURCE_DRIVER_CLASS_NAME"` | Spring DataSource driver class environment variable name |
| global.databaseEnvVarsMap.PASSWORD | string | `"SPRING_DATASOURCE_PASSWORD"` | Spring DataSource password environment variable name |
| global.databaseEnvVarsMap.URL | string | `"SPRING_DATASOURCE_URL"` | Spring DataSource URL environment variable name |
| global.databaseEnvVarsMap.USERNAME | string | `"SPRING_DATASOURCE_USERNAME"` | Spring DataSource username environment variable name |
| global.debug.address | string | `"*"` | binding address, could be `*` or `0.0.0.0` |
| global.debug.enabled | bool | `false` | if enabled - will set corresponding properties in `JAVA_OPTS` |
| global.debug.javaOpts | list | `["-agentlib:jdwp=transport=dt_socket,server=y,suspend={{.Values.debug.suspend}},address={{.Values.global.debug.address}}:{{.Values.global.debug.port}}"]` | List of debug properties to add to `JAVA_OPTS` |
| global.debug.port | int | `5005` | debug port |
| global.defaultAffinity | bool | `true` | If true, applies a default anti-affinity policy. We use `preferredDuringScheduling` aka soft affinity type to make sure that pods will be spread between the different nodes. |
| global.env | object | `{}` | Key-value pairs representing [environment variables for application container](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). It is possible to use templates as value here (will be evaluated using tpl function). |
| global.hostAliases | list | `[]` | Adding entries to a Pod's /etc/hosts file provides Pod-level override of hostname resolution when DNS and other options are not applicable. |
| global.imagePullSecrets | list | `[]` | Kubernetes [Image Pull Secrets](https://kubernetes.io/docs/concepts/containers/images/#referring-to-an-imagepullsecrets-on-a-pod) |
| global.ingress | object | `{"annotations":{},"baseDomain":""}` | Kubernetes Ingress |
| global.ingress.annotations | object | `{}` | Global annotations |
| global.ingress.baseDomain | string | `""` | If set FQDN will be constructed like host.baseDomain |
| global.initContainers | list | `[]` | Global Kubernetes [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Will not be merged with local counterparts |
| global.javaOpts.base | list | `["-XX:MaxRAMPercentage=60.0","-XX:+UseContainerSupport"]` | Default options; used to construct JAVA_OPTS environment variable. Avoid altering, use extra list to add customization. Max ram percentage is supported for the latest JDK's and JRE's. |
| global.javaOpts.base[0] | string | `"-XX:MaxRAMPercentage=60.0"` | See https://docs.oracle.com/javase/8/docs/technotes/tools/unix/java.html. Sets the maximum amount of memory that the JVM may use for the Java heap before applying ergonomics heuristics as a percentage of the maximum amount determined as described in the -XX:MaxRAM option. The default value (if not specified) is 25 percent. |
| global.javaOpts.base[1] | string | `"-XX:+UseContainerSupport"` | See https://docs.oracle.com/javase/8/docs/technotes/tools/unix/java.html The VM provides automatic container detection support, which enables the VM to determine the amount of memory and number of processors that are available to a Java process running in docker containers. It uses this information to allocate system resources. |
| global.javaOpts.envVarName | string | `"JAVA_TOOL_OPTIONS"` | The environment variable that will be used to expose the java opts. |
| global.javaOpts.extra | list | `["-Dlogging.level.root=WARN","-Dlogging.level.com.backbase=WARN"]` | Extra options appended to the Java Options environment variable. This list will be appended to `javaOpts.base`. |
| global.jmx.enabled | bool | `false` | if enabled - will set corresponding properties in `JAVA_OPTS` |
| global.jmx.javaOpts | list | `["-Dcom.sun.management.jmxremote","-Dcom.sun.management.jmxremote.authenticate=false","-Dcom.sun.management.jmxremote.ssl=false","-Dcom.sun.management.jmxremote.local.only=false","-Dcom.sun.management.jmxremote.port={{.Values.global.jmx.port}}","-Dcom.sun.management.jmxremote.rmi.port={{.Values.global.jmx.port}}","-Djava.rmi.server.hostname=127.0.0.1"]` | List of JMX properties to add to `JAVA_OPTS` |
| global.jmx.port | int | `1098` | jmx port |
| global.jwt.EXTERNAL_ENC_SECRET_KEY_fromSecret | bool | `false` | if true, `jwt-external-enc-secretkey` data field from `existingSecret` will be used as the `EXTERNAL_ENC_SECRET_KEY` environment variable value |
| global.jwt.EXTERNAL_ENC_SECRET_KEY_value | string | `""` | If `EXTERNAL_ENC_SECRET_KEY_fromSecret` is false, this value will be used as the `EXTERNAL_ENC_SECRET_KEY` environment variable. |
| global.jwt.EXTERNAL_SIG_SECRET_KEY_fromSecret | bool | `false` | If true, `jwt-external-secretkey` data field from `existingSecret` will be used as the `EXTERNAL_SIG_SECRET_KEY` environment variable value. |
| global.jwt.EXTERNAL_SIG_SECRET_KEY_value | string | `""` | If `EXTERNAL_SIG_SECRET_KEY_fromSecret` is false, this value will be used as the `EXTERNAL_SIG_SECRET_KEY` environment variable. |
| global.jwt.SIG_SECRET_KEY_fromSecret | bool | `false` | if true, `jwt-internal-secretkey` data field from `existingSecret` will be used as the `SIG_SECRET_KEY` environment variable value. |
| global.jwt.SIG_SECRET_KEY_value | string | `""` | If `SIG_SECRET_KEY_fromSecret` is false, this value will be used as the `SIG_SECRET_KEY` environment variable. |
| global.jwt.USERCTX_KEY_fromSecret | bool | `false` | If true, `userctx-key` data field from `existingSecret` will be used as the `USERCTX_KEY` environment variable value |
| global.jwt.USERCTX_KEY_value | string | `""` | If `USERCTX_KEY_fromSecret` equals false, this value will be used as the `USERCTX_KEY_value` environment variable. |
| global.jwt.enabled | bool | `false` | If enabled, sets JWT-related environment variables |
| global.jwt.existingSecret | string | `""` | Name of external kubernetes secret with JWT values. Should contain following data fields: `jwt-internal-secretkey, jwt-external-secretkey, jwt-external-enc-secretkey, userctx-key` |
| global.lifecycle.prestopTimeout | int | `10` | Timeout before sending sigterm to pod, needed to remove k8s endpoints |
| global.lifecycle.terminationGracePeriodSeconds | int | `60` | Duration in seconds the pod needs to terminate gracefully |
| global.lifecycle.timeoutPerShutdownPhase | string | `"50s"` | Specify the maximum time allotted for the shutdown of any phase (group of SmartLifecycle beans with the same `phase` value). Value set on `spring.lifecycle.timeout-per-shutdown-phase` environment variable |
| global.liquibase.changelogLocation | string | `"classpath:db/changelog/db.changelog-persistence.xml"` | The location of the Liquibase change log file |
| global.liquibase.enabled | bool | `false` | If true, configures an InitContainer to apply the Liquibase database change set on startup |
| global.liquibase.env | object | `{"SPRING_LIQUIBASE_ENABLED":"true"}` | Key-value pairs representing environment variables for the Liquibase initContainer.  These will override values for env vars  specified on the main deployment (i.e. `global.env` or `env`).  See `global.env` for examples on how to set these. |
| global.liquibase.initArgsOverride | list | `[]` | List of init arguments that will be passed after `command`` section, each argument must be in "" |
| global.liquibase.initMainClass | string | `"'com.backbase.buildingblocks.auxiliaryconfig.InitContainerApplication'"` | The SSDK main class to run to apply the Liquibase change log |
| global.liquibase.password | string | `""` | The DB password to be used by Liquibase when applying the change set |
| global.liquibase.username | string | `""` | The DB username to be used by Liquibase when applying the change set |
| global.livenessProbe.enabled | bool | `false` | if true, enables the Kubernetes [liveness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) for the main container. |
| global.livenessProbe.failureThreshold | int | `3` | When a probe fails, Kubernetes will try `failureThreshold` times before giving up. Giving up in case of liveness probe means restarting the container.  Minimum value is 1 |
| global.livenessProbe.initialDelaySeconds | int | `90` | Number of seconds after the container has started before probes are initiated. Minimum value is 0. |
| global.livenessProbe.path | string | `"/actuator/health/liveness"` | The HTTP path exposed by the container that the probe should request |
| global.livenessProbe.periodSeconds | int | `15` | How often (in seconds) to perform the probe. Minimum value is 1. |
| global.livenessProbe.port | string | `"http"` | The port exposed by the container that the probe should connect to |
| global.livenessProbe.scheme | string | `"HTTP"` | The URL scheme exposed by the container that the probe should request |
| global.livenessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. Minimum value is 1. |
| global.nodeSelector | object | `{}` | Kubernetes [nodeSelector](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector) |
| global.persistence.storageClass | string | `""` | Global Storage Class |
| global.podDisruptionBudget | object | `{}` | Kubernetes [Pod Disruption Budget](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/#pod-disruption-budgets) |
| global.podExtraAnnotations | object | `{}` | Key-value pairs of additional Pod [annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). It is possible to use templates here (will be evaluated using tpl function) |
| global.podExtraLabels | object | `{}` | Key-value pairs of additional Pod [labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). It is possible to use templates here (will be evaluated using tpl function) |
| global.podSecurityContext | object | `{}` | Kubernetes [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| global.priorityClassName | string | `""` | Kubernetes [PriorityClass name](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/#pod-priority) |
| global.rbac.create | bool | `true` | (bool) Specifies whether RBAC resources should be created |
| global.rbac.role.rules | list | `[{"apiGroups":[""],"resources":["configmaps","pods","services","endpoints"],"verbs":["get","list","watch"]}]` | Rules to create. It follows the Kubernetes [Role specification](https://v1-18.docs.kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole) |
| global.readinessProbe.enabled | bool | `false` | if true, enables the Kubernetes [readiness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) for the main container. |
| global.readinessProbe.failureThreshold | int | `3` | When a probe fails, Kubernetes will try `failureThreshold` times before giving up. Giving up in case of readiness probe will be marked the Pod as Unready.  Minimum value is 1 |
| global.readinessProbe.initialDelaySeconds | int | `90` | Number of seconds after the container has started before probes are initiated. Minimum value is 0. |
| global.readinessProbe.path | string | `"/actuator/health/readiness"` | The HTTP path exposed by the container that the probe should request |
| global.readinessProbe.periodSeconds | int | `15` | How often (in seconds) to perform the probe. Minimum value is 1. |
| global.readinessProbe.port | string | `"http"` | The port exposed by the container that the probe should connect to |
| global.readinessProbe.scheme | string | `"HTTP"` | The URL scheme exposed by the container that the probe should request |
| global.readinessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. Minimum value is 1. |
| global.registry.checkEnabled | bool | `false` | if enabled - an `initContainer` with registry check will be added to Pod |
| global.registry.checkInitContainerCpu | string | `"100m"` | initContainer CPU allocation set for limit and requests |
| global.registry.checkInitContainerImage | string | `"byrnedo/alpine-curl"` | Container Image to use for the check type as specified by checkType |
| global.registry.checkInitContainerMemory | string | `"200Mi"` | initContainer memory allocation set for limit and requests |
| global.registry.checkType | string | `"curl"` | Type of check - curl / netcat / nslookup |
| global.registry.enabled | bool | `false` | If enabled - `registry.envVarNameDefaultZone` environment variable will be set for Pod based on protocol/host/port/path values: `protocol://host:port/path` |
| global.registry.envVarNameDefaultZone | string | `"eureka.client.serviceUrl.defaultZone"` | This name will be used to publish the environment variable for the default zone. |
| global.registry.envVarNamePreferIpAddress | string | `"EUREKA_INSTANCE_PREFERIPADDRESS"` | This name will be used in the environment variable to publish the prefer ip address. |
| global.registry.host | string | `"registry"` | registry host |
| global.registry.path | string | `"/eureka/"` | registry base path |
| global.registry.port | int | `8080` | registry port |
| global.registry.preferIpAddress | bool | `true` | Will set [eureka.instance.preferIpAddress](https://cloud.spring.io/spring-cloud-netflix/multi/multi_spring-cloud-eureka-server.html#spring-cloud-eureka-server-prefer-ip-address) environment variable to true |
| global.registry.protocol | string | `"http"` | protocol - http or https |
| global.replicaCount | int | `1` | Number of replicas for Deployment. |
| global.service.additionalPorts | list | `[]` | additional ports to expose on this Service |
| global.service.enabled | bool | `false` | if enabled, will create a Kubernetes Service resource for this deployment |
| global.service.nameOverride | string | `""` | name of the Kubernetes Service.  If not specified, this chart will generate a name by convention |
| global.service.port | int | `8080` | which port to listen to |
| global.service.portName | string | `"http"` | name of the listening port |
| global.service.targetPort | string | `"http"` | target port of the downstream backends servicing the actual request |
| global.service.type | string | `"ClusterIP"` | how the [Service is published](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) |
| global.serviceAccount.annotations | object | `{}` | The annotations to use for the service account. |
| global.serviceAccount.create | bool | `false` | Specifies whether a Kubernetes `ServiceAccount` should be created |
| global.serviceAccount.name | string | `""` | The name of the `ServiceAccount` to use. If not set and `create` is true, a name is generated using the fullname template. If not set and `create` is false (but `rbac.create` is enabled) `default` will be used. |
| global.startupProbe.enabled | bool | `false` | if true, enables the Kubernetes [startup probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-startup-probes) for the main container. |
| global.startupProbe.failureThreshold | int | `40` | When a probe fails, Kubernetes will try `failureThreshold` times before giving up. Giving up in case of startup probe means killing the container. Minimum value is 1 |
| global.startupProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before probes are initiated. Minimum value is 0. |
| global.startupProbe.path | string | `"/actuator/health/liveness"` | The HTTP path exposed by the container that the probe should request |
| global.startupProbe.periodSeconds | int | `15` | How often (in seconds) to perform the probe. Minimum value is 1. |
| global.startupProbe.port | string | `"http"` | The port exposed by the container that the probe should connect to |
| global.startupProbe.scheme | string | `"HTTP"` | The URL scheme exposed by the container that the probe should request |
| global.startupProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. Minimum value is 1. |
| global.strategy | object | `{}` | Kubernetes [Deployment Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy). If `strategy` is not set and `replicaCount=1`, then default to a `RollingUpdate` strategy with `maxUnavailable: 0`. |
| global.volumeMounts | list | `[]` | Global volumeMounts Will not be merged with local counterparts |
| global.volumes | list | `[]` | Global volumes Will not be merged with local counterparts |
| hostAliases | list | `[]` | Adding entries to a Pod's /etc/hosts file provides Pod-level override of hostname resolution when DNS and other options are not applicable. |
| ingress.annotations | object | `{}` | Annotations to apply to the Ingress resource |
| ingress.enabled | bool | `false` | If true, configures a Kubernetes Ingress resource for this deployment |
| ingress.hosts | list | `[{"customPaths":[],"host":"backbase.local","paths":[]}]` | Defines the routes for the hosts managed by this ingress.  The Service generated by this deployment will be used as the Backend. |
| ingress.hosts[0] | object | `{"customPaths":[],"host":"backbase.local","paths":[]}` | If `global.ingress.baseDomain` is set - host field represent host part of FQDN |
| ingress.hosts[0].customPaths | list | `[]` | Custom paths to prepend to every host configuration. This is useful when working with annotation based services. - path: /*   backend:     serviceName: ssl-redirect     servicePort: use-annotation |
| ingress.hosts[0].paths | list | `[]` | Kubernetes Ingress path definitions.  The Service generated by this deployment will be used as the Backend for each path specified here. |
| ingress.tls | list | `[]` | TLS configuration for this Ingress; as defined https://kubernetes.io/docs/concepts/services-networking/ingress/#tls |
| initContainers | list | `[]` | Additional [initContainers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) |
| javaOpts.extra | list | `[]` | Extra options appended to the Java Options environment variable. This list will be appended to `javaOpts.base`. |
| jmx | object | `{}` | JMX related configuration.  See `global.jmx` for more details of the available options |
| jwt | object | `{}` | JWT related environment variables for Pod.  Overrides the values defined in `globals.jwt`. See `global.jwt` for more details of the available options |
| lifecycle | object | `{}` | Application lifecycle related configuration.  See `global.lifecycle` for more details of the available options |
| liquibase | object | `{}` | Liquibase related configuration.  See `global.liquibase` for more details of the available options |
| livenessProbe | object | `{}` | Kubernetes [Liveness Probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| nodeSelector | object | `{}` | Kubernetes [nodeSelector](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector) |
| persistence.accessMode | string | `"ReadWriteOnce"` | AccessMode to set on the new Persistent Volume Claim |
| persistence.enabled | bool | `false` | If true, will create and mount a '*-data' Volume in the deployment spec. The value of `persistence.existingClaim` determines if this is a new or pre-existing Persistent Volume Claim. |
| persistence.existingClaim | string | `""` | If empty and `persistence.enabled=true`, will create a new Persistent Volume Claim for the deployment. If not empty, will use specified, pre-existing PVC name when defining the volume and not create a new Persistent Volume Claim. |
| persistence.mountPath | string | `"/data"` | Path of the volume mount in the container |
| persistence.mountSubPath | string | `""` | Sub-path of the volume mount in the container |
| persistence.size | string | `"1Gi"` | Size of the Persistent Volume Claim. |
| persistence.storageClass | string | `""` | If set to "-", storageClass: "", which disables dynamic provisioning If empty or undefined - no storageClass spec is set, choosing the default provisioner.  See `global.persistence` |
| podExtraAnnotations | object | `{}` | Key-value pairs of additional Pod [annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). It is possible to use templates here (will be evaluated using tpl function). |
| podExtraLabels | object | `{}` | Key-value pairs of additional Pod [labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). It is possible to use templates here (will be evaluated using tpl function). |
| podSecurityContext | object | `{}` | Kubernetes [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| priorityClassName | string | `""` | Kubernetes [PriorityClass name](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/#pod-priority) |
| rbac.create | bool | `nil` | Specifies if RBAC resources should be created |
| rbac.role | object | `{"rules":[]}` | Kubernetes [Role specification](https://v1-18.docs.kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole) |
| rbac.role.rules | list | `[]` | Rules to create. It follows the role specification rules:  - apiGroups:      - extensions    resources:      - podsecuritypolicies    verbs:      - use |
| readinessProbe | object | `{}` | Kubernetes [Readiness Probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| registry | object | `{}` | Netflix Eureka service discovery registry configuration.  See `global.registry` for more details of the available options |
| replicaCount | int | `1` | Number of replicas for Deployment. |
| securityContext | object | `{}` | Kubernetes [container security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) If specified, this is only applied to the `main` container |
| service | object | `{}` | Kubernetes Service configuration.  See `global.service` for more details of the available configuration |
| serviceAccount.annotations | object | `{}` | The annotations to use for the service account. |
| serviceAccount.create | bool | `nil` | Specifies whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the fullname template. If not set and create is false (but rbac creation is enabled) "default" will be used. |
| startupProbe | object | `{}` | Kubernetes [Startup Probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-startup-probes) |
| strategy | object | `{}` | Kubernetes [Deployment Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy). If `strategy` is not set and `replicaCount=1`, then default to a `RollingUpdate` strategy with `maxUnavailable: 0`. |
| tolerations | list | `[]` | Kubernetes [Tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) |
| volumeMounts | list | `[]` | Custom volume mounts |
| volumes | list | `[]` | Custom volumes |
