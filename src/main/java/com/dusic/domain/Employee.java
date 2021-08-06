package com.dusic.domain;

import javax.validation.constraints.Pattern;

public class Employee {
    
    private Integer empId;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)",
            message = "用户名可以是2-5位中文或者6-16位英文和数字的组合")
    private String empName;

    @Pattern(regexp = "^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$",
            message = "邮箱格式不正确")
    private String empEmail;

    private String empGender;

    private Integer empDeptId;
    private Department department;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Employee employee = (Employee) o;

        if (empId != null ? !empId.equals(employee.empId) : employee.empId != null) return false;
        if (empName != null ? !empName.equals(employee.empName) : employee.empName != null) return false;
        if (empEmail != null ? !empEmail.equals(employee.empEmail) : employee.empEmail != null) return false;
        if (empGender != null ? !empGender.equals(employee.empGender) : employee.empGender != null) return false;
        if (empDeptId != null ? !empDeptId.equals(employee.empDeptId) : employee.empDeptId != null) return false;
        return department != null ? department.equals(employee.department) : employee.department == null;
    }

    @Override
    public int hashCode() {
        int result = empId != null ? empId.hashCode() : 0;
        result = 31 * result + (empName != null ? empName.hashCode() : 0);
        result = 31 * result + (empEmail != null ? empEmail.hashCode() : 0);
        result = 31 * result + (empGender != null ? empGender.hashCode() : 0);
        result = 31 * result + (empDeptId != null ? empDeptId.hashCode() : 0);
        result = 31 * result + (department != null ? department.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", empGender='" + empGender + '\'' +
                ", empDeptId=" + empDeptId +
                ", department=" + department +
                '}';
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Employee() {
    }

    public Employee(Integer empId, String empName, String empEmail, String empGender, Integer empDeptId) {
        this.empId = empId;
        this.empName = empName;
        this.empEmail = empEmail;
        this.empGender = empGender;
        this.empDeptId = empDeptId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail == null ? null : empEmail.trim();
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public Integer getEmpDeptId() {
        return empDeptId;
    }

    public void setEmpDeptId(Integer empDeptId) {
        this.empDeptId = empDeptId;
    }
}