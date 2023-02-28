{{/* vim: set filetype=mustache: */}}
{{/*
Docker image tag
*/}}
{{- define "backbase-app.image-tag" -}}
{{- if .Values.app.image.tagFrom }}
{{- if hasKey .Values.global .Values.app.image.tagFrom }}
{{- printf "%s" (index .Values.global .Values.app.image.tagFrom) -}}
{{- else }}
{{- fail "Specified .Values.global key name for docker image tag does not exist!" -}}
{{- end -}}
{{- else -}}
{{- $imageSettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.app.image) (mergeOverwrite (dict) .Values.app.image) -}}
{{- printf "%s" (default "latest" $imageSettings.tag) -}}
{{- end -}}
{{- end -}}

{{/*
Docker image reference
*/}}
{{- define "backbase-app.image-ref" -}}
{{- $imageSettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.app.image) (mergeOverwrite (dict) .Values.app.image) -}}
{{- $appImageRepository := default "backbase/application" $imageSettings.repository -}}
{{- if $imageSettings.registry -}}
{{- printf "%s/%s:%s" $imageSettings.registry $appImageRepository ( include "backbase-app.image-tag" . ) -}}
{{- else -}}
{{- printf "%s:%s" $appImageRepository ( include "backbase-app.image-tag" . ) -}}
{{- end -}}
{{- end -}}

{{- define "backbase-app.image-pullpolicy" -}}
{{- $imageSettings := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.app.image) (mergeOverwrite (dict) .Values.app.image) -}}
{{- printf "%s" $imageSettings.pullPolicy -}}
{{- end -}}

{{/*
Kubernetes PriorityClass Name
*/}}
{{- define "backbase-app.priority-class-name" -}}
{{ printf "%s" ( .Values.priorityClassName | default .Values.global.priorityClassName ) }}
{{- end -}}

{{/*
Kubernetes ReplicaCount
*/}}
{{- define "backbase-app.replica-count" -}}
{{ printf "%d" (int ( .Values.replicaCount | default .Values.global.replicaCount )) }}
{{- end -}}

{{/*
Kubernetes Deployment Strategy
*/}}
{{- define "backbase-app.strategy" -}}
{{- $strategy := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.strategy) (mergeOverwrite (dict) .Values.strategy) -}}
{{- if $strategy -}}
{{- toYaml $strategy -}}
{{- else if eq .Values.replicaCount 1.0 -}}
type: RollingUpdate
rollingUpdate:
  maxUnavailable: 0
{{- end -}}
{{- end -}}

{{/*
Kubernetes nodeSelector
*/}}
{{- define "backbase-app.nodeselector" -}}
{{- $nodeSelector := mergeOverwrite (dict) (mergeOverwrite (dict) .Values.global.nodeSelector) (mergeOverwrite (dict) .Values.nodeSelector) -}}
{{- with $nodeSelector }}
{{- toYaml . }}
{{- end }}
{{- end -}}

{{/*
Kubernetes Storage Class
*/}}
{{- define "backbase-app.persistence.storage-class" -}}
{{ printf "%s" ( .Values.persistence.storageClass | default .Values.global.persistence.storageClass ) }}
{{- end -}}

{{/*
Kubernetes resources
*/}}
{{- define "backbase-app.kubernetes-resources" -}}
requests:
  cpu: {{ .cpu.minShares }}m
  memory: {{ .memory.ram }}Mi
limits:
  cpu: {{ .cpu.maxShares }}m
  memory: {{ add .memory.ram .memory.containerReserve }}Mi
{{- end -}}

{{/*
Kubernetes pod default AntiAffinity
*/}}
{{- define "backbase-app.default-pod-anti-affinity" -}}
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    podAffinityTerm:
      labelSelector:
        matchLabels: {{- include "backbase-app.match-labels" . | nindent 10 }}
      topologyKey: kubernetes.io/hostname
{{- end -}}

{{/*
Kubernetes affinity
*/}}
{{- define "backbase-app.affinity" -}}
{{- if and (.Values.global.affinity) (kindIs "invalid" .Values.affinity) -}}
{{- toYaml .Values.global.affinity -}}
{{- else if .Values.affinity -}}
{{- toYaml .Values.affinity -}}
{{- else if or (and (.Values.global.defaultAffinity) (kindIs "invalid" .Values.defaultAffinity)) .Values.defaultAffinity -}}
{{- include "backbase-app.default-pod-anti-affinity" . -}}
{{- end }}
{{- end -}}

{{/*
## Kubernetes podDisruptionBudget
*/}}
{{- define "backbase-app.pdb" -}}
{{- $podDisruptionBudget := default .Values.global.podDisruptionBudget .Values.podDisruptionBudget -}}
{{- with $podDisruptionBudget }}
{{- toYaml . }}
{{- end }}
{{- end -}}

{{/*
## Kubernetes lifecycle handler
*/}}
{{- define "backbase-app.lifecycle.prestopTimeout" -}}
{{- $prestopTimeout := default .Values.global.lifecycle.prestopTimeout .Values.lifecycle.prestopTimeout -}}
{{- printf "%s" (toString $prestopTimeout) -}}
{{- end -}}

{{/*
## Kubernetes lifecycle terminationGracePeriodSeconds
*/}}
{{- define "backbase-app.lifecycle.terminationGracePeriodSeconds" -}}
{{- $terminationGracePeriodSeconds := default .Values.global.lifecycle.terminationGracePeriodSeconds .Values.lifecycle.terminationGracePeriodSeconds -}}
{{- printf "%s" (toString $terminationGracePeriodSeconds) -}}
{{- end -}}
