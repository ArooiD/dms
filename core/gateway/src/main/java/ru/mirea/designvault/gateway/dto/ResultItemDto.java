package ru.mirea.designvault.gateway.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ResultItemDto {
    private String id;
    private String name;
    private String created;
    private String access;
    private int count;
}