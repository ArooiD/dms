package ru.mirea.designvault.storage.dto;

import lombok.*;

import java.time.ZonedDateTime;
import java.time.ZoneOffset;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FileInfo {
    private String name;
    private String ext;
    private Integer ver;
    private Long size;
    private String hash;
    private String contentType;
    private Instant lastModified;
}