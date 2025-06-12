package ru.mirea.designvault.storage.key;

import lombok.Data;

import java.util.UUID;

@Data
public class PreviewId {
    private UUID pid;
    private UUID did;
}
