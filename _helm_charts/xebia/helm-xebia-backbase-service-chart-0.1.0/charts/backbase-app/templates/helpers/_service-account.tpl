{{/*
Get the name of the service account to use
*/}}
{{- define "backbase-app.service-account-name" -}}
{{- $serviceAccount := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.serviceAccount) (mergeOverwrite (dict) .Values.serviceAccount) -}}
{{- if $serviceAccount.create -}}
{{ default (include "backbase-app.fullname" .) $serviceAccount.name }}
{{- else -}}
{{ default "default" $serviceAccount.name }}
{{- end -}}
{{- end -}}
