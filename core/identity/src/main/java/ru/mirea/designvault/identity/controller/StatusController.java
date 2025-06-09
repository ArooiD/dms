package ru.mirea.designvault.identity.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping()
public class StatusController {
    @GetMapping()
    public String getHello(){
        return "AuthApplication is Running!";
    }
}
