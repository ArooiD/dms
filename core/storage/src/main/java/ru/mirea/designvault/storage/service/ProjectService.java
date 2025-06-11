package ru.mirea.designvault.storage.service;

import org.springframework.stereotype.Service;
import ru.mirea.designvault.storage.model.Project;
import ru.mirea.designvault.storage.repository.ProjectRepository;

import java.util.List;
import java.util.UUID;

@Service
public class ProjectService {
    private final ProjectRepository projectRepository;

    public ProjectService(ProjectRepository projectRepository) {
        this.projectRepository = projectRepository;
    }

    public List<Project> getAllProjects(UUID uid) {
        return projectRepository.findProjectByUidAndAccess(uid, "private");
    }
}
