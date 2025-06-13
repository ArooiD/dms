package ru.mirea.designvault.storage.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

import java.time.Instant;
import java.util.UUID;

@Data
@Builder
public class DocumentFileDto {
    @JsonProperty("did")
    private UUID did;
    @JsonProperty("cid")
    private UUID cid;
    @JsonProperty("name")
    private String name;
    @JsonProperty("ext")
    private String ext;
    @JsonProperty("version")
    private String version;
    @JsonProperty("file_path")
    private String file_path;
    @JsonProperty("hash")
    private String hash;
    @JsonProperty("timestamp")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", timezone = "UTC")
    private Instant timestamp;
}

