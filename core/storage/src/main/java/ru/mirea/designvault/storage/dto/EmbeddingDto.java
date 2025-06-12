package ru.mirea.designvault.storage.dto;

import lombok.Data;

@Data
public class EmbeddingDto {
    private Float[] embedding;
    private Integer length;
}
