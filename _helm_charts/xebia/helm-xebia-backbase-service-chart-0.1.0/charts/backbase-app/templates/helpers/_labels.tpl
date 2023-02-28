{{/*
Labels for selectors
*/}}
{{- define "backbase-app.match-labels" -}}
app.kubernetes.io/name: {{ include "backbase-app.name" . }}
app.kubernetes.io/instance: {{ include "backbase-app.fullname" . }}
app.kubernetes.io/part-of: {{ .Release.Name }}
{{- end -}}

{{/*
Labels for selectors
*/}}
{{- define "backbase-app.match-labels-as-selector" -}}
app.kubernetes.io/name={{ include "backbase-app.name" . }},app.kubernetes.io/instance={{ include "backbase-app.fullname" . }},app.kubernetes.io/part-of={{ .Release.Name }}
{{- end -}}

{{/*
Metadata labels
*/}}
{{- define "backbase-app.metadata-labels" -}}
{{- $metadata := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.app.metadata) (mergeOverwrite (dict) .Values.app.metadata) -}}
{{- range $key, $value := $metadata -}}
{{- if $value }}
app.backbase.com/{{ $key }}: "{{ $value }}"
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "backbase-app.labels" -}}
helm.sh/chart: {{ include "backbase-app.chart" . }}
{{ include "backbase-app.match-labels" . }}
{{ include "backbase-app.metadata-labels" . }}
{{- end -}}

{{/*
Extra labels for POD
*/}}
{{- define "backbase-app.pod-extra-labels" -}}
{{- $podExtraLabels := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.podExtraLabels) (mergeOverwrite (dict) .Values.podExtraLabels) -}}
{{- if $podExtraLabels -}}
{{ tpl (toYaml $podExtraLabels | trim) . }}
{{- end -}}
{{- end -}}

{{/*
Extra annotations for POD
*/}}
{{- define "backbase-app.pod-extra-annotations" -}}
{{- $podExtraAnnotations := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.podExtraAnnotations) (mergeOverwrite (dict) .Values.podExtraAnnotations) -}}
{{- if $podExtraAnnotations -}}
{{ tpl (toYaml $podExtraAnnotations) . }}
{{- end -}}
{{- end -}}

{{/*
Service Account Annotations
*/}}
{{- define "backbase-app.sa-annotations" -}}
{{- $metadata := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.serviceAccount.annotations) (mergeOverwrite (dict) .Values.serviceAccount.annotations) -}}
{{- range $key, $value := $metadata -}}
{{- if $value }}
{{ $key }}: "{{ $value }}"
{{- end -}}
{{- end -}}
{{- end -}}
