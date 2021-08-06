<jsp:include page="WEB-INF/common/head.jsp"/>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/2
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Employee List</title>
</head>
<body>
<h1>SSM-CRUD</h1>
<%--<div>--%>
<%--    <img src="static/images/1.gif" width="120" height="216">--%>
<%--    <img src="static/images/2.gif" width="120" height="216">--%>
<%--    <img src="static/images/3.gif" width="288" height="216">--%>
<%--    &lt;%&ndash;    <img src="static/images/6.gif"  width="286" height="216" >&ndash;%&gt;--%>
<%--    <img src="static/images/5.jpg" width="139" height="216">--%>
<%--</div>--%>


<div class="col-md-4 col-md-offset-8">
    <button class="btn btn-primary" id="addEmpModalBtn">新增</button>
    <button class="btn btn-danger" id="batchDeleteBtn">删除选中</button>
</div>


<div class="row">
    <div class="col-md-12">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th colspan="2">员工列表</th>
            </tr>
            <tr>
                <th><input type="checkbox" id="check_all">全选</th>
                <th>id</th>
                <th>name</th>
                <th>gender</th>
                <th>email</th>
                <th>dept</th>
                <th>操作</th>
            </tr>
            </thead>

            <tbody></tbody>

        </table>
    </div>
</div>
<div class="row">
    <%--    <!--分页文字信息  -->--%>
    <div class="col-md-6" id="pageTextInfo">
    </div>
    <!-- 导航条信息 -->
    <div class="col-md-6" id="navigation">

    </div>

</div>

