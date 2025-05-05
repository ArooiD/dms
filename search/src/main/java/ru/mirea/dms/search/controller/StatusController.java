package ru.mirea.dms.search.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping()
public class StatusController {
    @GetMapping()
    public String getHello(){
        return "SearchApplication is Running!";
    }
}
