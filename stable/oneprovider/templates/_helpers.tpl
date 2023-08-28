{{- define "openfaas.name" -}}
{{ template "fullname" . }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "openfaas.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "oneprovider.pvc-generate" -}}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ template "fullname" .root }}{{- printf "-%s" .type | trunc 63 | trimSuffix "-" -}}{{- printf "-%s" .name | trunc 63 | trimSuffix "-" -}}-pvc
  labels:
    app: {{ template "fullname" .root }}
    chart: {{ .root.Chart.Name }}
    release: {{ template "releaseName" .root }}
    heritage: {{ .root.Release.Service }}
    component: "oneprovider"
    name: {{ printf "%s" .name | trunc 63 | trimSuffix "-" }}
    type: {{ .type }}
  annotations:
    version: "{{ .root.Chart.Version }}"
spec:
  accessModes:
  {{- range .accessModes }}
    - {{ . | quote }}
  {{- end }}
  resources:
    requests:
      storage: {{ .storageClaim }}
{{- if ne .storageClassName "none" }}
  selector:
    matchLabels:
      type: {{ .type }}
      name: {{ printf "%s" .name | trunc 63 | trimSuffix "-" }}
      owner: {{ .root.Values.suffix }}
      release: {{ template "releaseName" .root }}
  storageClassName: {{ .storageClassName | quote }}
{{- end }}
{{ end }}

{{- define "oneprovider.pv-generate" -}}
---
kind: PersistentVolume
apiVersion: v1
metadata:
  name: {{ template "fullname" .root }}{{- printf "-%s" .type | trunc 63 | trimSuffix "-" -}}{{- printf "-%s" .name | trunc 63 | trimSuffix "-" -}}-pv
  labels:
    app: {{ template "fullname" .root }}
    chart: {{ .root.Chart.Name }}
    release: {{ template "releaseName" .root }}
    heritage: {{ .root.Release.Service }}
    component: "oneprovider"
    name: {{ printf "%s" .name | trunc 63 | trimSuffix "-" }}
    type: {{ .type }}
  annotations:
    version: "{{ .root.Chart.Version }}"
spec:
  accessModes:
    - ReadWriteMany
  capacity:
    storage: {{ .storageClaim }}
{{ end }}