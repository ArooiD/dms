package ru.mirea.designvault.gateway.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocumentVersionResponse {
    private UUID pid;
    private UUID did;
    private String status;
}
