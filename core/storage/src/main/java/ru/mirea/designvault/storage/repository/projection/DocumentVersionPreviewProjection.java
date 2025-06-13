package ru.mirea.designvault.storage.repository.projection;

public interface DocumentVersionPreviewProjection {
    String getFilename();

    String getExt();

    String getContentType();
}
