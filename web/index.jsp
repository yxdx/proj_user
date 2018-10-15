<%--
  Created by IntelliJ IDEA.
  User: ljc
  Date: 2018/10/9
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>登录-ProJ</title>
	<script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="icon" href="j_icon.png">
</head>

<body>
<div class="container">
	<div class="row col-md-offset-4 col-md-4">
		<div style="margin: 30px 10px; padding: 25px 25px 60px; border:solid 1px rgb(221, 221, 221);border-radius: 4px">
			<form role="form" action="userAction_signIn" method="post">
				<!--邮箱-->
				<div class="form-group has-feedback" id="email_div">
					<label for="email" class="control-label col-xs-4" style="padding-left: 0">邮箱:</label>
					<small class="text-right col-xs-8" id="email_info"></small>
					<input class="form-control" type="text" name="email" id="email" placeholder="xxx@xx.xxx">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="email_span"></span>
				</div>

				<!--密码-->
				<div class="form-group has-feedback" id="passwords_div">
					<label for="passwords" class="control-label col-xs-4" style="padding-left: 0">密码:</label>
					<small class="text-right col-xs-8" id="passwords_info"></small>
					<input class="form-control" type="password" name="password" id="passwords">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="passwords_span"></span>
				</div>

				<!--登录按钮-->
				<div class="form-group col-xs-6" style="padding-left: 0">
					<button type="submit" class="btn btn-primary" disabled="disabled" id="sign_in">登录</button>
				</div>
				<!--注册按钮-->
				<div class="col-xs-6">
					<p><a href="signUp.jsp" class="btn btn-default" role="button">注册</a></p>
				</div>
			</form>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function () {
		var checkEmail = false;
		var checkPasswords = false;
		var patt = new RegExp("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$");
		$("#email").keyup(function () {
			if (!patt.test(this.value)) {
				$("#email_info").text("请检查邮箱格式");
				$("#email_info").addClass("text-danger");
				$("#email_span").removeClass("glyphicon-ok");
				$("#email_span").addClass("glyphicon-remove");
				$("#email_div").removeClass("has-success");
				$("#email_div").addClass(("has-error"));
				$("#sign_in").attr("disabled", "disabled");
				checkEmail = false;
			} else {
				$("#email_info").empty();
				$("#email_span").removeClass("glyphicon-remove");
				$("#email_span").addClass("glyphicon-ok");
				$("#email_div").removeClass("has-error");
				$("#email_div").addClass(("has-success"));
				checkEmail = true;
				if (checkPasswords) {
					$("#sign_in").removeAttr("disabled");
				}
			}
		});

		$("#passwords").keyup(function () {
			if (this.value.length < 6 || this.value.length > 20) {
				$("#passwords_info").text("请输出6~12个字符");
				$("#passwords_info").addClass("text-danger");
				$("#passwords_span").removeClass("glyphicon-ok");
				$("#passwords_span").addClass("glyphicon-remove");
				$("#passwords_div").removeClass("has-success");
				$("#passwords_div").addClass(("has-error"));
				$("#sign_in").attr("disabled", "disabled");
				checkPasswords = false;
			} else {
				$("#passwords_info").empty();
				$("#passwords_span").removeClass("glyphicon-remove");
				$("#passwords_span").addClass("glyphicon-ok");
				$("#passwords_div").removeClass("has-error");
				$("#passwords_div").addClass(("has-success"));
				checkPasswords = true;
				if (checkEmail) {
					$("#sign_in").removeAttr("disabled");
				}
			}
		});

	})
</script>
</body>
</html>
