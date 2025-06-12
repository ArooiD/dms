package ru.mirea.designvault.storage.dto;

import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class IndexDto {
    private UUID pid;
    private UUID did;
    private List<String> frags;
}
