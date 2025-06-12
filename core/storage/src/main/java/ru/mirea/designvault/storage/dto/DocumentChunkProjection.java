package ru.mirea.designvault.storage.dto;

import java.util.UUID;

public interface DocumentChunkProjection {
    UUID getPid();
    UUID getDid();
    String getContent();
    Float getDistance();
}

