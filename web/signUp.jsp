<%--
  Created by IntelliJ IDEA.
  User: ljc
  Date: 2018/10/13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>注册-ProJ</title>
	<script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="icon" href="j_icon.png">
</head>

<body>
<div class="container">
	<div class="row col-md-offset-3 col-md-6">
		<div style="margin: 30px 10px; padding: 20px 25px 150px; border:solid 1px rgb(221, 221, 221);border-radius: 4px">
			<form role="form" action="userAction_signUp" method="post">
				<!--昵称-->
				<div class="form-group has-feedback" id="name_div">
					<label for="name" class="control-label col-xs-4" style="padding-left: 0">昵称:</label>
					<small class="text-right col-xs-8" id="name_info"></small>
					<input class="form-control" type="text" name="name" id="name">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="name_span"></span>
				</div>

				<!--邮箱-->
				<div class="form-group has-feedback" id="email_div">
					<label for="email" class="control-label col-xs-4" style="padding-left: 0">邮箱:</label>
					<small class="text-right col-xs-8" id="email_info"></small>
					<input class="form-control" type="text" name="email" id="email">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="email_span"></span>
				</div>

				<!--密码-->
				<div class="form-group has-feedback" id="passwords_div">
					<label for="passwords" class="control-label col-xs-4" style="padding-left: 0">密码:</label>
					<small class="text-right col-xs-8" id="passwords_info"></small>
					<%--手误,将password错写为passwords--%>
					<input class="form-control" type="password" name="password" id="passwords">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="passwords_span"></span>
				</div>

				<!--密码-->
				<div class="form-group has-feedback" id="repass_div">
					<label for="repass" class="control-label col-xs-4" style="padding-left: 0">重复密码:</label>
					<small class="text-right col-xs-8" id="repass_info"></small>
					<input class="form-control" type="password" name="repass" id="repass">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="repass_span"></span>
				</div>


				<!--邮箱验证码-->
				<div class="form-group has-feedback" id="vc_div">
					<label for="vc" class="control-label col-xs-4" style="padding-left: 0">验证码:</label>
					<div class="col-xs-8" style="padding: 0;">
						<input class="form-control" type="text" name="vc" id="vc">
						<span class="glyphicon form-control-feedback" aria-hidden="true" id="vc_span"></span>
					</div>
					<div class="col-xs-8" style="height: 64px">
						<p style="margin: 20px 0;" class="text-right">
							<small class="text-right" id="vc_info"></small>
						</p>
					</div>
					<div class="col-xs-4" style="padding: 0;">
						<button id="send_email" class="btn btn-default" type="button"
						        style="margin: 15px 0; float: right;">
							发送验证码
						</button>
					</div>
				</div>


				<!--注册按钮-->
				<div class="form-group col-xs-6" style="padding: 0;">
					<button type="submit" class="btn btn-primary" disabled="disabled" id="sign_up">注册</button>
				</div>
				<!--登录按钮-->
				<div class="col-xs-6" style="padding: 0;">
					<p><a href="index.jsp" class="btn btn-default" role="button" style="float: right;">登录</a></p>
				</div>
			</form>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function () {
		var checkName = false;
		var checkEmail = false;
		var checkPasswords = false;
		var checkRepass = false;
		var checkVc = false;

		// 校验昵称
		$("#name").keyup(function () {
			var patt = new RegExp("^[a-zA-Z]\\w{3,11}$");
			if (patt.test(this.value)) {
				$("#name_info").empty();
				$("#name_span").removeClass("glyphicon-remove");
				$("#name_span").addClass("glyphicon-ok");
				$("#name_div").removeClass("has-error");
				$("#name_div").addClass(("has-success"));
				checkName = true;
				if (checkPasswords && checkEmail && checkVc && checkRepass) {
					$("#sign_up").removeAttr("disabled");
				}
			} else {
				var rex = new RegExp("[a-zA-Z]");
				if (!(rex.test(this.value.substring(0, 1)))) {
					$("#name_info").text("请以字母开头");
				} else if ((this.value.length < 4 || this.value.length > 12)) {
					$("#name_info").text("请输入4~12个字符");
				} else {
					$("#name_info").text("仅支持字母/数字/下划线");
				}
				$("#name_info").addClass("text-danger");
				$("#name_span").removeClass("glyphicon-ok");
				$("#name_span").addClass("glyphicon-remove")
				$("#name_div").removeClass("has-success");
				$("#name_div").addClass(("has-error"));
				$("#sign_up").attr("disabled", "disabled");
				checkName = false;
			}
		});

		// 校验邮箱
		var patt = new RegExp("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$");
		$("#email").keyup(function () {
			if (!patt.test(this.value)) {
				$("#email_info").text("请检查邮箱格式");
				$("#email_info").addClass("text-danger");
				$("#email_span").removeClass("glyphicon-ok");
				$("#email_span").addClass("glyphicon-remove");
				$("#email_div").removeClass("has-success");
				$("#email_div").addClass(("has-error"));
				$("#sign_up").attr("disabled", "disabled");
				checkEmail = false;
			} else {
				$("#email_info").empty();
				$("#email_span").removeClass("glyphicon-remove");
				$("#email_span").addClass("glyphicon-ok");
				$("#email_div").removeClass("has-error");
				$("#email_div").addClass(("has-success"));
				checkEmail = true;
				if (checkPasswords && checkName && checkRepass && checkVc) {
					$("#sign_up").removeAttr("disabled");
				}
			}
		});

		//校验密码
		$("#passwords").keyup(function () {
			if (this.value.length < 6 || this.value.length > 20) {
				$("#passwords_info").text("请输出6~12个字符");
				$("#passwords_info").addClass("text-danger");
				$("#passwords_span").removeClass("glyphicon-ok");
				$("#passwords_span").addClass("glyphicon-remove");
				$("#passwords_div").removeClass("has-success");
				$("#passwords_div").addClass(("has-error"));
				$("#sign_up").attr("disabled", "disabled");
				checkPasswords = false;
			} else {
				$("#passwords_info").empty();
				$("#passwords_span").removeClass("glyphicon-remove");
				$("#passwords_span").addClass("glyphicon-ok");
				$("#passwords_div").removeClass("has-error");
				$("#passwords_div").addClass(("has-success"));
				checkPasswords = true;
				if (checkEmail && checkName && checkVc && checkRepass) {
					$("#sign_up").removeAttr("disabled");
				}
				//触发#repass的keyup事件
				$("#repass").trigger("keyup");
			}
		});

		//校验重复密码
		$("#repass").keyup(function () {
			if ($("#passwords").val() === this.value) {
				//两次密码一致
				$("#repass_info").empty();
				$("#repass_span").removeClass("glyphicon-remove");
				$("#repass_span").addClass("glyphicon-ok");
				$("#repass_div").removeClass("has-error");
				$("#repass_div").addClass(("has-success"));
				checkRepass = true;
				if (checkEmail && checkName && checkVc && checkPasswords) {
					$("#sign_up").removeAttr("disabled");
				}
			} else {
				//两次密码不一致
				$("#repass_info").text("两次输入的密码不一致");
				$("#repass_info").addClass("text-danger");
				$("#repass_span").removeClass("glyphicon-ok");
				$("#repass_span").addClass("glyphicon-remove");
				$("#repass_div").removeClass("has-success");
				$("#repass_div").addClass(("has-error"));
				$("#sign_up").attr("disabled", "disabled");
				checkRepass = false;
			}
		});

		//ajax发送验证码
		$("#send_email").click(function () {
			if (checkEmail) {
				//查询邮箱是否已录入
				$.post("userAction_findEmail", {"email": $("#email").val()}, function (dataBack) {
					if (dataBack == "true") {
						//邮箱已存在
						$("#vc_info").text("该邮箱已注册,请登录");
					} else {
						//邮箱可用
						$("#vc_info").text("约耗时10s,验证码发送中...");
						var send_email_data = {"email": $("#email").val()};
						$.post("userAction_sendEmail", send_email_data, function (dataBack2) {
							$("#vc_info").text(dataBack2);//验证码发送成功
						});
					}
				});
			} else {
				$("#vc_info ").text("邮箱格式不正确");
			}
		});

		//ajax校验验证码
		$("#vc").keyup(function () {
			if (this.value.length == 6 && !checkVc) {
				$.post("userAction_checkVerificationCode", {"vc": this.value}, function (dataBack) {
					if ("success" == dataBack) {
						//校验成功
						//清空提示信息
						$("#vc_info").empty();
						//改变图标
						$("#vc_span").removeClass("glyphicon-remove");
						$("#vc_span").addClass("glyphicon-ok");
						//改变颜色
						$("#vc_div").removeClass("has-error");
						$("#vc_div").addClass(("has-success"));
						checkVc = true;
						if (checkName && checkEmail && checkPasswords && checkRepass) {
							$("#sign_up").removeAttr("disabled");
						}
					} else {
						//校验失败
						$("#vc_info").text("验证码不正确")
						$("#vc_info").addClass("text-danger");
						$("#vc_span").removeClass("glyphicon-ok");
						$("#vc_span").addClass("glyphicon-remove");
						$("#vc_div").removeClass("has-success");
						$("#vc_div").addClass(("has-error"));
						$("#sign_up").attr("disabled", "disabled");
						checkVc = false;
					}
				})
			}

		});
	});
</script>
</body>
</html>

