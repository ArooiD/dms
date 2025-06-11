package ru.mirea.designvault.storage.key;

import lombok.Data;

import java.util.UUID;

@Data
public class VersionId {
    private UUID pid;
    private UUID did;
    private Integer ver;
}
