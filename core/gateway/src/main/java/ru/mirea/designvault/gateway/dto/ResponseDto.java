package ru.mirea.designvault.gateway.dto;

import lombok.Builder;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
public class ResponseDto {
    private int count;
    @Builder.Default
    private List<ResultItemDto> resultSet = new ArrayList<>();
}
