# Changelog
## [0.1.3]
- ability to mount custom files

## [0.1.4]
- extra labels and annotations for Pods

## [0.1.5]
- common env vars for jwt/activemq/database things

## [0.2.0]
- big refactoring
- flatten many values
- subservice overrides for capability chart globals, values supported:
  - `application.metadata`
  - `application.image.tag`
  - `env`
  - `podExtraLabels`
  - `podExtraAnnotations`
  - `javaOpts.extra`
  - `jmx`
  - `debug`
  - `jwt`
  - `registry`
  - `activemq`
  - `database`
- `envFrom` support removed
- `env` now dict (was list)
- `application.metadata.name` moved to `application.name`

## [0.2.1]
- new `application.repository` property (global and local)
- ability to remap database/activemq environment variables to different names (`databaseEnvVarsMap/activemqEnvVarsMap`)

## [0.2.2]
- refactoring
- README.md update
- NOTES.txt update
- default values.yaml documentation
- global nodeSelector
- removed '?useSSL=false' for mysql database url
- added mssql database type
- new database.urlTemplate value
- fix for check initContainers names

## [0.2.3]
- application.image.tagFrom support

## [0.2.4]
- chartnameOverride

## [0.2.5]
- urlTemplate for activemq

## [0.2.6]
- MariaDB support

## [0.3.0]
- `application` property renamed to just `app`
- `resources` property removed, now calculated based on new `app.resources` property
- fix for Oracle database connect string
- better Java memory management (Xms/Xmx/MaxRam)
- persistant storage support (PVC)

## [0.3.1]
  - `chartnameOverride`removed
  - changed logic of `fullname` generation

## [0.4.0]
- `global.service`
- `global.volumes` and `global.volumeMounts` (will not merge with locals)
- `global.initContainers` (will not merge with locals)
- dicts can be used as values for Environment Variables
- imagePullSecrets bug fixed (use `global.imagePullSecrets`)

## [0.4.1]
- global `livenessProbe`/`readinessProbe`
- configurable `schema` and `failureThreshold` for probes

## [0.4.2]
- Updates health check from production-support to actuator

## [0.5.0]
- proper Ingress apiVersion for later k8s versions
- global `ingress.annotations`
- global `ingress.baseDomain`
- `ingress.hosts.*.customPaths` support

## [0.6.0]
- Changed environment variables for the following variables:
  - eureka.client.serviceUrl.defaultZone
    - EUREKA_CLIENT_SERVICEURL_DEFAULTZONE
  - eureka.instance.preferIpAddress
    - EUREKA_INSTANCE_PREFERIPADDRESS

## [0.6.1]
- Added possibility to change the eureka default zone environment variable
- Added possibility to change the javaOpts variable
- Changed default to be JAVA_TOOL_OPTIONS (from JAVA_OPT)

## [0.7.0]
- Removed the memory configuration in favor of the -XX:MaxRAMPercentage option in combination with -XX:+UseContainerSupport
- For upgrading: change your `app.resources.memory.xmx` to `app.resources.memory.ram`. You can remove any xmx/xms related configuration.

## [0.8.0]
- Kubernetes RBAC support (service account, role, role binding)

## [0.8.1]
- Main deployment container now have fixed name `main`

## [0.9.0]
- Added possibility to add more containers to a pod using the property `additionalContainers`

## [0.10.0]
- Pod PriorityClass support

## [0.11.0]
- probes paths adjusted to `/actuator/health/liveness` and `/actuator/health/readiness` to reflect latest SSDK changes
- bug with wrong PersistentVolumeClaim name fixed

## [0.12.0]
- Deployment Strategy support

## [0.12.1]
- bug with extra whitespace template, PersistentVolumeClaim name fixed

## [0.12.2]
- bug with rendering NOTES.txt when using Loadbalancer service type

## [0.13.0]
- Add additional service ports

## [0.14.0]
- Pod Security Context support
- BREAKING CHANGE: additionalContainers implementation using toYaml/tpl
- Default logging level configuration moved from `global.javaOpts.base` to `global.javaOpts.extra`
- Refactoring and documentation improvements

## [0.14.1]
- RBAC enabled by default

## [0.15.0]
- Including pod hostAliases support

## [0.16.0]
- Add support for using startup probes

## [0.17.0]
- add imagePullPolicy for startup check initContainers

## [0.18.0]
- add possibility to enable default podAntiAffinity by enabling `defaultAffinity: true`
- add possibility to enable PodDisruptionBudget

## [0.18.1]
- Increasing the default value for startupProbe initialDelaySeconds to 30 seconds

## [0.18.2]
- add CHANGELOG.md
- add helm-docs generation
- pre-commit fixes

## [0.18.3]
- force label values to be strings, see https://github.com/kubernetes/kubernetes/issues/23251

## [0.18.4]
- expose debugging port and disabled probes when debugging has been enabled

## [0.18.5]
- Updating deprecated oracle driver class name for database configuration.

## [0.19.0]
- Add liquibase init container.

## [0.19.1]
- Make init container image configurable for netcat, nslookup and curl checkTypes

## [0.19.2]
- Add lifecycle preStop handler to main container spec, to properly handle graceful shutdown

## [0.19.3]
- Tweaks and improvements to allow generation of usable helm-doc README.md

## [0.19.4]
- Adding SA annotations

## [0.20.0]
-  Enabled default `preferredDuringScheduling` podAntiAffinity

## [0.21.0]
- Reduce maxRamPercentage to 60% to account for the containerReserve that should not be touched by the app.

## [0.22.0]
- Liquibase init container to use the same pull policy as main container.

## [0.23.0]
- Added token converter override values for OIDC client credentials

## [0.23.1]
- Added "args" to deployment template

## [0.23.2]
- Fixed the use of `global.app.image.repository`

## [0.23.3]
- Set `containerReserve` default to 0 as a positive value impacts k8s pod QoS. The reserve is not actually a reserve for container.
- it is an addition to memory limit (not requests) and when using maxRamPercentage, as we do, it does not provide the container with reserve memory.

## [0.23.4]
- Added "SPRING_LIQUIBASE_ENABLED=true" to Liquibase init-container specific environment variables

## [0.23.5]
- Update Ingress template apiVersion to use networking.k8s.io/v1

## [0.23.6]
- Remove rogue space from backbase-app `debug.suspend` documentation comment

## [0.23.7]
- Add option to override init arguments

## [0.23.8]
- Assign CPU and Memory resources to activeMQ, Registry and Database check init containers (to achieve guaranteed k8s QoS)

## [0.23.9]
- custom env vars for containers are also added to liquibase init-container

## [0.23.10]
- Change templating to allow volume mounts on init containers
## [0.23.11]
- Add customFiles volumeMount to liquibase init container
## [0.23.12]
- Add environment variable overrides for liquibase init container

## [0.23.13]
- Fix to docs

## [0.23.14]
- Support JARs for Liquibase init container

## [0.23.15]
- Add database.parameters to JDBC URL template

## [0.24.0]
- Disable liquibase in the main container if liquibase.enabled=true

## [0.24.1]
- Clarification of docs related to change: Disable liquibase in the main container if liquibase.enabled=true

## [0.24.2]
- Documented the securityContext value
