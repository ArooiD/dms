package ru.mirea.designvault.search.dto;

import lombok.Data;

@Data
public class EmbeddingDto {
    private float[] embedding;
    private int length;
}
