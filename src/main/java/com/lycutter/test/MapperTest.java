package com.lycutter.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lycutter.bean.Department;
import com.lycutter.bean.Employee;
import com.lycutter.dao.DepartmentMapper;
import com.lycutter.dao.EmployeeMapper;

@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	// 测试DepartmentMapper
//	@Test
//	public void testCRUD() {
//		// 1. 创建SpringIOC容器
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		// 2. 从容器中获取mapper
//		ioc.getBean(DepartmentMapper.class);
//	}
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession SqlSession;
	
	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		
		// 1. 插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));

		// 2. 插入员工数据
		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@lycutter.com", 1));
		
		//3 .批量插入员工
		EmployeeMapper mapper = SqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 50; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", "@lycutter.com", 1));
		}
		System.out.println("批量执行完成");
	}
}
