package ru.mirea.designvault.storage.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mirea.designvault.storage.dto.ProjectDto;
import ru.mirea.designvault.storage.model.Document;
import ru.mirea.designvault.storage.model.Project;
import ru.mirea.designvault.storage.repository.DocumentRepository;
import ru.mirea.designvault.storage.repository.ProjectRepository;

import java.util.List;
import java.util.UUID;

@Service
public class ProjectService {
    private final ProjectRepository projectRepository;
    private final DocumentRepository documentRepository;

    public ProjectService(ProjectRepository projectRepository, DocumentRepository documentRepository) {
        this.projectRepository = projectRepository;
        this.documentRepository = documentRepository;
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

    public List<Document> getProjectDocument(String slug) {
        UUID pid = projectRepository.getProjectBySlug(slug).getPid();
        return documentRepository.getDocumentsByPid(pid);
    }

    public UUID resolvePid(String slug) {
        return projectRepository.findProjectBySlug(slug).getPid();
    }

    public UUID resolveDid(UUID pid, String slug) {
        return documentRepository.findDidByPidAndSlugByPidAndSlug(pid, slug);
    }
}
