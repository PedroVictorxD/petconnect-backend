package com.petconect.backend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ForwardingController {

    @RequestMapping("/{path:(?!api).*}")
    public String forward() {
        return "forward:/";
    }

    @RequestMapping(value = "/**/{path:(?!api).*}")
    public String forwardWildcard() {
        return "forward:/";
    }
} 