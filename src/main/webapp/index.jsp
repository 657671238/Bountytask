<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>登陆</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">  
	<script src="./js/jquery-3.2.1.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<style type="text/css">
		.container {
			width:500px;
			margin-top:100px;
		}
		.welcome{
			margin-top:80px;
			margin-bottom:30px;
		}
		.register{
			float:right;
		}
	</style>
</head>
<body>
	<div class="container">
		<h3 class="text-center welcome">欢迎来到赏金任务系统</h3>
		<form action="loginServlet" method="post" class="form-horizontal loginform" role="form">
			<div class="form-group">
				<label for="firstname" class="col-sm-2 control-label">用户名</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="firstname"
							placeholder="请输入用户名" name="userName">
				</div>
			</div>
			<div class="form-group">
				<label for="lastname" class="col-sm-2 control-label">密码</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="lastname"
							placeholder="请输入密码" name="password">
				</div>
			</div>
			  <div class="form-group">
    			<div class="col-sm-offset-2 col-sm-10">
    				  <div class="checkbox">
        				<label>
       			 			  <input type="checkbox" id="checkpassword" value="1" name="checkbox">记住密码
      					  </label>
      					  <a class="register" href="registerpage.jsp"> 注册账号</a>
    					  </div>
  					  </div>
 				 </div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">登录</button>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		$(function(){	
			var message = "<%=request.getAttribute("message")%>";
			var ischeck = "<%=request.getAttribute("ischeck")%>";
		    var user = document.getElementsByTagName("input")[0];
            var pass = document.getElementsByTagName("input")[1];
            var check = document.getElementsByTagName("input")[2];
            var loUser = localStorage.user || "";
            var loPass = localStorage.pass || "";
     	    user.value = loUser;
     	    pass.value = loPass;
        	if(loUser !== "" && loPass !== ""){
/*         		localStorage.user = "";
        		localStorage.pass = ""; */
        		check.setAttribute("checked","");
            }
			if(message =="true"){
				if(ischeck =="true"){
					localStorage.user ="<%=request.getAttribute("username")%>";
					localStorage.pass ="<%=request.getAttribute("pwd")%>";
				}
				else{
					localStorage.user ="";
					localStorage.pass ="";
				}
				window.location.href="myMessageServlet";
			}else if(message=="false"){
				alert("账号密码输入错误");
				window.location.href="index.jsp";
			}
		});
	</script>
</body>
</html>