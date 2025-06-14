package ru.mirea.designvault.search.key;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = true)
public class DocumentChunkId extends DocumentId {
    Integer ver;
    Integer cid;
}
