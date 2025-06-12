package ru.mirea.designvault.storage.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Converter
public class FloatArrayToPgVectorConverter implements AttributeConverter<float[], String> {

    @Override
    public String convertToDatabaseColumn(float[] attribute) {
        if (attribute == null) return null;
        return IntStream.range(0, attribute.length)
                .mapToObj(i -> Float.toString(attribute[i]))
                .collect(Collectors.joining(","));
    }

    @Override
    public float[] convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.isEmpty()) return new float[0];

        String[] parts = dbData.split(",");
        float[] result = new float[parts.length];
        for (int i = 0; i < parts.length; i++) {
            result[i] = Float.parseFloat(parts[i]);
        }
        return result;
    }
}
