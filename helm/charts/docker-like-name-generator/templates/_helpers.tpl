{{/*
Expand the name of the chart.
*/}}
{{- define "docker-like-name-generator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "docker-like-name-generator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "docker-like-name-generator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "docker-like-name-generator.labels" -}}
helm.sh/chart: {{ include "docker-like-name-generator.chart" . }}
{{ include "docker-like-name-generator.selectorLabels" . }}
{{- if or .Values.image .Chart.AppVersion }}
app.kubernetes.io/version: {{ if and (.Values.image) (.Values.image.tag) }}{{ .Values.image.tag }}{{ else }}{{ .Chart.AppVersion }}{{ end }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "docker-like-name-generator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "docker-like-name-generator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}