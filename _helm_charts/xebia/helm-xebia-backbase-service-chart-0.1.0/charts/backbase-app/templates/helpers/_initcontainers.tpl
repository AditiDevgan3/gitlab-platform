{{- define "backbase-app.init-container.check-curl" -}}
- name: {{ .serviceName }}-curl-check
  resources:
    requests:
      cpu: {{ .checkInitContainerCpu }}
      memory: {{ .checkInitContainerMemory }}
    limits:
      cpu: {{ .checkInitContainerCpu }}
      memory: {{ .checkInitContainerMemory }}
  image: {{ .checkInitContainerImage }}
  imagePullPolicy: IfNotPresent
  command:
    - sh
    - -c
    - until curl --connect-timeout 5 {{ .protocol }}://{{ .host }}{{ if .port }}:{{ .port }}{{ end }}{{ .path | default "/" }}; do echo "Waiting for the {{ .host }}..."; sleep 5; done
{{- end -}}

{{- define "backbase-app.init-container.check-netcat" -}}
- name: {{ .serviceName }}-netcat-check
  resources:
    requests:
      cpu: {{ .checkInitContainerCpu }}
      memory: {{ .checkInitContainerMemory }}
    limits:
      cpu: {{ .checkInitContainerCpu }}
      memory: {{ .checkInitContainerMemory }}
  image: {{ .checkInitContainerImage }}
  imagePullPolicy: IfNotPresent
  command:
    - sh
    - -c
    - until nc -w 5 {{ .host }} {{ .port }}; do echo "Waiting for the {{ .host }}..."; sleep 5; done
{{- end -}}

{{- define "backbase-app.init-container.check-nslookup" -}}
- name: {{ .serviceName }}-nslookup-check
  resources:
    requests:
      cpu: {{ .checkInitContainerCpu }}
      memory: {{ .checkInitContainerMemory }}
    limits:
      cpu: {{ .checkInitContainerCpu }}
      memory: {{ .checkInitContainerMemory }}
  image: {{ .checkInitContainerImage }}
  imagePullPolicy: IfNotPresent
  command:
    - sh
    - -c
    - until nslookup {{ .host }}; do echo "Waiting for the {{ .host }}..."; sleep 5; done
{{- end -}}

{{/*
Custom environment variables; based on `backbase-app.env-vars` but overwites some key env vars to make sure
they are not overriden from the main chart env vars
*/}}
{{- define "backbase-app.liquibase-merged-env-vars" -}}
{{- $envVars := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.env) (mergeOverwrite (dict) .Values.env) (.Values.global.liquibase.env | default dict) (.Values.liquibase.env | default dict) -}}
{{- range $envVarName, $envVarValue := $envVars }}
{{- if typeIs "string" $envVarValue }}
- name: {{ $envVarName | quote }}
  value: {{ tpl $envVarValue $ | quote }}
{{- else if typeIs "map[string]interface {}" $envVarValue }}
- name: {{ $envVarName | quote }}
{{- tpl ( toYaml $envVarValue ) $ | nindent 2 }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "backbase-app.init-container.liquibase" -}}
- name: {{ .liquibaseSettings.serviceName }}
  image: {{ include "backbase-app.image-ref" . }}
  imagePullPolicy: {{ include "backbase-app.image-pullpolicy" . }}
  {{- if or .Values.global.volumeMounts .Values.volumeMounts .Values.customFiles }}
  volumeMounts:
    {{- if .Values.global.volumeMounts }}
    {{- tpl (toYaml .Values.global.volumeMounts) . | nindent 4 }}
    {{- end }}
    {{- if .Values.volumeMounts }}
    {{- tpl (toYaml .Values.volumeMounts) . | nindent 4 }}
    {{- end }}
    {{- if .Values.customFiles }}
    {{- range $key, $val := .Values.customFiles }}
    - name: customfiles
      mountPath: {{ $.Values.customFilesPath }}{{ $key }}
      subPath: {{ $key }}
    {{- end }}
    {{- end }}
  {{- end }}
  {{- include "backbase-liquibase-arguments" . | nindent 2}}
  env:
{{- $liquibaseCreds := coalesce .Values.liquibase.username .Values.global.liquibase.username false -}}
{{- if $liquibaseCreds -}}
    {{- include "backbase-app.init-liquibase.env-vars" . | nindent 4 }}
{{- else }}
    {{- include "backbase-app.database.env-vars" . | nindent 4 }}
{{- end -}}
    {{- include "backbase-app.liquibase-merged-env-vars" . | nindent 4 }}
{{- end -}}

