package ru.mirea.designvault.search.key;

import lombok.Data;
import lombok.EqualsAndHashCode;
import ru.mirea.designvault.search.model.DocumentVersionTag;

import java.util.UUID;


@Data
@EqualsAndHashCode(callSuper = true)
public class DocumentTagId extends DocumentVersionTag {
    private String name;
}
