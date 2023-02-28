{{/*
Expand the application name.
*/}}
{{- define "backbase-app.name" -}}
{{- if .Values.app.name }}
  {{- .Values.app.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
  {{- fail "\n\nA valid .Values.app.name entry required!" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the base part of full name.
*/}}
{{- define "backbase-app.basename" -}}
{{- $releaseName := .Release.Name -}}
{{- $chartName := .Values.global.chartName | default "" -}}
{{- if $chartName -}}
  {{- if hasSuffix $chartName $releaseName -}}
    {{- printf "%s" $releaseName -}}
  {{- else -}}
    {{- printf "%s-%s" $releaseName $chartName -}}
  {{- end -}}
{{- else -}}
  {{- printf "%s" $releaseName -}}
{{- end -}}
{{- end -}}

{{/*
Expand the full name.
*/}}
{{- define "backbase-app.fullname" -}}
{{- $baseName := include "backbase-app.basename" . -}}
{{- $appName := include "backbase-app.name" . -}}
{{- $fullName := printf "%s-%s" $baseName $appName -}}
{{- if gt (len $fullName) 64 -}}
  {{- fail "\n\nFull name too long, try to reduce release name!" -}}
{{- else -}}
  {{- printf "%s" $fullName -}}
{{- end -}}
{{- end -}}

{{/*
backbase-app chart name and version
*/}}
{{- define "backbase-app.chart" -}}
{{- printf "%s-%s" "backbase-app" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
