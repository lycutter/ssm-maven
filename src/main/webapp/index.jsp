<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<!-- js版本太低会导致模态框不能弹出来，注意包的导入顺序，要先导入jquery -->
<%-- <script type="text/javascript" src="${APP_PATH }/js/jquery-1.8.3.js"></script> --%>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"></link>

</head>
<body>


	<!-- 添加员工按钮的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	      <!-- springMVC可以自动根据表单提交的数据封装对象，唯一的要求就是前端属性的name值要跟实例属性名一致 -->
   	      <!-- springMVC可以自动根据表单提交的数据封装对象，唯一的要求就是前端属性的name值要跟实例属性名一致 -->
	      
	      	<form class="form-horizontal">
	      	
	      	<!-- form-group属性：label是表单提示信息,id是该组件名称，name与实例属性名对应, type是数据类型 -->
	      	
	      		<!-- 员工姓名 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  	<!-- 员工email -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label" name=>email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@lycutter.com">
			      <span class="help-block"></span> 
			    </div>
			  </div>
			  	<!-- 性别 -->
 			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			    	<!-- 单选框 -->
			      <label class="radio-inline">
				  		<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
					</label>
				  <label class="radio-inline">
				 	 	<input type="radio" name="gender" id="gender2_add_input" value="F">女
					</label>
			    </div>
			  </div>
			  	<!--  -->
  			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    	<!-- 下拉列表 -->
			    	
			    	<select name="dId" class="form-control" id="dept_add_select">
						
			    	</select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">员工修改</h4>
	      </div>
	      <div class="modal-body">
	      <!-- springMVC可以自动根据表单提交的数据封装对象，唯一的要求就是前端属性的name值要跟实例属性名一致 -->
   	      <!-- springMVC可以自动根据表单提交的数据封装对象，唯一的要求就是前端属性的name值要跟实例属性名一致 -->
	      
	      	<form class="form-horizontal">
	      	
	      	<!-- form-group属性：label是表单提示信息,id是该组件名称，name与实例属性名对应, type是数据类型 -->
			  
			  <!-- 员工名字（不可修改） -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  
			  	<!-- 员工email -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label" name=>email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@lycutter.com">
			      <span class="help-block"></span> 
			    </div>
			  </div>
			  	<!-- 性别 -->
 			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			    	<!-- 单选框 -->
			      <label class="radio-inline">
				  		<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">男
					</label>
				  <label class="radio-inline">
				 	 	<input type="radio" name="gender" id="gender2_update_input" value="F">女
					</label>
			    </div>
			  </div>
			  	<!--  -->
  			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    	<!-- 下拉列表 -->
			    	
			    	<select name="dId" class="form-control" id="dept_update_select">
						
			    	</select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 搭建显示页面 -->
	<div class="container">
	
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button id="emp_add_modal_btn" class="btn btn-primary" >新增</button>
				<button id="emp_delete_all_btn" class="btn btn-danger">删除</button>
			</div>
		</div>
		
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>
							<input type="checkbox" id="check_all"/>
						</th>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<tbody id="emps_table_tbody">
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">

			</div>
			<!-- 分页条信息 -->
			<div clas="col-md-6" id="page_nav_area">
		
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var totalRecord, currentPage;
		
		// 页面加载完成后进入首页
		$(function() {
			to_Page(1);
		});
		
		// 跳转到第pn页
		function to_Page(pn) {
			$.ajax({
				url:"${APP_PATH}/emps", 
				data:"pn="+pn,
				type:"get",
				success:function(result) {
					//1. 解析并显示员工数据
					build_emps_table(result);
					//2. 解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页条信息
					build_page_nav(result);
				}
			});
		}
		
		// 从后台获取员工数据
		function build_emps_table(result) {
			
			// 先清空表格
			$("#emps_table_tbody").empty();
			
			var emps = result.extend.pageInfo.list;
			// 1. jquery提供的each遍历方法，第一个参数就是遍历元素，第二个参数就是遍历的回调函数
			$.each(emps, function(index, item) {
				// checkbox
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
				// 显示id
				var empIdTd = $("<td></td>").append(item.empId);
				// 显示员工姓名
				var empNameTd = $("<td></td>").append(item.empName);
				// 显示员工性别
				var gender = item.gender == 'M'?"男":"女"
				var genderTd = $("<td></td>").append(gender);
				// email
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				// 为编辑按钮添加一个自定义的属性，来表示当前员工的id
				editBtn.attr("edit-id", item.empId);		
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				// 为删除按钮添加一个自定义的属性，来表示当前员工的id
				delBtn.attr("delete-id", item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				// append方法执行完成之后返回原来的对象
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emps_table_tbody");
			});
		}
		// 解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页, 总共"+
					result.extend.pageInfo.pages+"页, 总共"+result.extend.pageInfo.total+"条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		
		// 构建分页导航
		function build_page_nav(result) {
			$("#page_nav_area").empty();
 			var ul = $("<ul></ul>").addClass("pagination");
 			
 			// 构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			
			if (result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
			
			if (result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			// 为元素添加翻页事件
			firstPageLi.click(function() {
				to_Page(1);
			});
			prePageLi.click(function() {
				var page = result.extend.pageInfo.pageNum - 1;
				if (page > 0) {
					to_Page(page);
				}
			});
			
			lastPageLi.click(function() {
				to_Page(result.extend.pageInfo.pages);
			});
			
			nextPageLi.click(function() {
				var page = result.extend.pageInfo.pageNum + 1;
				if (page <= result.extend.pageInfo.pages) {
					to_Page(page);
				}
			});
			
			// 添加构造首页和前一页
			ul.append(firstPageLi).append(prePageLi)
			// 1. jquery提供的each遍历方法，第一个参数就是遍历元素，第二个参数就是遍历的回调函数
			// 页码号
			$.each(result.extend.pageInfo.navigatepageNums, function(index, item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				} 
				numLi.click(function() {
					to_Page(item)
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		
		// 模态框重置方法
		function reset_form(ele) {
			$(ele)[0].reset();
			// 清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		// 点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			// 模态框弹出之前，重置各个框的信息
			reset_form("#empAddModal form");
			// $("#empAddModal form")[0].reset();
			//发送ajax请求查出部门信息，显示在下拉列表中
			getDepts("#dept_add_select");
			// 弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});	
		
		// 查出所有部门信息
		function getDepts(ele) {
			
			//在查找部门信息之前，先清空原来的，不然会有bug

			$(ele).empty()
			
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					// 拿到部门数据
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		// 校验表单数据
		function validate_add_form() {
			// 拿到要校验的数据
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (regName.test(empName) == false) {
				//校验信息包装成一个新的方法
				show_validate_msg("#empName_add_input", "error", "用户名应该是2-5位中文或者6-16位英文和数字组合");
				
				// alert("用户名应该是2-5位中文或者6-16位英文和数字组合");
				// $("#empName_add_input").parent().addClass("has-error");
				// $("#empName_add_input").next("span").text("用户名应该是2-5位中文或者6-16位英文和数字组合");
				return false;
			} else{
				show_validate_msg("#empName_add_input", "success", "");

				// $("#empName_add_input").parent().addClass("has-success");
				// $("#empName_add_input").next("span").text("");
			}
			
			var email = $("#email_add_input").val();
			var regEmail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			// var regEmail = ^/w+([-+.]/w+)*@/w+([-.]/w+)*/./w+([-.]/w+)*$;
			if (regEmail.test(email) == false) {
				
				
				show_validate_msg("#email_add_input", "error", "邮箱格式错误");
			    // alert("邮箱格式错误");
				// $("#email_add_input").parent().addClass("has-error");
				// $("#email_add_input").next("span").text("邮箱格式错误");
				return false;
			} else{
				show_validate_msg("#email_add_input", "success", "");
				// $("#email_add_input").parent().addClass("has-success");
				// $("#email_add_input").next("span").text("");
			}
			
			return true;
		}
		
		function show_validate_msg(ele, status, msg) {
			if (status == "success") {
				//alert(msg)
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);

			} else if (status == "error"){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);

			}
			
		}
		
		
		// 判断用户名是否存在
		$("#empName_add_input").change(function() {
			
			var empName = this.value

			
			//发送ajax请求校验用户名是否可用
			$.ajax({
				url:"${APP_PATH}/checkuser", 
				data:"empName=" + empName, 
				type:"POST",
				success:function(result) {
					if (result.code==100) {
						$("#emp_save_btn").attr("ajax-validate", "success");
						show_validate_msg("#empName_add_input", "success", "恭喜，用户名可用！");
					} else {
						$("#emp_save_btn").attr("ajax-validate", "error");
						show_validate_msg("#empName_add_input", "error", result.extend.validate_msg);

					}
				}
			});
		});
		
		// 点击员工保存
		$("#emp_save_btn").click(function() {
			// 保存模态框中的表单数据,应该先进行校验
		
/*  			if (!validate_add_form()){
				// alert("false")
				return false;
			} */
			
			// alert("为什么不会发起ajax请求")
			// 用户名重复检测是否通过：
			if ($(this).attr("ajax-validate") == "error") {
				return false;
			}
			
			
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),// 利用jquery的序列化把form表单的数据包装成实例对象
				success:function(result) {
					// alert(result.msg)
					// 后端校验结果返回
					if (result.code == 100) {
						// 保存成功后，关闭模态框，去到最后一页
						$("#empAddModal").modal('hide')
						to_Page(totalRecord);
					} else {
						// 校验失败，显示失败信息
						if (result.extend.errorFields.email != undefined) {
							// 显示邮箱错误信息
							show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
						}
						if (result.extend.errorFields.empName != undefined) {
							// 显示用户名错误信息
							show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);

						}
					}
					

				}
			})
		});
		
		//删除单个员工, 用.是因为是class类？
		$(document).on("click", ".delete_btn", function() {
			// 1.弹出确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text()
			var empId = $(this).attr("delete-id")
			if (confirm("确认删除["+empName+"]吗？")) {
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/" + empId, 
					type:"DELETE", 
					success:function(result){
						to_Page(currentPage);
					}
				});
			}
		});
		 
		
		// 点击编辑员工信息用.是因为是class类？
		// 按钮创建之前就绑定了事件，所以绑定不上
		// 可以在创建按钮的时候绑定事件
		// 也可以绑定点击.live(), 但jquery新版没有此方法，使用on方法进行替代
		$(document).on("click", ".edit_btn", function() {
			// 1. 查出员工信息和部门信息
			getDepts("#empUpdateModal select");
			getEmp($(this).attr("edit-id")); // this表示当前被点击的按钮
			
			$("#empUpdateModal").modal({
				backdrop:"static" // 点击背景模态框不消失
			});
			// 把员工id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
		});
		
		// 编辑员工信息，回显
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"GET",
				success:function(result){
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		// 点击更新保存员工信息
		$("#emp_update_btn").click(function(){
			// 1.验证邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			// var regEmail = ^/w+([-+.]/w+)*@/w+([-.]/w+)*/./w+([-.]/w+)*$;
			if (regEmail.test(email) == false) {
				show_validate_msg("#email_add_input", "error", "邮箱格式错误");
				return false;
			} else{
				show_validate_msg("#email_add_input", "success", "");
			}
			//2.发送ajax请求，保存更新的数据
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result) {
					// alert(result.msg);
					// 关闭对话框，回到修改页面
					$("#empUpdateModal").modal("hide");
					to_Page(currentPage);
					
				}
			});
		});

	// 完成全选/全不选
	$("#check_all").click(function(){
		// attr获取check是undefined，原生dom属性不可用, 使用prop获取自定义属性的值
		// $(this).prop("checked");
		
		// 可以理解为所有class为check_item的控件，其checked状态都跟this(check_all)的选中状态一样
		$(".check_item").prop("checked", $(this).prop("checked"));
		
		// 什么时候用document？
/* 		$(document).on("click", ".check_item", function() {
			// 判断本页元素是否全被选中
			// 被选中的checkbox个数是否等于该页中checkbox的个数
			var flag = $(".check_item:checked").length == $(".check_item").length
			$("#check_all").prop("checked", flag)
		}) */
	})
	
	$(document).on("click", ".check_item", function() {
			// 判断本页元素是否全被选中
			// 被选中的checkbox个数是否等于该页中checkbox的个数
			var flag = $(".check_item:checked").length == $(".check_item").length
			$("#check_all").prop("checked", flag)
		})
		
	//批量删除
  	$("#emp_delete_all_btn").click(function() {
		var empNames = "";
		var del_idstr = "";
		$.each($(".check_item:checked"), function(){
			// 组装员工名字
			empNames += $(this).parents("tr").find("td:eq(2)").text()+ ",";
			// 组装员工id
			del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
		})
		empNames = empNames.substring(0,empNames.length - 1);
		del_idstr = del_idstr.substring(0, del_idstr.length - 1);
		if (confirm("确认删除[" + empNames + "]吗？")) {
			// 发送ajax请求删除
			$.ajax({
				url:"${APP_PATH}/emp/" + del_idstr,
				type:"DELETE",
				success:function(result) {
					to_Page(currentPage);
				}
			});
		}
	}); 
	
	</script>
	
</body>
</html>