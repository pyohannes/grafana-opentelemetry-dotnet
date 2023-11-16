#!/bin/sh

VERSION=0.6.0-beta.1
DOTNET_AUTO_VERSION=1.1.0
OTEL_DOTNET_AUTO_HOME=$HOME/.otel-dotnet-auto

(
  cd $TMP

  echo -n Download setup script for OpenTelemetry .NET Auto-Instrumentation ${DOTNET_AUTO_VERSION} ...
  curl -sSfL https://github.com/open-telemetry/opentelemetry-dotnet-instrumentation/releases/download/v${DOTNET_AUTO_VERSION}/otel-dotnet-auto-install.sh -O 1>/dev/null
  echo done.

  echo -n Downloading and installing OpenTelemetry components to ${OTEL_DOTNET_AUTO_HOME} ...
  sh ./otel-dotnet-auto-install.sh 1>/dev/null
  chmod +x $OTEL_DOTNET_AUTO_HOME/instrument.sh
  echo done.

  echo -n Downloading Grafana-specific customizations to ${OTEL_DOTNET_AUTO_HOME} ...
  echo done.

  echo -n Removing temporary files ...
  rm -f otel-dotnet-auto-install.sh
  echo done.
)

echo
echo "The Grafana OpenTelemetry .NET Auto-Instrumentation distribution was successfully"
echo "installed. To set up auto-instrumentation components in your current shell,"
echo "invoke"
echo ""
echo "  ${OTEL_DOTNET_AUTO_HOME}/grafana-instrument.sh"
echo ""
echo "To run your appliation with instrumentation enabled, invoke"
echo ""
echo "  ${OTEL_DOTNET_AUTO_HOME}/grafana-instrument.sh ./MyNetApp"
echo ""
