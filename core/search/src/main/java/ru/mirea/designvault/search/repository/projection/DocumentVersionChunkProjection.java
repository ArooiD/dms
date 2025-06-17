package ru.mirea.designvault.search.repository.projection;

import java.util.UUID;

public interface DocumentVersionChunkProjection {
    UUID getPid();
    UUID getDid();
    Integer getVer();
    String getContent();
    Float getScore();
}

