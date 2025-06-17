package ru.mirea.designvault.search.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.mirea.designvault.search.key.DocumentTagId;

import java.util.UUID;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@IdClass(DocumentVersionTag.class)
@Table(schema = "public", name = "document_version_tag")
public class DocumentVersionTag {
    @Id
    @Column(name = "pid")
    private UUID pid;
    @Id
    @Column(name = "did")
    private UUID did;
    @Id
    @Column(name = "ver")
    private Integer ver;
    @Id
    @Column(name = "name")
    private String name;
}
