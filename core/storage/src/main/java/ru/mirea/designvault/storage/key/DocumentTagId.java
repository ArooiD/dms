package ru.mirea.designvault.storage.key;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.UUID;


@Data
@EqualsAndHashCode(callSuper = true)
public class DocumentTagId extends DocumentId {
    private UUID tid;
}
