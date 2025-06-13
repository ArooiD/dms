package ru.mirea.designvault.identity.config;

import io.undertow.UndertowOptions;
import org.springframework.boot.web.embedded.undertow.UndertowServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.stereotype.Component;

@Component
public class UndertowConfig implements WebServerFactoryCustomizer<UndertowServletWebServerFactory> {
    @Override
    public void customize(UndertowServletWebServerFactory factory) {
        factory.addBuilderCustomizers(builder -> {
            builder.setIoThreads(8);
            builder.setWorkerThreads(32);
            builder.setBufferSize(16384);
            builder.setDirectBuffers(true);
            builder.setServerOption(UndertowOptions.ALWAYS_SET_KEEP_ALIVE, true);
        });
        factory.addDeploymentInfoCustomizers(deploymentInfo -> {
            deploymentInfo.setEagerFilterInit(true);
        });
    }
}
