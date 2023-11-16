#!/bin/sh

OTEL_DOTNET_AUTO_HOME="$(readlink -f $(dirname $0))"

if [ ! -z "$GRAFANA_CLOUD_INSTANCE_ID" -a ! -z "$GRAFANA_CLOUD_ZONE" -a ! -z "$GRAFANA_CLOUD_API_KEY" ] ; then
  export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"
  export OTEL_EXPORTER_OTLP_ENDPOINT="https://otlp-gateway-${GRAFANA_CLOUD_ZONE}.grafana.net/otlp"
  export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Basic $(echo -n $GRAFANA_INSTANCE_ID:$GRAFANA_CLOUD_API_KEY| base64 -w 0)"
fi

"$OTEL_DOTNET_AUTO_HOME/instrument.sh" $@
