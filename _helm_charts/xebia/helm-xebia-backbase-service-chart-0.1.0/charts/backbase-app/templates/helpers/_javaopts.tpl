{{/*
Memory JAVA_OPTS (Xms/Xmx)
*/}}


{{/*
Base JAVA_OPTS
*/}}
{{- define "backbase-app.java-opts-base" -}}
{{ tpl (join " " .Values.global.javaOpts.base) . }}
{{- end -}}

{{/*
Extra JAVA_OPTS
*/}}
{{- define "backbase-app.java-opts-extra" -}}
{{- $extraJavaOpts := list -}}
{{- range $idx, $globalItem := .Values.global.javaOpts.extra }}
{{- $extraJavaOpts = append $extraJavaOpts $globalItem -}}
{{- end -}}
{{- range $idx, $LocalItem := .Values.javaOpts.extra }}
{{- $extraJavaOpts = append $extraJavaOpts $LocalItem -}}
{{- end -}}
{{ tpl (join " " (uniq $extraJavaOpts)) . }}
{{- end -}}

{{/*
Debug JAVA_OPTS
*/}}
{{- define "backbase-app.java-opts-debug" -}}
{{ tpl (join " " .Values.global.debug.javaOpts) . }}
{{- end -}}

{{/*
Remote JMX JAVA_OPTS
*/}}
{{- define "backbase-app.java-opts-jmx" -}}
{{ tpl (join " " .Values.global.jmx.javaOpts) . }}
{{- end -}}

{{/*
JAVA_OPTS
*/}}
{{- define "backbase-app.java-opts" -}}
{{- $javaOpts := list (include "backbase-app.java-opts-base" .) -}}
{{- if .Values.jmx.enabled -}}
{{- $javaOpts = append $javaOpts (include "backbase-app.java-opts-jmx" .) -}}
{{- else if .Values.global.jmx.enabled -}}
{{- if not (eq (.Values.jmx.enabled | toString) "false")  }}
{{- $javaOpts = append $javaOpts (include "backbase-app.java-opts-jmx" .) -}}
{{- else -}}
{{- end -}}
{{- end -}}
{{- if .Values.debug.enabled -}}
{{- $javaOpts = append $javaOpts (include "backbase-app.java-opts-debug" .) -}}
{{- else if .Values.global.debug.enabled -}}
{{- if not (eq (.Values.debug.enabled | toString) "false") -}}
{{- $javaOpts = append $javaOpts (include "backbase-app.java-opts-debug" .) -}}
{{- else -}}
{{- end -}}
{{- end -}}
{{- if or .Values.javaOpts.extra .Values.global.javaOpts.extra -}}
{{- $javaOpts = append $javaOpts (include "backbase-app.java-opts-extra" .) -}}
{{- end -}}
- name: "{{ .Values.global.javaOpts.envVarName }}"
  value: {{ printf "%s" (join " " (uniq $javaOpts)) | quote }}
{{- end -}}
