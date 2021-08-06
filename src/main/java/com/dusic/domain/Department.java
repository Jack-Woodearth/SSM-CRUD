package com.dusic.domain;

public class Department {
    private Integer deptId;

    private String deptName;

    public Integer getDeptId() {
        return deptId;
    }

    public Department() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Department that = (Department) o;

        if (deptId != null ? !deptId.equals(that.deptId) : that.deptId != null) return false;
        return deptName != null ? deptName.equals(that.deptName) : that.deptName == null;
    }

    @Override
    public int hashCode() {
        int result = deptId != null ? deptId.hashCode() : 0;
        result = 31 * result + (deptName != null ? deptName.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Department{" +
                "deptId=" + deptId +
                ", deptName='" + deptName + '\'' +
                '}';
    }

    public Department(Integer deptId, String deptName) {
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}