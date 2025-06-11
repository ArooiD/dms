package ru.mirea.designvault.gateway.service;

import org.springframework.stereotype.Service;
import ru.mirea.designvault.gateway.dto.ResponseDto;

import java.util.UUID;

@Service
public class ProjectService {

    public ResponseDto getProjects(UUID uuid) {


        return ResponseDto.builder().build();
    }
}
