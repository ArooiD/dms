package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentId;

import java.util.UUID;

@Data
@Entity
@Table(schema = "public", name = "tag")
public class Tag {
    @Id
    @Column(name = "tid", columnDefinition = "uuid default gen_random_uuid()")
    private UUID tid;
    @Column(name = "name")
    private String name;
}