{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end }}

{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chart" . }}
{{ include "app.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "app.app_Opts" -}}
    "--eto nabor nastroek"
{{- end -}}

{{- define "hello-app.EnvStartup" }}
- name: SAMPLE_OPTS
  value: {{ template "app.app_Opts" . }}

- name: SAMPLE_ENV
  value: "{{ .Values.sample.env }}"

- name: SAMPLE_SECRET_ENV
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.app.name }}"
      key: SECRET_ENV
 
- name: SAMPLE_CONFIG_ENV
  valueFrom:
    configMapKeyRef:
      name: "{{ .Values.app.name }}"
      key: CONFIG_ENV
{{- end }}