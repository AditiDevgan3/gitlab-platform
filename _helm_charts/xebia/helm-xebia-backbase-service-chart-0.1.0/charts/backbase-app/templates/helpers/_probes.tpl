{{/*
Startup probe
*/}}
{{- define "backbase-app.startup-probe" -}}
{{- $startupProbe := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.startupProbe) (mergeOverwrite (dict) .Values.startupProbe) -}}
{{- if $startupProbe.enabled }}
{{- with $startupProbe }}
startupProbe:
  httpGet:
    path: {{ .path }}
    port: {{ .port }}
    scheme: {{ .scheme }}
  initialDelaySeconds: {{ .initialDelaySeconds }}
  failureThreshold: {{ .failureThreshold }}
  periodSeconds: {{ .periodSeconds }}
  timeoutSeconds: {{ .timeoutSeconds }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Liveness probe
*/}}
{{- define "backbase-app.liveness-probe" -}}
{{- $livenessProbe := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.livenessProbe) (mergeOverwrite (dict) .Values.livenessProbe) -}}
{{- if $livenessProbe.enabled }}
{{- with $livenessProbe }}
livenessProbe:
  httpGet:
    path: {{ .path }}
    port: {{ .port }}
    scheme: {{ .scheme }}
  initialDelaySeconds: {{ .initialDelaySeconds }}
  failureThreshold: {{ .failureThreshold }}
  periodSeconds: {{ .periodSeconds }}
  timeoutSeconds: {{ .timeoutSeconds }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Readiness probe
*/}}
{{- define "backbase-app.readiness-probe" -}}
{{- $readinessProbe := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.readinessProbe) (mergeOverwrite (dict) .Values.readinessProbe) -}}
{{- if $readinessProbe.enabled }}
{{- with $readinessProbe }}
readinessProbe:
  httpGet:
    path: {{ .path }}
    port: {{ .port }}
    scheme: {{ .scheme }}
  initialDelaySeconds: {{ .initialDelaySeconds }}
  failureThreshold: {{ .failureThreshold }}
  periodSeconds: {{ .periodSeconds }}
  timeoutSeconds: {{ .timeoutSeconds }}
{{- end -}}
{{- end -}}
{{- end -}}
