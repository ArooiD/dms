package ru.mirea.designvault.gateway.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocumentVersionDto {
    private String pr_slug;
    private String doc_slug;
    private String status;
}
