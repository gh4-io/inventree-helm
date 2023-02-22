
{{- define "inventree.configMap.name" -}}
{{ printf "%s-config" (include "inventree.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/* this is the config stuff */}}
{{- define "inventree.configMap" -}} 

database:
  ENGINE: {{ .Values.config.database.engine | default "postgresql" }}
  NAME: {{ .Values.config.database.name | default "inventree" }}
  USER: {{ .Values.config.database.user | default "pguser" }}
  PASSWORD: {{ .Values.config.database.password | default "pgpassword" }}
  HOST: {{ .Values.config.database.host | default "database" }}
  PORT: {{ .Values.config.database.port | default "5432" }}

debug: True

log_level: "WARNING"

language: {{ .Values.config.language | default "en-us" }}

timezone: {{ .Values.config.timezone | default "UTC" }}

base_currency: {{ .Values.config.base_currency | default "USD" }}

{{ if .Values.config.admin.enabled }}
admin_user: {{ .Values.config.admin.user | default "admin" }}
admin_email: {{ .Values.config.admin.email | default "info@example.com" }}
admin_password: {{ .Values.config.admin.password | default "inventree" }}
{{ end }}

currencies:
  {{- toYaml .Values.config.currencies | nindent 2 }}
email:
host: ''
port: 25
username: ''
password: ''
sender: ''
tls: {{ (.Values.config.email.tls | ternary "True" "False") | default "False" }}
ssl: False

sentry_enabled: {{ (.Values.config.sentry.enabled | ternary "True" "False") | default "False" }}

plugins_enabled: {{ (.Values.config.plugins.enabled | ternary "True" "False") | default "False" }}

allowed_hosts:
  {{- (toYaml .Values.config.allowedHosts | nindent 2) | default "*" }}

cors:
  allow_all: {{ (.Values.config.cors.allowAll | ternary "True" "False") | default "True" }}
  # whitelist: {{ toYaml .Values.config.whitelist | default nil }}

{{- if .Values.config.directories.mediaRoot }}
media_root: {{ .inventree.config.directories.mediaRoot }}
{{- end -}}
{{- if .Values.config.directories.staticRoot -}}
static_root: {{ .Values.config.directories.staticRoot }}
{{- end }}

background:
workers: 4
timeout: {{ .Values.config.background.timeout | default 90 }}

login_confirm_days: {{ .Values.config.login.confirmDays | default 3 }}
login_attempts: {{ .Values.config.login.attempts | default 5 }}

remote_login_enabled: {{ (.Values.config.remote.enabled | ternary "True" "False") | default "True"}}
remote_login_header: {{ .Values.config.remote.header | default "REMOTE_USER" }}
{{- end -}}

{{/**/}}
{{- define "inventree-env-overide" -}}
{{ or .Values.config.logLevel 
      .Values.config.files.config 
      .Values.config.files.secretKey 
      .Values.config.files.plugins 
      .Values.config.background.workers
      .Values.web.port
      .Values.web.address
      }}
{{- end -}}

{{/**/}}
{{- define "inventree-env" -}}
INVENTREE_LOG_LEVEL: {{ .Values.config.logLevel | default "WARNING"}}

# InvenTree configuration files
INVENTREE_CONFIG_FILE: ${INVENTREE_DATA_DIR}/{{ .Values.config.files.config | default "config.yaml" }}
INVENTREE_SECRET_KEY_FILE: ${INVENTREE_DATA_DIR}/{{ .Values.config.files.securityKey | default "secret_key.txt" }}
INVENTREE_PLUGIN_FILE: ${INVENTREE_DATA_DIR}/{{ .Values.config.files.plugins | default "plugins.txt" }}

# Worker configuration (can be altered by user)
INVENTREE_GUNICORN_WORKERS: 4
INVENTREE_BACKGROUND_WORKERS: {{ .Values.config.background.workers | default 4 }}

# Default web server address:port
INVENTREE_WEB_ADDR: {{ .Values.config.web.address | default "0.0.0.0" }}
INVENTREE_WEB_PORT: {{ .Values.config.web.port | default "8000" }}

INVENTREE_DEBUG: {{ (.Values.config.debug | ternary "True" "False") | default "True" }}
{{- end -}}