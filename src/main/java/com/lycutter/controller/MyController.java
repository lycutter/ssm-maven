package com.lycutter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("controller")
public class MyController {
	
	@RequestMapping("test")
	public String test() {
		return "success";
	}

}
