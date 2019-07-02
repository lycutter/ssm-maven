package com.lycutter.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.lycutter.bean.Employee;
import com.lycutter.bean.EmployeeExample;
import com.lycutter.bean.DepartmentExample.Criteria;
import com.lycutter.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAllEmployee() {
		
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 保存新员工
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否存在
	 * @param empName
	 * @return 返回true代表没有这个用户
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		com.lycutter.bean.EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	/**
	 * 员工更新
	 * @param employee
	 */
	public int updateEmp(Employee employee) {
		int record = employeeMapper.updateByPrimaryKeySelective(employee);
		return record;
	}

	/**
	 * 根据id删除员工
	 * @param id
	 */
	public void deleteEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
		
	}

	/**
	 * 批量删除
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		// 创建条件
		EmployeeExample example = new EmployeeExample();
		com.lycutter.bean.EmployeeExample.Criteria criteria = example.createCriteria();
		// delete from xxx where emp_id in (1,2,3)...
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}


}
