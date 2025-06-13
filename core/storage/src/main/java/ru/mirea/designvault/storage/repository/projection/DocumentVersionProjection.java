package ru.mirea.designvault.storage.repository.projection;

public interface DocumentVersionProjection {
    String getFilename();
    String getExt();
    String getContentType();
}
