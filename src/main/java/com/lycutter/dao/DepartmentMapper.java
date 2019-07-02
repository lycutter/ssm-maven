package com.lycutter.dao;

import com.lycutter.bean.Department;
import com.lycutter.bean.DepartmentExample;
import com.lycutter.bean.Employee;
import com.lycutter.bean.EmployeeExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {
    long countByExample(DepartmentExample example);

    int deleteByExample(DepartmentExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Department record);

    int insertSelective(Department record);

    List<Department> selectByExample(DepartmentExample example);

    Department selectByPrimaryKey(Integer deptId);
    
//    List<Department> selectByExampleWithDept(EmployeeExample example);
//
//    Department selectByPrimaryKeyWithDept(Integer deptId);

    int updateByExampleSelective(@Param("record") Department record, @Param("example") DepartmentExample example);

    int updateByExample(@Param("record") Department record, @Param("example") DepartmentExample example);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
}