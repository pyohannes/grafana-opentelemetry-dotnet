using System;
using System.Collections.Generic;
using Grafana.OpenTelemetry;
using Xunit;

namespace Grafana.OpenTelemetry.Tests
{
    public class GrafanaOpenTelemetrySettingsTest
    {
        public GrafanaOpenTelemetrySettingsTest()
        {
            Environment.SetEnvironmentVariable(GrafanaOpenTelemetrySettings.DisableInstrumentationsEnvVarName, null);
        }

        [Fact(Skip = "provider builders crashes on enabling AWSLambda instrumentation by default")]
        public void DefaultInstrumentations()
        {
            var settings = new GrafanaOpenTelemetrySettings();

            Assert.Equal(new HashSet<Instrumentation>((Instrumentation[])Enum.GetValues(typeof(Instrumentation))), settings.Instrumentations);
        }

        [Fact]
        public void DefaultInstrumentationsWithoutAWSLambda()
        {
            var settings = new GrafanaOpenTelemetrySettings();

            // De-activate AWSLambda instrumenation until this issue is resolved: https://github.com/grafana/app-o11y/issues/378
            //
            // Once it's resolved, this test can be removed and the `DefaultInstrumentation` test can be re-activated.
            var expectedSettings = new HashSet<Instrumentation>((Instrumentation[])Enum.GetValues(typeof(Instrumentation)));
            expectedSettings.Remove(Instrumentation.AWSLambda);

            Assert.Equal(expectedSettings, settings.Instrumentations);
        }

        [Fact]
        public void DisableInstrumentations()
        {
            Environment.SetEnvironmentVariable(GrafanaOpenTelemetrySettings.DisableInstrumentationsEnvVarName, "Process,NetRuntime");

            var settings = new GrafanaOpenTelemetrySettings();

            Assert.False(settings.Instrumentations.Contains(Instrumentation.Process));
            Assert.False(settings.Instrumentations.Contains(Instrumentation.NetRuntime));
        }

        [Fact]
        public void DisableInstrumentationsColon()
        {
            Environment.SetEnvironmentVariable(GrafanaOpenTelemetrySettings.DisableInstrumentationsEnvVarName, "Process:NetRuntime");

            var settings = new GrafanaOpenTelemetrySettings();

            Assert.False(settings.Instrumentations.Contains(Instrumentation.Process));
            Assert.False(settings.Instrumentations.Contains(Instrumentation.NetRuntime));
        }
    }
}
