package com.dusic.service;

import com.dusic.dao.DepartmentMapper;
import com.dusic.domain.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        return departmentMapper.selectByExample(null);
    }
}
