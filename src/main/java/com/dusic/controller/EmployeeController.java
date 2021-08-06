package com.dusic.controller;

import com.dusic.domain.Employee;
import com.dusic.domain.Msg;
import com.dusic.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            return backstageCheck(result);
        }

        int i = employeeService.addOne(employee);
        return Msg.success().add("num of emp saved", i);
    }

    @RequestMapping("/emps")
    public ModelAndView getEmployees(@RequestParam(value = "pn", defaultValue = "1") int pn) {
        //引入 Pagehelper分页插件
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        // startpage,后面紧跟的这个査询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用 pageinfo包装查询后的结果，只需要将 pageinfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps, 5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("emps", emps);
        System.out.println("emps:" + emps.get(1));
        Employee emp = emps.get(2);
        mv.addObject("emp", emp);
//        System.out.println(pageInfo.getList());
        System.out.println("----------");
        mv.setViewName("list");

        return mv;
    }

    @RequestMapping("/page")
    @ResponseBody
    public Msg getPage(@RequestParam(value = "pn", defaultValue = "1") int pn) {
        PageHelper.startPage(pn, 5);
        // startpage,后面紧跟的这个査询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用 pageinfo包装查询后的结果，只需要将 pageinfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps, 5);
//        System.out.println("11111111111");
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee
     * [empId=1014, empName=null, gender=null, email=null, dId=null]
     * <p>
     * 问题：
     * 请求体中有数据；
     * 但是Employee对象封装不上；
     * update tbl_emp  where emp_id = 1014;
     * <p>
     * 原因：
     * Tomcat：
     * 1、将请求体中的数据，封装一个map。
     * 2、request.getParameter("empName")就会从这个map中取值。
     * 3、SpringMVC封装POJO对象的时候。
     * 会把POJO中每个属性的值，request.getParamter("email");
     * AJAX发送PUT请求引发的血案：
     * PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     * ***********************	Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map************************
     * org.apache.catalina.connector.Request--parseParameters() (3111);
     * <p>
     * protected String parseBodyMethods = "POST";
     * if( !getConnector().isParseBodyMethod(getMethod()) ) {
     * success = true;
     * return;
     * }
     * <p>
     * <p>
     * 解决方案；
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1、配置上HttpPutFormContentFilter；
     * 2、他的作用；将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     * 员工更新方法
     *
     * @param employee
     * @return
     */
    //修改员工信息
    @RequestMapping(value = "emp", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(@Valid Employee employee, BindingResult result) {
        System.out.println("昂昂昂昂昂：" + employee);
        if (result.hasErrors()) {
            return backstageCheck(result);
        }
        int i = employeeService.updateEmp(employee);
        return Msg.success().add("num of emp updated", i);
    }

    @RequestMapping("/checkEmail")
    @ResponseBody
    public Msg checkEmail(String email) {
//        boolean success = employeeService.checkEmail(email);

        if (employeeService.checkEmail(email) == -1)
            return Msg.success();
        else return Msg.fail().add("empId", employeeService.checkEmail(email));
    }

    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        //单个删除
        if (!ids.contains("-")) {
            int id = Integer.parseInt(ids);
            if (employeeService.deleteById(id) == 1) {
                return Msg.success();
            }
        }
        //批量删除
        else {
            String[] idStrings = ids.split("-");
            ArrayList<Integer> idList = new ArrayList<>();
            for (String idString : idStrings) {
                Integer idInt = Integer.parseInt(idString);
                idList.add(idInt);
            }
          if( employeeService.deleteBatch(idList)!=-1){
              return Msg.success();
          }

        }
        return Msg.fail().add("error","delete failed");

    }

    //后端校验返回错误信息
    public Msg backstageCheck(BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error : fieldErrors) {
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }
        return Msg.success();
    }

}
