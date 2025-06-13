package ru.mirea.designvault.storage.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import ru.mirea.designvault.storage.dto.DocumentFileDto;

import java.io.InputStream;
import java.time.Instant;
import java.util.UUID;

@Data
@Builder
public class DocumentFile {
    private UUID cid;
    private UUID did;
    private String ver;
    private String name;
    private String ext;
    private String fullName;
    private String objectPath;
    private String hash;
    private String contentType;
    private Instant timestamp;
    private InputStream stream;

    public MediaType getMediaType() {
        return MediaType.parseMediaType(
                this.contentType != null ? this.contentType : MediaType.APPLICATION_OCTET_STREAM_VALUE
        );
    }

    public InputStreamResource getInputStreamResource() {
        return new InputStreamResource(this.stream);
    }

    public DocumentFileDto toDto() {
        return DocumentFileDto.builder()
                .did(did)
                .cid(cid)
                .name(name)
                .ext(ext)
                .file_path(objectPath)
                .version(ver)
                .hash(hash)
                .timestamp(timestamp)
                .build();
    }
}
