{{/* vim: set filetype=mustache: */}}
{{/*
This template overrides the variable used in a parent keycloak template.
Expand the name of the chart.
*/}}
{{- define "keycloak.name" -}}
{{ template "fullname" . }}
{{- end -}}

{{/*
This template overrides the variable used in a parent keycloak template.
Create a default fully qualified app name.
We truncate to 20 characters because this is used to set the node identifier in WildFly which is limited to
23 characters. This allows for a replica suffix for up to 99 replicas.
*/}}
{{- define "keycloak.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{/*
Probably the most complex piece of template I've written.
This template traverses recursively a tree of groups, invoking on each node,
a bash function 'createGroup'. It generates a bash code that unfolds the recursion of this template,
saving groupIds in bash variables which names are randomly generated.
*/}}
{{- define "keycloakGroup" -}}
  {{ $groupIdVariableName := (printf "%s_%s_%s_%s" "groupId" .root.name (now | date "20060102030405") (randAlphaNum 10) ) }}
  {{ indent 10 "" }}{{ $groupIdVariableName }}=$(createGroup "{{ .root.name }}" "{{ .parentId }}" );
  {{ indent 10 "" }}echo "Created a group={{ .root.name }} groupId={{ printf "$%s" $groupIdVariableName }} with parentId={{ .parentId }}";
  {{ range $user := .root.idps.keycloak.users -}}
  {{ indent 10 "" }}groupUserId=$(curl --silent -X GET "$keycloak_url/auth/admin/realms/$realmId/users?username={{ $user.name }}" -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"  | jq -r '.[0].id') ;
  {{ indent 10 "" }}echo -n "Adding user={{ $user.name }} userId=$groupUserId to a group={{ $.root.name }} groupId={{ printf "$%s" $groupIdVariableName }} [response: " ;
  {{ indent 10 "" }}curl --silent -w "'%{http_code}'" -X PUT "$keycloak_url/auth/admin/realms/$realmId/users/$groupUserId/groups/{{ printf "$%s" $groupIdVariableName }}" -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" ;
  {{ indent 10 "" }}echo "] . Success." ;
  {{- end }}
  {{- if .root.idps.keycloak.children -}}
    {{- range $child := .root.idps.keycloak.children -}}
      {{ template "keycloakGroup" dict "root" $child "parentId" (printf "$%s" $groupIdVariableName) }}
    {{- end }}
  {{- end }}
{{- end }}
