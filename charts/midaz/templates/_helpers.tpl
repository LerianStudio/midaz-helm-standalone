{{/*
Expand the name of the chart.
*/}}
{{- define "midaz.name" -}}
{{- default (default "midaz" .Values.nameOverride) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "midaz-onboarding.fullname" -}}
{{- printf "%s-%s" (include "midaz.name" .) .Values.onboarding.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "midaz-console.fullname" -}}
{{- printf "%s-%s" (include "midaz.name" .) .Values.console.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "midaz-transaction.fullname" -}}
{{- printf "%s-%s" (include "midaz.name" .) .Values.transaction.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "midaz-grafana.fullname" -}}
{{- printf "%s-%s" (include "midaz.name" .) .Values.grafana.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "midaz.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create Onboarding app version
*/}}
{{- define "onboarding.defaultTag" -}}
{{- default .Chart.AppVersion .Values.onboarding.image.tag }}
{{- end -}}

{{/*
Return valid Onboarding version label
*/}}
{{- define "onboarding.versionLabelValue" -}}
{{ regexReplaceAll "[^-A-Za-z0-9_.]" (include "onboarding.defaultTag" .) "-" | trunc 63 | trimAll "-" | trimAll "_" | trimAll "." | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "midaz.labels" -}}
helm.sh/chart: {{ include "midaz.chart" .context }}
{{ include "midaz.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/version: {{ include "onboarding.versionLabelValue" .context }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "midaz.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "midaz.name" .context }}-{{ .name }}
{{- end }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "midaz-onboarding.serviceAccountName" -}}
{{- if .Values.onboarding.serviceAccount.create }}
{{- default (include "midaz-onboarding.fullname" .) .Values.onboarding.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.onboarding.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "midaz-console.serviceAccountName" -}}
{{- if .Values.console.serviceAccount.create }}
{{- default (include "midaz-console.fullname" .) .Values.console.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.console.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "midaz-transaction.serviceAccountName" -}}
{{- if .Values.transaction.serviceAccount.create }}
{{- default (include "midaz-transaction.fullname" .) .Values.transaction.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.transaction.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Expand the namespace of the release.
Allows overriding it for multi-namespace deployments in combined charts.
*/}}
{{- define "global.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Enable internal dependencies
*/}}
{{- define "mongodb.enabled" -}}
{{- if not .Values.mongodb.external -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
{{- define "rabbitmq.enabled" -}}
{{- if not .Values.rabbitmq.external -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
{{- define "valkey.enabled" -}}
{{- if not .Values.valkey.external -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
{{- define "postgresql.enabled" -}}
{{- if not .Values.postgresql.external -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
