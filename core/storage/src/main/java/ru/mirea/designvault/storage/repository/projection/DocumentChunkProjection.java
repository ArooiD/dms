package ru.mirea.designvault.storage.repository.projection;

import java.util.UUID;

public interface DocumentChunkProjection {
    UUID getPid();
    UUID getDid();
    String getContent();
    Float getDistance();
}

