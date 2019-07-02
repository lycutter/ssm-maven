package com.lycutter.controller;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonFormat.Value;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lycutter.bean.Employee;
import com.lycutter.bean.Msg;
import com.lycutter.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/checkuser", method = RequestMethod.POST)
	public Msg checkuser (@RequestParam("empName")String empName) {
		
		// 先判断用户名是否合法
		String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		String regEmail = "";
		
		if (!empName.matches(regName)) {
			return Msg.fail().add("validate_msg", "用户名应该是6-16位英文和数字组合或者2-5位中文");
		}
		
		// 用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("validate_msg", "用户名已存在");
		}
		
	}
	
	/**
	 * 查询员工数据
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn", defaultValue = "1")Integer pn, Model model) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用, 传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询	
		List<Employee> emps = employeeService.getAllEmployee();
		// 使用pageInfo包装查询后的记录
		// 封装了详细的分页信息，包括有查询出来的数据
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
	
	/**
	 *  把服务器的结果以json的形式返回，主要因为与服务器交互不止是网页，还可能是其他客户端，比如安卓和IOS
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody // 通过这个注解返回一个json对象
	public Msg getEmpsWithJson(@RequestParam(value="pn", defaultValue = "1")Integer pn) {
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询	
		List<Employee> emps = employeeService.getAllEmployee();
		// 使用pageInfo包装查询后的记录
		// 封装了详细的分页信息，包括有查询出来的数据
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	   *  员工保存
	 *   支持JS303校验，需要导入hibernate-validator
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		System.out.println("信息校验");
		if (result.hasErrors()) {
			// 校验失败
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			
		}
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		//System.out.println("回显员工信息");
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 员工信息更新.
	 * 注意，如果直接发送ajax=PUT请求，数据会是:[empId=xxx, empName=null, gender=null, email=null, dId=null]
	 * 请求体中有数据，但是Employee对象封装不上
	 * sql语句会变成
	 * update tbl_emp where emp_id = xxx.
	 * 因此语法有问题
	 * 原因：	Tomcat将请求体中的数据，封装一个map 
	 * 		然后request.getParameter("empName")就会从这个map中取值
	 * 		springMVC封装pojo对象的时候会把pojo中每个属性的值，调用request.getParameter()获取
	 * 
	 * 因此，ajax发送put请求，请求体中的数据，比如empName等根本拿不到，原因是tomcat看到put请求，不会封装请求体数据为map
	 * 只有post请求体才会封装
	 * 此时需要在web.xml中配置HttpPutFormContentFilter,他的作用将请求体中的数据解析重新包装成一个map.request
	 * request.getParameter被重写，这时就能处理put请求
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee, HttpServletRequest request) {
		String gender = request.getParameter("gender");
		System.out.println("gender == " + gender);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 删除员工
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("id")String ids) {
		List idList = new ArrayList<Integer>();

		if (ids.contains("-")) {		// 批量删除
			String[] strings = ids.split("-");
			for (String id:strings) {
				idList.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(idList);
		} else { // 单个删除
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}
	
}
