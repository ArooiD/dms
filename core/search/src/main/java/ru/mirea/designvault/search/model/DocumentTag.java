package ru.mirea.designvault.search.model;

import jakarta.persistence.*;
import lombok.Data;
import ru.mirea.designvault.search.key.DocumentTagId;

import java.util.UUID;

@Data
@Entity
@IdClass(DocumentTagId.class)
@Table(schema = "public", name = "document_tag")
public class DocumentTag {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Id
    @Column(name = "tid")
    private UUID tid;
    @Column(name = "name")
    private String name;
}
