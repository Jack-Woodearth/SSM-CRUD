package com.dusic.service;

import com.dusic.dao.EmployeeMapper;
import com.dusic.domain.Department;
import com.dusic.domain.Employee;
import com.dusic.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        List<Employee> employees = employeeMapper.selectByExampleWD(null);
        System.out.println("《》《》《》《》《》get:" + System.currentTimeMillis());
        return employees;
    }

    public int addOne(Employee employee) {
        int i = employeeMapper.insert(employee);
        System.out.println("《》《》《》《》《》put:" + System.currentTimeMillis());
        return i;
    }

    public int updateEmp(Employee employee) {
//        加了下面这一行代码，导致jsp页面中，更新完一个员工数据后马上请求定位到当前页的时候，此时分页请求获取的数据还是没有更新的数据
//        需要手动点击当前页码才能再jsp页面中看到更新后的数据
//        可能和数据库的隔离级别有关
//        结论：点击确定修改按钮后，ajax先后发起了put和get请求，服务器收到put请求后向数据库修改数据，在此修改过程中，
//        又收到了ajax发起的get请求，这时查到的数据是put请求还没有修改完的数据。加上下面这行代码后，更新操作花的时间变长了.
//        因此虽然是先发的put请求后发的get请求，但是put请求对应的操作数据库的时间更长，因此put请求实际上比get请求更晚完成。
//      （mysql 默认隔离级别是可重复读，也就是put请求没修改完的数据get请求是读不到的）
//            employeeMapper.selectByPrimaryKey(employee.getEmpId());
        if ("".equals(employee.getEmpName())) {
            employee.setEmpName(null);
        }
        if ("".equals(employee.getEmpEmail())) {
            employee.setEmpEmail(null);
        }

        int i = employeeMapper.updateByPrimaryKeySelective(employee);
        System.out.println("《》《》《》《》《》update:" + System.currentTimeMillis());
        return i;
    }

    public int checkEmail(String email) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpEmailEqualTo(email);
//       long count= employeeMapper.countByExample(example);
//       if(count==1){
//
//       }
        List<Employee> employees = employeeMapper.selectByExample(example);
        if(employees!=null&&employees.size()>0){
            return employees.get(0).getEmpId();
        }
        return -1;
    }

    public int deleteById(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }

    public int deleteBatch(ArrayList<Integer> idList) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(idList);
        return employeeMapper.deleteByExample(employeeExample);
    }
}
