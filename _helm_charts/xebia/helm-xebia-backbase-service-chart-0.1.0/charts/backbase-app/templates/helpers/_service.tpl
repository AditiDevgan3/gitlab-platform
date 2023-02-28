{{- define "backbase-app.service-name" }}
{{- if (.Values.service.nameOverride | default "") }}
{{- .Values.service.nameOverride }}
{{- else }}
{{- include "backbase-app.fullname" . }}
{{- end -}}
{{- end -}}
