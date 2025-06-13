package ru.mirea.designvault.storage.repository;

import org.simpleframework.xml.core.Resolve;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RestController;
import ru.mirea.designvault.storage.key.ProjectId;
import ru.mirea.designvault.storage.model.Project;

import java.util.List;
import java.util.UUID;

@Repository
public interface ProjectRepository extends CrudRepository<Project, ProjectId> {

    List<Project> findProjectByUidAndAccess(UUID uid, String access);

    Project deleteProjectByPidAndUid(UUID pid, UUID uid);

    Project findProjectByPidAndUid(UUID pid, UUID uid);

    Project getProjectBySlug(String slug);

    Project findProjectBySlug(String slug);
}
