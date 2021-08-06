package com.dusic.controller;

import com.dusic.domain.Department;
import com.dusic.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {
    @Autowired
    DeptService deptService;
    @RequestMapping("/getDepts")
    @ResponseBody
    public List<Department> showDepts(){
        return deptService.getDepts();
    }
}
