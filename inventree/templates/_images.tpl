{{/*
Return the proper image name
{{ include "common.images.image" ( dict "imageRoot" .Values.path.to.the.image "global" .Values.global ) }}
*/}}
{{- define "inventree.images.image" -}}
{{- $registryName := .imageRoot.registry -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $separator := ":" -}}
{{- $termination := "latest" | toString -}}
{{- if .global }}
    {{- if .global.imageRegistry }}
        {{- $registryName = .global.imageRegistry -}}
    {{- end -}}
    {{- if .global.imageTag }}
        {{- $termination = .global.imageTag -}}
    {{- end -}}
    {{- if .global.imageDigest }}
        {{- $separator = "@" -}}
        {{- $registryName = .global.imageDigest -}}
    {{- end -}}
{{- end -}}
{{- if .imageRoot.tag }}
    {{- $termination = .imageRoot.tag | toString  -}}
{{- end -}}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest -}}
{{- end -}}
{{- if $registryName }}
    {{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- else -}}
    {{- printf "%s%s%s"  $repositoryName $separator $termination -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Inventree server image name
*/}}
{{- define "inventree.master.image" -}}
{{ include "inventree.images.image" (dict "imageRoot" .Values.master.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Inventree server image name
*/}}
{{- define "inventree.workers.image" -}}
{{ include "inventree.images.image" (dict "imageRoot" .Values.workers.image "global" .Values.global) }}
{{- end -}}