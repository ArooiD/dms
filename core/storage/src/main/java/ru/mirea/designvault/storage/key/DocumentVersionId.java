package ru.mirea.designvault.storage.key;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.checkerframework.checker.units.qual.N;

import java.util.UUID;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class DocumentVersionId extends DocumentId {
    private Integer ver;

    public DocumentVersionId(UUID pid, UUID did, Integer ver) {
        super(pid, did);
        this.ver = ver;
    }
}
