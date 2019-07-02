package com.lycutter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lycutter.bean.Department;
import com.lycutter.bean.Msg;
import com.lycutter.service.DepartmentService;
/**
 * 处理和部门有关的请求
 * @author lycutter
 *
 */
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
//		System.out.println("进入部门控制器");
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