{{- define "backbase-liquibase-arguments" }}
{{- if .liquibaseSettings.initArgsOverride -}}
command: [ 'java' ]
args:
  {{- range .liquibaseSettings.initArgsOverride }}
  - {{ . }}
  {{- end }}
{{- else }}
command: [ 'java' ]
args: ['-cp', '/app/extras/*:/app/WEB-INF/classes:/app/WEB-INF/lib/*:/app/classes:/app/libs/*', {{ .liquibaseSettings.initMainClass }} ]
{{- end -}}
{{- end -}}

{{- define "backbase-app.init-containers" -}}
{{- $fakeRootContext := $ -}}
{{- $registrySettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.registry) (mergeOverwrite (dict) .Values.registry) -}}
{{- $_ := set $registrySettings "serviceName" "registry" -}}
{{- $activemqSettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.activemq) (mergeOverwrite (dict) .Values.activemq) -}}
{{- $_ := set $activemqSettings "serviceName" "activemq" -}}
{{- $databaseSettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.database) (mergeOverwrite (dict) .Values.database) -}}
{{- $_ := set $databaseSettings "serviceName" "database" -}}
{{- $liquibaseSettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.liquibase) (mergeOverwrite (dict) .Values.liquibase) (mergeOverwrite (dict) .Values.global.app.image) (mergeOverwrite (dict) .Values.app.image) -}}
{{- $_ := set $liquibaseSettings "serviceName" "init-liquibase" -}}
{{- $_ := set $fakeRootContext  "liquibaseSettings" $liquibaseSettings -}}
{{- if or .Values.global.initContainers .Values.initContainers $registrySettings.checkEnabled $activemqSettings.checkEnabled $databaseSettings.checkEnabled $liquibaseSettings.enabled -}}
initContainers:
{{- if .Values.global.initContainers -}}
{{ tpl (toYaml .Values.global.initContainers) . | nindent 2 }}
{{- end -}}
{{- if .Values.initContainers -}}
{{ tpl (toYaml .Values.initContainers) . | nindent 2 }}
{{- end -}}
{{- if and $registrySettings.enabled $registrySettings.checkEnabled -}}
{{- $checkTemplateName := printf "%s-%s" "backbase-app.init-container.check" $registrySettings.checkType -}}
{{ include $checkTemplateName $registrySettings | nindent 2 }}
{{- end -}}
{{- if and $activemqSettings.enabled $activemqSettings.checkEnabled -}}
{{- $checkTemplateName := printf "%s-%s" "backbase-app.init-container.check" $activemqSettings.checkType -}}
{{ include $checkTemplateName $activemqSettings | nindent 2 }}
{{- end -}}
{{- if and $databaseSettings.enabled $databaseSettings.checkEnabled -}}
{{- $checkTemplateName := printf "%s-%s" "backbase-app.init-container.check" $databaseSettings.checkType -}}
{{ include $checkTemplateName $databaseSettings | nindent 2}}
{{- end -}}
{{- if and $databaseSettings.enabled $fakeRootContext.liquibaseSettings.enabled -}}
{{- $checkTemplateName := printf "%s" "backbase-app.init-container.liquibase" -}}
{{ include $checkTemplateName $fakeRootContext | nindent 2}}
{{- end -}}
{{- end -}}
{{- end -}}
