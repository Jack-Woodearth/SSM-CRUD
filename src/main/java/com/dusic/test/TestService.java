package com.dusic.test;

import com.dusic.domain.Department;
import com.dusic.service.DeptService;
import org.junit.Test;

import java.util.List;

public class TestService {
    @Test
    public void testDeptService(){
        DeptService deptService = new DeptService();
        List<Department> depts = deptService.getDepts();
        System.out.println(depts);



    }

    @Test
    public void test(){
        System.out.println("hello git");
    }
}
