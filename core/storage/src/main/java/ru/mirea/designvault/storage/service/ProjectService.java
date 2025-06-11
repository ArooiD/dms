package ru.mirea.designvault.storage.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mirea.designvault.storage.dto.ProjectDto;
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

    @Transactional
    public Object createProject(UUID uid, ProjectDto dto) {
        Project project = new Project();
        project.setUid(uid);
        project.setAccess(dto.getAccess());
        project.setName(dto.getName());
        project.setDescription(dto.getDescription());
        project.setSlug(dto.getSlug());
        project.setPid(UUID.randomUUID());
        return projectRepository.save(project);
    }

    @Transactional
    public Object deleteProject(UUID uid, UUID pid) {
        return projectRepository.deleteProjectByPidAndUid(pid, uid);
    }

    public Project getProject(UUID pid, UUID uid) {
        return projectRepository.findProjectByPidAndUid(pid, uid);
    }
}
