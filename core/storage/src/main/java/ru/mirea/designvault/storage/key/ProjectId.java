package ru.mirea.designvault.storage.key;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.Data;

import java.util.UUID;

@Data
public class ProjectId {
    private UUID pid;
    private UUID uid;
}
