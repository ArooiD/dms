package ru.mirea.designvault.storage.key;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.UUID;


@Data
@EqualsAndHashCode(callSuper = true)
public class DocumentChunkId extends DocumentId {
    UUID cid;
}
