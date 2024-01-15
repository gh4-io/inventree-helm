{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "inventree.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.master.image .Values.workers.image) "global" .Values.global) -}}
{{- end -}}


{{- define "inventree.db.host" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.host }}
{{- else if .Values.postgresql.enabled }}
{{- include "postgresql.v1.primary.fullname" .subChart.postgresql }}
{{- end -}}
{{- end -}}


{{- define "inventree.db.engine" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.type }}
{{- else if .Values.postgresql.enabled }}
{{- print "postgresql" }}
{{- else }}
{{- print "sqlite" }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.name" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.database }}
{{- else if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.database }}
{{- else }}
{{- print "/home/inventree/database.sqlite3" }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.port" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.port }}
{{- else if .Values.postgresql.enabled }}
{{- template "postgresql.v1.service.port" .subChart.postgresql }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.user" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.username }}
{{- else if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.username }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.secret" -}}
{{- if .Values.externalDatabase.enabled }}
{{- coalesce . }}
{{- else if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.username }}
{{- end -}}
{{- end -}}