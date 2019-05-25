{{/* vim: set filetype=mustache: */}}

{{- define "json_quoted_list" -}}
  {{- if kindIs "slice" .list -}}
   {{- printf "-d \"'{ \\\"%s\\\": [ " .name -}}
   {{- range (initial .list) -}}
    {{- printf "\\\"%s\\\", " . -}}
   {{- end -}}
   {{- if .list -}}
    {{- printf "\\\"%s\\\" " (last .list) -}}
   {{- end -}}
   {{- printf "]}'\" " -}}
  {{- end -}}
{{- end -}}

{{- define "providerName" -}}
  {{- printf "%s-%s" "oneprovider" . | trimSuffix "-" -}}
{{- end -}}

{{- define "admin_username_template" -}}
{{- if hasKey (index .Values "global") "onezoneMainAdmin" -}}
{{- (index .Values "global" "onezoneMainAdmin" "name") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "admin_password_template" -}}
{{- if hasKey (index .Values "global") "onezoneMainAdmin" -}}
{{- (index .Values "global" "onezoneMainAdmin" "password") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "onepanel_emergency_username_template" -}}
{{- if hasKey (index .Values "global") "onepanelEmergencyAccount" -}}
{{- (index .Values "global" "onepanelEmergencyAccount" "name") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "onepanel_emergency_password_template" -}}
{{- if hasKey (index .Values "global") "onepanelEmergencyAccount" -}}
{{- (index .Values "global" "onepanelEmergencyAccount" "password") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "keycloak_realmId_template" -}}
{{- if hasKey (index .Values "global") "keycloakInstance" -}}
{{- (index .Values "global" "keycloakInstance" "realmId") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "keycloak_adminUsername_template" -}}
{{- if hasKey (index .Values "global") "keycloakInstance" -}}
{{- (index .Values "global" "keycloakInstance" "adminUsername") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "keycloak_adminPassword_template" -}}
{{- if hasKey (index .Values "global") "keycloakInstance" -}}
{{- (index .Values "global" "keycloakInstance" "adminPassword") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "keycloak_idpName_template" -}}
{{- if hasKey (index .Values "global") "keycloakInstance" -}}
{{- (index .Values "global" "keycloakInstance" "idpName") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "keycloak_tokenPrefix_template" -}}
{{- if hasKey (index .Values "global") "keycloakInstance" -}}
{{- (index .Values "global" "keycloakInstance" "tokenPrefix") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}
