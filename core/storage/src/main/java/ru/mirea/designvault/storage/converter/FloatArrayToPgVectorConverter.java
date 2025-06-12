package ru.mirea.designvault.storage.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import org.postgresql.util.PGobject;

import java.sql.SQLException;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Converter(autoApply = true)
public class FloatArrayToPgVectorConverter implements AttributeConverter<float[], PGobject> {

    @Override
    public PGobject convertToDatabaseColumn(float[] attribute) {
        if (attribute == null) return null;
        PGobject pgObject = new PGobject();
        try {
            pgObject.setType("vector");
            String value = "(" + IntStream.range(0, attribute.length)
                    .mapToObj(i -> Float.toString(attribute[i]))
                    .collect(Collectors.joining(",")) + ")";
            pgObject.setValue(value);
            return pgObject;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to convert float[] to PGvector", e);
        }
    }

    @Override
    public float[] convertToEntityAttribute(PGobject dbData) {
        if (dbData == null) return new float[0];
        String value = dbData.getValue();
        if (value == null || value.isEmpty()) return new float[0];
        String trimmed = value.trim();
        if (trimmed.startsWith("(")) trimmed = trimmed.substring(1);
        if (trimmed.endsWith(")")) trimmed = trimmed.substring(0, trimmed.length() - 1);
        String[] parts = trimmed.split(",");
        float[] result = new float[parts.length];
        for (int i = 0; i < parts.length; i++) {
            result[i] = Float.parseFloat(parts[i]);
        }
        return result;
    }
}
