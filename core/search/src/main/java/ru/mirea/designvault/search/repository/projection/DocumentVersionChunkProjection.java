package ru.mirea.designvault.search.repository.projection;

import java.util.UUID;

public interface DocumentVersionChunkProjection {
    UUID getPid();
    UUID getDid();
    String getContent();
    Float getDistance();
}