<!-- Modal 新增员工操作的模态框-->
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form id="newEmp">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">姓名</span>
                        <input type="text" name="empName" id="newEmpNameInput" class="form-control" placeholder="name"
                               aria-describedby="basic-addon1">
                        <span class="help-block"></span>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">邮箱</span>
                        <input type="text" name="empEmail" id="newEmpEmailInput" class="form-control"
                               placeholder="email"
                               aria-describedby="basic-addon1">
                        <span class="help-block"></span>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"> <span style="font-size: 17px"> 性别</span></label>
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio1" value="male"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio2" value="female"> 女
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"> <span style="font-size: 17px"> 部门</span></label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="empDeptId" id="deptSelect">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="empSaveBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<%--编辑员工模态框--%>
<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">更新员工信息</h4>
            </div>
            <div class="modal-body">
                <form id="updateEmpForm">
                    <div><p id="update_emp_id_p"></p></div>
                    <input type="hidden" name="_method" value="put">
                    <input type="hidden" name="empId" id="empIdHidden">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">姓名</span>
                        <input type="text" name="empName" id="emp_name_update_input" class="form-control"
                               placeholder="name"
                               aria-describedby="basic-addon1">
                        <span class="help-block"></span>
                    </div>
                    <%--                    <div class="input-group">--%>
                    <%--                        <div>姓名<input type="text" name="empName" id="emp_name_update_input"></div>--%>
                    <%--                    </div> --%>
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">邮箱</span>
                        <input type="text" name="empEmail" id="emp_email_update_input" class="form-control"
                               placeholder="email"
                               aria-describedby="basic-addon1">
                        <span class="help-block"></span>
                    </div>
                    <%--                    <div>邮件<input type="text" name="empEmail" id="emp_email_update_input"></div>--%>
                    <div>性别 男<input id="male_radio" type="radio" name="empGender" value="male">
                        女<input id="female_radio" type="radio" name="empGender" value="female"></div>
                    <div>部门 <select id="updateDeptSelect" name="empDeptId"></select></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="updateEmpBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var timeout=500;
    var totalPages;
    var curPageNo;
    var updateEmpId;
    $(function () {
        toPage(1);
    })
    //全选按钮
    $("#check_all").click(function () {
        $(".check-item").prop("checked", $(this).prop("checked"));
    })
    //全选按钮自动更新
    $(document).on("click", ".check-item", function () {
        var flag = $(".check-item:checked").length == $(".check-item").length;
        $("#check_all").prop("checked", flag);
    })

    //删除选中按钮单击事件
    $("#batchDeleteBtn").click(function () {

        var idsString = "";
        var namesString = "";
        $.each($(".check-item:checked"), function () {
            idsString += $(this).parents("tr").find("td:eq(1)").text() + "-";
            namesString += $(this).parents("tr").find("td:eq(2)").text() + ",";
        })

        idsString = idsString.substring(0, idsString.length - 1);
        namesString = namesString.substring(0, namesString.length - 1);

        if (confirm("是否确定删除【" + namesString + "】？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + idsString,
                type: "DELETE",
                success: function (resp) {
                    alert(resp.msg);
                    if (resp.code == 100) {
                        setTimeout(function () {
                            toPage(curPageNo);
                        }, timeout);
                    }
                }
            })
        }


        //
    })
    //绑定编辑文本框改变事件 进行前端校验
    $("#emp_name_update_input").change(function () {
        validate_nameInput(this);
    })

    $("#emp_email_update_input").change(function () {
        validate_emailInput(this);
        if ($(this).val() != $(this).attr("origin")) {
            if (emailIsDup(this)) {
                show_validate_msg(this, "error", "邮箱已被使用");
            }
        }
    })

    function toPage(pn) {
        $.ajax({
            url: "${APP_PATH}/page",
            data: "pn=" + pn,
            type: "GET",
            success: function (resp) {
                console.log(resp);
                buildEmpsTable(resp);
                showPageTextInfo(resp);
                showPageNavigation(resp);
            }
        });
    }

    function showDepts(select) {
        // select.empty();
        $.ajax({
            url: "${APP_PATH}/getDepts",
            // data: "pn="+pn,
            type: "GET",
            success: function (resp) {
                console.log(resp);
                $.each(resp, function (index, item) {
                    // alert(item.deptName);
                    var option = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    option.addClass("update_dept_options");
                    option.appendTo(select);


                });

            }
        });

    }

    function buildEmpsTable(resp) {
        $("#emps_table tbody").empty();
        var emps = resp.extend.pageInfo.list;

        totalPages = resp.extend.pageInfo.pages;
        curPageNo = resp.extend.pageInfo.pageNum;
        $.each(emps, function (index, item) {
            // alert(item.empName);
            var checkBoxTd = $(" <td><input type='checkbox' class='check-item'></td>")
            var empIdTd = $(" <td></td>").append(item.empId);
            var empNameTd = $(" <td></td>").append(item.empName);
            var empGenderTd = $(" <td></td>").append(item.empGender);
            var empEmailTd = $(" <td></td>").append(item.empEmail);
            var empDeptNameTd = $(" <td></td>").append(item.department.deptName);
            var editButton = $("<Button></Button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑")
                .attr("emp_id", item.empId).attr("emp_name", item.empName).attr("emp_email", item.empEmail).attr("emp_gender", item.empGender)
                .attr("emp_dept_id", item.empDeptId);


            var deleteButton = $("<Button></Button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除")
                .attr("emp_id", item.empId).attr("emp_name", item.empName);
            var buttonsTh = $("<th></th>").append(editButton).append(" ").append(deleteButton);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptNameTd)
                .append(buttonsTh)
                .appendTo("#emps_table tbody")
        });
    }

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        var empId = $(this).attr("emp_id");
        var empName = $(this).attr("emp_name");
        if (confirm("确认删除【" + empName + "(id:" + empId + ")" + "】吗")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (resp) {
                    alert(resp.msg);
                    setTimeout(function () {
                        toPage(curPageNo);
                    }, timeout);
                }
            })
        }
    })
    //绑定编辑按钮单击事件
    $(document).on("click", ".edit_btn", function () {
        // alert("  111  ");
        //清空部门下拉列表
        $("#updateDeptSelect").empty();
        //显示部门下拉列表
        showDepts("#updateDeptSelect");

        //清除文本框提示信息
        clearInputHelp("#emp_name_update_input");
        clearInputHelp("#emp_email_update_input");

        let this_btn = $(this);

        //通过前端回显数据
        $("#update_emp_id_p").html("id : " + $(this).attr("emp_id"));
        $("#empIdHidden").val(this_btn.attr("emp_id"));

        $("#emp_name_update_input").val($(this).attr("emp_name"));
        $("#emp_email_update_input").val($(this).attr("emp_email"));
        $("#emp_email_update_input").attr("origin", $(this).attr("emp_email"));

        if ($(this).attr("emp_gender") == "male") {
            $("#male_radio").prop("checked", true)
        } else if ($(this).attr("emp_gender") == "female") {
            $("#female_radio").prop("checked", true)
        }


        //调出修改模态框
        $("#updateEmpModal").modal({
            backdrop: "static"
        });

    })

    function showPageTextInfo(resp) {
        $("#pageTextInfo").empty();
        var pageInfo = resp.extend.pageInfo;
        $("#pageTextInfo").append("当前第" + pageInfo.pageNum + "页，共" + pageInfo.pages
            + "页，共" + pageInfo.total + " 条记录")
    }

    function showPageNavigation(resp) {
        $("#navigation").empty();
        var pageInfo = resp.extend.pageInfo;
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a> </a>").append("首页").attr("href", "#"));

        var lastPageLi = $("<li></li>").append($("<a> </a>").append("尾页").attr("href", "#"));

        var prevPageLi = $("<li></li>").append($("<a> </a>").append("&laquo;").attr("href", "#"));
        var nextPageLi = $("<li></li>").append($("<a> </a>").append("&raquo;").attr("href", "#"));

        ul.append(firstPageLi);
        if (pageInfo.isFirstPage) {
            firstPageLi.addClass("disabled");
        } else {
            ul.append(prevPageLi);
        }


        $.each(pageInfo.navigatepageNums, function (index, item) {
            var pageLi = $("<li></li>").append($("<a> </a>").append(item).attr("href", "#"));
            if (pageInfo.pageNum == item) {
                pageLi.addClass("active");
            }
            ul.append(pageLi);
            pageLi.click(function () {
                toPage(item);
            });
        });
        if (pageInfo.isLastPage) {
            lastPageLi.addClass("disabled");
        } else {
            ul.append(nextPageLi);
        }
        firstPageLi.click(function () {
            toPage(1);
        });
        lastPageLi.click(function () {
            toPage(pageInfo.pages);
        });
        prevPageLi.click(function () {
            toPage(pageInfo.pageNum - 1);
        });
        nextPageLi.click(function () {
            toPage(pageInfo.pageNum + 1);
        });


        ul.append(lastPageLi);

        var nav = $("<nav></nav>").append(ul);
        nav.appendTo("#navigation");
    }

    //清除输入框提示信息
    function clearInputHelp(ele) {
        show_validate_msg(ele, "", "");
        $(ele).parent().removeClass("has-success has-error");
    }

    // 点击新增按钮弹出模态框
    $("#addEmpModalBtn").click(function () {
        document.getElementById("newEmp").reset();//重置表单
        //清除提示信息
        clearInputHelp("#newEmpEmailInput");
        clearInputHelp("#newEmpNameInput");
        // show_validate_msg("#newEmpEmailInput", "", "");
        // show_validate_msg("#newEmpNameInput", "", "");
        // $("#newEmpNameInput").parent().removeClass("has-success has-error");
        // $("#newEmpEmailInput").parent().removeClass("has-success has-error");

        $("#deptSelect").empty();
        showDepts("#deptSelect");
        $("#addEmpModal").modal({
            backdrop: "static"
        });

    })
    //保存员工按钮单击事件
    $("#empSaveBtn").click(function () {

        //
        // if (1==1) {

        if (validate_add_form()) {
            saveEmp();

            //延时一秒跳转页面，防止数据库更新还没完成就跳转页面

            setTimeout(function () {
                toPage(totalPages + 1);
            }, timeout);
        }
    })
    //编辑员工
    function  updateEmp(){
        $.ajax({
            url: "${APP_PATH}/emp",
            //serialize()返回的是json形式的字符串,可以加上表单中没有的参数
            data: $("#updateEmpForm").serialize(),
            type: "PUT",
            success: function (resp) {
                console.log(resp);
                if (resp.code == 100) {
                    alert(resp.msg);
                    $("#updateEmpModal").modal("hide");
                    //延时一秒跳转页面，防止数据库更新还没完成就跳转页面
                    setTimeout(function () {
                        toPage(curPageNo);
                    }, time);

                } else if (resp.code == 200) {
                    //后端保存失败
                    // if(undefined!=resp.extend.)
                    if (undefined != resp.extend.errorFields.empName) {
                        show_validate_msg("#emp_ename_update_input", "error", resp.extend.errorFields.empName)
                    }
                    if (undefined != resp.extend.errorFields.empEmail) {
                        show_validate_msg("##emp_email_update_input", "error", resp.extend.errorFields.empEmail)
                    }
                }
            }
        });
    }

    //保存员工
    function saveEmp() {

        $.ajax({
            url: "${APP_PATH}/emp",
            data: $("#newEmp").serialize(),
            type: "POST",
            success: function (resp) {
                if (resp.code == 100) {
                    $('#addEmpModal').modal('hide');
                }
                //后端保存失败
                else if (resp.code == 200) {

                    if (undefined != resp.extend.errorFields.empName) {
                        show_validate_msg("#newEmpNameInput", "error", resp.extend.errorFields.empName)
                    }
                    if (undefined != resp.extend.errorFields.empEmail) {
                        show_validate_msg("#newEmpEmailInput", "error", resp.extend.errorFields.empEmail)
                    }
                }
                console.log(resp);


            }
        });
    }

    //后端校验邮箱是否重复
    function emailIsDup(ele) {
        $.ajaxSetup({
            async: false
        });
        var dup = false;
        $.ajax({
            url: "${APP_PATH}/checkEmail",
            data: "email=" + $(ele).val(),
            type: "GET",
            success: function (resp) {
                console.log(resp);
                if (resp.code == 200) {
                    // alert(resp.code);
                    dup = true;//
                    /**
                     * 由于ajax请求默认是异步的，就是说发送ajax请求后不等待服务器响应就执行ajax请求后的代码，
                     * 因此 emailIsDup = true 不能被被return，导致emailIsDup(ele)的返回值始终是FALSE
                     * */
                    // return true;
                    // alert(emailIsDup);
                }
            }
        });
        return dup;
    }


    // 前端校验新增界面输入框
    $("#newEmpNameInput").change(function () {
        validate_nameInput(this);
    })
    $("#newEmpEmailInput").change(function () {
        validate_emailInput(this);
        if (emailIsDup(this)) {
            // alert("1111111");
            show_validate_msg(this, "error", "邮箱已被使用");
        }

    })

    function validate_nameInput(ele) {
        var rexName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        var checkStatus = validate_input(ele, rexName);
        var status = "success";
        var msg = "用户名可用";
        if (!checkStatus) {
            status = "error";
            msg = "用户名只可以是2-5位中文或者6-16位英文和数字的组合";
        }
        show_validate_msg(ele, status, msg);
        return checkStatus;
    }

    function validate_emailInput(ele) {
        var rexEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;

        var checkStatus = validate_input(ele, rexEmail);
        var status = "success";
        var msg = "邮箱名合法";
        if (!checkStatus) {
            status = "error";
            msg = "邮箱名不合法";
        }
        show_validate_msg(ele, status, msg);

        return checkStatus;
    }

    function validate_input(ele, rex) {
        var input = $(ele).val();
        var checkStatus = true;
        if (!rex.test(input)) {
            checkStatus = false;
        }
        return checkStatus;
    }
    function validate_update_form() {
        var formatCheck = validate_nameInput("#emp_name_update_input") && validate_emailInput("#emp_email_update_input");
        var emailDup = emailIsDup("#emp_email_update_input");
        if(emailDup&&($("#emp_email_update_input").attr("origin")!=$("#emp_email_update_input").val())){

            show_validate_msg("#emp_email_update_input","error","邮箱已被使用");
            return false;
        }
        return formatCheck ;

    }
    function validate_add_form() {
        var formatCheck = validate_nameInput("#newEmpNameInput") && validate_emailInput("#newEmpEmailInput");
        var emailDup = emailIsDup("#newEmpEmailInput");
        if(emailDup){
            show_validate_msg("#newEmpEmailInput","error","邮箱已被使用");
            return false;
        }
        return formatCheck && (!emailDup);

    }

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //编辑确定按钮单击事件
    //编辑员工
    $("#updateEmpBtn").click(function () {
        // if(1==1){
        //检查格式
        if(validate_update_form()){
                updateEmp();
        }

    })


</script>

</body>
</html>
