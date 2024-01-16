{{/*
Create a default fully qualified dependency name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
Usage:
{{ include "inventree.names.dependency.fullname" (dict "chartName" "dependency-chart-name" "chartValues" .Values.dependency-chart "context" $) }}
*/}}
{{- define "inventree.names.dependency.fullname" -}}
  {{- if .chartValues.fullnameOverride -}}                        \\ ""
    {{- .chartValues.fullnameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}} 
    {{- $cName := default .context.Chart.Name .context.Values.fullnameOverride }}
    {{- $name := default .chartName .chartValues.nameOverride }}
    {{- printf "%s-%s"  $cName $name | trunc 63 | trimSuffix "-" }}
  {{- end -}}
{{- end -}}


{{- define "inventree.names.master.fullname" -}}
{{ include "common.names.dependency.fullname" (dict "chartName" "master" "chartValues" .Values.master "context" $) }}
{{- end -}}

{{- define "inventree.names.workers.fullname" -}}
{{ include "common.names.dependency.fullname" (dict "chartName" "worker" "chartValues" .Values.workers "context" $) }}
{{- end -}}

