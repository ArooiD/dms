package ru.mirea.designvault.search.dto;

import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class IndexDto {
    private String pid;
    private String did;
    private String ver;
    private List<String> frags;
}
