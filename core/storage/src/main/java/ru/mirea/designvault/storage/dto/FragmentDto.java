package ru.mirea.designvault.storage.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.checkerframework.checker.units.qual.A;
import org.checkerframework.checker.units.qual.N;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FragmentDto {
    private String text;

    public static FragmentDto of(String text) {
        return new FragmentDto(text);
    }
}
