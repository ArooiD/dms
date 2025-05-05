package ru.mirea.dms.storage.dto;

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
    private String objectName;
    private long size;
    private String contentType;
    private Instant lastModified;
}