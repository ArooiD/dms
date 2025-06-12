package ru.mirea.designvault.storage.dto;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class SearchSnippetDto {
    private UUID pid;
    private UUID did;
    private String snippet;
    private Integer score;
}
