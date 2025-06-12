package ru.mirea.designvault.storage.dto;

import lombok.Data;

@Data
public class EmbeddingDto {
    private float[] embeddings;
    private Integer length;
}
