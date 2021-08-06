package com.dusic.test;

import com.dusic.dao.DepartmentMapper;
import com.dusic.dao.EmployeeMapper;
import com.dusic.domain.Department;
import com.dusic.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:conf/applicationContext.xml")
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
//        System.out.println(departmentMapper);
        Department dev = new Department(null, "开发部");
        Department sal = new Department(null, "销售部");
        Department mon = new Department(null, "财务部");
//        departmentMapper.insertSelective(dev);
//        departmentMapper.insertSelective(sal);
//        departmentMapper.insertSelective(mon);
        Department department = departmentMapper.selectByPrimaryKey(5);
        System.out.println(department.getDeptName());
//            public Employee(Integer id, String name, String email, String gender, Integer deptId, Department department) {

//            employeeMapper.insertSelective(new Employee(null,"jackass","qqq@qq.com","male",5));

        Employee employee = employeeMapper.selectByPrimaryKeyWD(1);
        System.out.println(employee);
        List<Employee> employees = employeeMapper.selectByExampleWD(null);
        employees.forEach(System.out::println);
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 10; i++) {
//            String name = UUID.randomUUID().toString().substring(0, 10);
//            mapper.insertSelective(new Employee(null,name,name+"@qq.com","man",5));
//        }

    }
}
