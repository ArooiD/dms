package ru.mirea.designvault.gateway.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class ResponseDto {
    private int count;
    private List<ResultItemDto> resultSet;
}
