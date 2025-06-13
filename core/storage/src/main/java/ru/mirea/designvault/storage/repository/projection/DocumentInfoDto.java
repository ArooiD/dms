package ru.mirea.designvault.storage.repository.projection;

import java.time.Instant;
import java.util.UUID;

public interface DocumentInfoDto {
    UUID getPid();
    UUID getDid();
    UUID getUid();
    String getSlug();
    Integer getVer();
    String getFilename();
    String getExt();
    Instant getCreated();
    Instant getModified();
}
