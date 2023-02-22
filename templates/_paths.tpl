{{/* Defines home directory with default */}}
{{- define "inventree.dir.home" -}}
{{- default "/home/inventree" .Values.config.directories.homeDir }}
{{- end }}

{{/* Defines home directory with default */}}
{{- define "inventree.file.config" -}}
{{- if and .Values.config.directories.dataDir .Values.config.files.config }}
{{- printf "%s/%s" .Values.config.directories.dataDir .Values.config.files.config }}
{{- else }}
{{- default "/home/inventree/data/config.yaml" }}
{{- end }}
{{- end }}

{{/* Defines home directory with default */}}
{{- define "inventree.file.init" -}}
{{- if or .Values.config.directories.homeDir .Values.config.files.config }}
{{- printf "%s/Inventree/%s" (.Values.config.directories.homeDir | default "/home/inventree") (.Values.config.files.init | default "init.sh") }}
{{- else }}
{{- default "/home/inventree/InvenTree/init.sh" }}
{{- end }}
{{- end }}

{{- define "inventree.dir.data" -}}
{{- if .Values.config.directories.dataDir -}}
{{ .Values.config.directories.dataDir }}
{{- else -}}
{{ printf "%s/data" (include "inventree.dir.home" .) }}
{{- end -}}
{{- end -}}

{{- define "inventree.dir.mediaRoot" -}}
null
{{- end -}}

{{- define "inventree.dir.staticRoot" -}}
null
{{- end -}}