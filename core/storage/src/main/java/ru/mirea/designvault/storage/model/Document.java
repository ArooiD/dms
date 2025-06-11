package ru.mirea.designvault.storage.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.util.UUID;

@Data
@Entity
@Table(schema = "public", name = "document")
public class Document {
    private UUID pid;
    private UUID uid;
    @Id
    private UUID did;
    private String slug;
    private String filename;
    private String ext;
}
