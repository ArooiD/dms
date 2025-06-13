package ru.mirea.designvault.storage.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.checkerframework.checker.units.qual.N;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocumentVersionResponse {
    private UUID pid;
    private UUID did;
    private String status;
}
