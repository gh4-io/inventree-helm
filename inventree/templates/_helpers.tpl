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
{{- template "postgresql.v1.primary.fullname" .Subcharts.postgresql }}
{{- end -}}
{{- end -}}


{{- define "inventree.db.engine" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.type }}
{{- else if .Values.postgresql.enabled }}
{{- print "postgresql" }}
{{- else }}
{{- print "sqlite3" }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.name" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.database }}
{{- else if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.database }}
{{- else }}
{{- print "/home/inventree/data/database.sqlite3" }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.port" -}}
{{- if .Values.externalDatabase.enabled }}
{{- .Values.externalDatabase.port }}
{{- else if .Values.postgresql.enabled }}
{{- template "postgresql.v1.service.port" .Subcharts.postgresql }}
{{- end -}}
{{- end -}}

{{- define "inventree.db.user" -}}
{{ ternary .Values.externalDatabase.username .Values.postgresql.auth.username .Values.externalDatabase.enabled }}
{{- end -}}

{{- define "inventree.db.secret" -}}
{{- if .Values.externalDatabase.enabled }}
secretKeyRef:
  name: {{ include "common.secrets.name" ( dict "existingSecret" .Values.master.existingSecret "defaultNameSuffix" "master" "context" $ ) }}
  key: {{ include "common.secrets.key" ( dict "existingSecret" .Values.master.existingSecret "key" "key" ) }}
{{- else if .Values.postgresql.enabled }}
secretKeyRef:
  name: {{ include "common.secrets.name" ( dict "existingSecret" .Values.master.existingSecret "defaultNameSuffix" "master" "context" $ ) }}
  key: {{ include "common.secrets.key" ( dict "existingSecret" .Values.master.existingSecret "key" "key" ) }}
{{- end -}}
{{- end -}}

{{- define "inventree.admin.secret" -}}
secretKeyRef:
  name: {{ include "common.secrets.name" ( dict "existingSecret" .Values.master.existingSecret "defaultNameSuffix" "master" "context" $ ) }}
  key: {{ include "common.secrets.key" ( dict "existingSecret" .Values.master.password "key" "adminPassword" ) }}
{{- end -}}