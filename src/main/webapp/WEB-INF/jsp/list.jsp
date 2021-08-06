<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/2
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<jsp:include page="/WEB-INF/common/head.jsp"/>

<html>
<head>
    <title>Employee List</title>
</head>
<body>
<h1>SSM-CRUD</h1>
<div>
    <img src="static/images/1.gif" width="120" height="216">
    <img src="static/images/2.gif" width="120" height="216">
    <img src="static/images/3.gif" width="288" height="216">
    <%--    <img src="static/images/6.gif"  width="286" height="216" >--%>
    <img src="static/images/5.jpg" width="139" height="216">
</div>
<div class="row">
    <div class="col-md-4 col-md-offset-8">
        <button class="btn btn-primary">
            <span class="input-group-addon" aria-hidden="true"></span>
            新增
        </button>
        <button class="btn btn-danger">
            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
            删除选中
        </button>
    </div>

</div>

<div class="row">
    <div class="col-md-12">
        <table class="table table-hover">
            <thead>
            <tr>
                <th colspan="2">员工列表</th>
            </tr>
            </thead>
            <%--            <tr>--%>
            <%--                <td></td>--%>
            <%--                <td></td>--%>
            <%--                <td></td>--%>
            <%--                <td></td>--%>
            <%--                <td></td>--%>
            <%--                <td>--%>
            <%--                    <button class="btn btn-primary">--%>
            <%--                        <span class="input-group-addon" aria-hidden="true"></span>--%>
            <%--                        新增--%>
            <%--                    </button>--%>
            <%--                    <button class="btn btn-danger">--%>
            <%--                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>--%>
            <%--                        删除选中--%>
            <%--                    </button>--%>
            <%--                </td>--%>
            <%--            </tr>--%>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>gender</th>
                <th>email</th>
                <th>dept</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${pageInfo.list }" var="emp">
                <tr>
                    <td>${emp.empId}</td>
                    <td>${emp.empName}</td>
                    <td>${emp.empGender}</td>
                    <td>${emp.empEmail}</td>
                    <td>${emp.department.deptName}</td>
                    <th>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                        </button>
                        <button class="btn btn-danger btn-sm">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除
                        </button>
                    </th>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<div class="row">
    <!--分页文字信息  -->
    <div class="col-md-6">当前第 ${pageInfo.pageNum } 页，共 ${pageInfo.pages }
        页，共 ${pageInfo.total } 条记录
    </div>
    <!-- 分页条信息 -->
    <div class="col-md-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="${basePath }/emps?pn=1">首页</a></li>
                <c:if test="${pageInfo.hasPreviousPage }">
<%--                上一页--%>
                <li><a href="${basePath }/emps?pn=${pageInfo.pageNum-1}"
                       aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
                </a></li>
                </c:if>
                <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                <c:if test="${page_Num == pageInfo.pageNum }">
                <li class="active"><a href="#">${page_Num }</a></li>
                </c:if>
                <c:if test="${page_Num != pageInfo.pageNum }">
                <li><a href="${basePath }/emps?pn=${page_Num }">${page_Num }</a></li>
                </c:if>

                </c:forEach>
                <c:if test="${pageInfo.hasNextPage}">
<%--                下一页--%>
                <li><a href="${basePath}/emps?pn=${pageInfo.pageNum+1}"
                       aria-label="Previous"> <span aria-hidden="true">&raquo;</span>
                </a></li>
                </c:if>
    </div>

</div>
</body>
</html>
