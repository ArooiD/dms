package ru.mirea.designvault.storage.key;

import jakarta.persistence.Id;
import lombok.Data;

import java.util.UUID;

@Data
public class DocumentId {
    private UUID pid;
    private UUID uid;
    private UUID did;
}
