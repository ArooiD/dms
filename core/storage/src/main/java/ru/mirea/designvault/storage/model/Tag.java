package ru.mirea.designvault.storage.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.storage.key.DocumentId;

import java.util.UUID;

@Data
@Entity
//@IdClass(DocumentId.class)
@Table(schema = "public", name = "tag")
public class Tag {
    @Id
    @Column(name = "tid")
    private UUID tid;
    @Column(name = "name")
    private String name;
}