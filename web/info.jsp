<%@ taglib prefix="s" uri="/struts-tags" %>
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
	<title>信息-ProJ</title>
	<script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="icon" href="j_icon.png">
</head>

<body>
<div class="container">
	<%--信息展示模块--%>
	<div class="row col-md-offset-3 col-md-6">
		<div style="margin: 30px 10px; padding: 20px 25px 66px; border:solid 1px rgb(221, 221, 221);border-radius: 4px">
			<div class="row">
				<h4 class="lead text-left" style="margin: 10px 0;">信息-ProJ</h4>
			</div>
			<hr>
			<div class="row" style="padding: 10px 5px;">
				<div class="col-xs-3">昵称</div>
				<div class="col-xs-9">${sessionScope.nowUser.name}</div>
			</div>
			<div class="row" style="padding: 10px 5px;">
				<div class="col-xs-3">邮箱</div>
				<div class="col-xs-9">${sessionScope.nowUser.email}</div>
			</div>
			<div class="form-group col-xs-4" style="padding: 6px 0;">
				<button type="button" class="btn btn-primary" id="alter">
					修改信息
				</button>
			</div>
			<div class="form-group col-xs-4 text-center" style="padding: 6px 0">
				<a href="userAction_signOut">
					<button type="button" class="btn btn-info" id="sign_out">
						退出登录
					</button>
				</a>
			</div>
			<div class="form-group col-xs-4" style="padding: 6px 0;">
				<button type="button" class="btn btn-danger" id="log_out" style="float: right;">
					注销账户
				</button>
			</div>
		</div>
	</div>
	<%--修改信息模块--%>
	<div class="row col-md-offset-3 col-md-6" style="display: none" id="edit_area">
		<div style="margin: 0 10px; padding: 20px 25px 150px; border:solid 1px rgb(221, 221, 221);border-radius: 4px">
			<form role="form" action="userAction_changeInfo" method="post">
				<!--昵称-->
				<div class="form-group has-feedback" id="name_div">
					<label for="name" class="control-label col-xs-4" style="padding-left: 0">new昵称:</label>
					<small class="text-right col-xs-8" id="name_info"></small>
					<input class="form-control" type="text" name="name" id="name" value="<s:property value="#session.nowUser.name"/>">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="name_span"></span>
				</div>

				<!--邮箱-->
				<div class="form-group has-feedback" id="email_div">
					<label for="email" class="control-label col-xs-4" style="padding-left: 0">new邮箱:</label>
					<small class="text-right col-xs-8" id="email_info"></small>
					<input class="form-control" type="text" name="email" id="email" value="<s:property value="#session.nowUser.email"/>">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="email_span"></span>
				</div>

				<!--密码-->
				<div class="form-group has-feedback" id="passwords_div">
					<label for="passwords" class="control-label col-xs-4" style="padding-left: 0">new密码:</label>
					<small class="text-right col-xs-8" id="passwords_info"></small>
					<input class="form-control" type="password" name="password" id="passwords">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="passwords_span"></span>
				</div>

				<!--密码-->
				<div class="form-group has-feedback" id="repass_div">
					<label for="repass" class="control-label col-xs-4" style="padding-left: 0">new重复密码:</label>
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
				<!--提交按钮-->
				<div class="form-group col-xs-12" style="padding: 0;">
					<button type="submit" class="btn btn-primary" disabled="disabled" id="commit" style="float: right;">
						提交修改
					</button>
				</div>
			</form>
		</div>
	</div>

	<%--注销模块--%>
	<div class="row col-md-offset-3 col-md-6" style="display: none" id="out_area">
		<div style="margin: 0 10px; padding: 20px 25px 150px; border:solid 1px rgb(221, 221, 221);border-radius: 4px">
			<form role="form" action="userAction_logOut" method="post">
				<!--邮箱-->
				<div class="form-group has-feedback" id="email_div_out">
					<label for="email" class="control-label col-xs-4" style="padding-left: 0">邮箱:</label>
					<small class="text-right col-xs-8" id="email_info_out"></small>
					<input class="form-control" type="text" name="email" id="email_out" disabled value="<s:property value="#session.nowUser.email"/>">
					<span class="glyphicon form-control-feedback" aria-hidden="true" id="email_span_out"></span>
				</div>
				<!--邮箱验证码-->
				<div class="form-group has-feedback" id="vc_div_out">
					<label for="vc" class="control-label col-xs-4" style="padding-left: 0">验证码:</label>
					<div class="col-xs-8" style="padding: 0;">
						<input class="form-control" type="text" name="vc" id="vc_out">
						<span class="glyphicon form-control-feedback" aria-hidden="true" id="vc_span_out"></span>
					</div>
					<div class="col-xs-8" style="height: 64px">
						<p style="margin: 20px 0;" class="text-right">
							<small class="text-right" id="vc_info_out"></small>
						</p>
					</div>
					<div class="col-xs-4" style="padding: 0;">
						<button id="send_email_out" class="btn btn-default" type="button"
						        style="margin: 15px 0; float: right;">
							发送验证码
						</button>
					</div>
				</div>
				<!--注销按钮-->
				<div class="form-group col-xs-12" style="padding: 0;">
					<button type="submit" class="btn btn-danger" disabled="disabled" id="commit_out" style="float: right;">
						注销账户
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function () {
		$("#alter").click(function () {
			$("#out_area").css("display", "none");
			$("#edit_area").css("display", "block");
		});
		$("#log_out").click(function () {
			$("#edit_area").css("display", "none");
			$("#out_area").css("display", "block");

		});

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
					$("#commit").removeAttr("disabled");
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
				$("#commit").attr("disabled", "disabled");
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
				$("#commit").attr("disabled", "disabled");
				checkEmail = false;
			} else {
				$("#email_info").empty();
				$("#email_span").removeClass("glyphicon-remove");
				$("#email_span").addClass("glyphicon-ok");
				$("#email_div").removeClass("has-error");
				$("#email_div").addClass(("has-success"));
				checkEmail = true;
				if (checkPasswords && checkName && checkRepass && checkVc) {
					$("#commit").removeAttr("disabled");
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
				$("#commit").attr("disabled", "disabled");
				checkPasswords = false;
			} else {
				$("#passwords_info").empty();
				$("#passwords_span").removeClass("glyphicon-remove");
				$("#passwords_span").addClass("glyphicon-ok");
				$("#passwords_div").removeClass("has-error");
				$("#passwords_div").addClass(("has-success"));
				checkPasswords = true;
				if (checkEmail && checkName && checkVc && checkRepass) {
					$("#commit").removeAttr("disabled");
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
					$("#commit").removeAttr("disabled");
				}
			} else {
				//两次密码不一致
				$("#repass_info").text("两次输入的密码不一致");
				$("#repass_info").addClass("text-danger");
				$("#repass_span").removeClass("glyphicon-ok");
				$("#repass_span").addClass("glyphicon-remove");
				$("#repass_div").removeClass("has-success");
				$("#repass_div").addClass(("has-error"));
				$("#commit").attr("disabled", "disabled");
				checkRepass = false;
			}
		});

		//ajax发送验证码
		$("#send_email").click(function () {
			$("#name").trigger("keyup");
			$("#email").trigger("keyup");
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

		//注销发送验证码
		$("#send_email_out").click(function () {
			$("#vc_info_out").text("约耗时10s,验证码发送中...");
			var send_email_data = {"email": $("#email_out").val()};
			$.post("userAction_sendEmail", send_email_data, function (dataBack2) {
				$("#vc_info_out").text(dataBack2);//验证码发送成功
			});
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
							$("#commit").removeAttr("disabled");
						}
					} else {
						//校验失败
						$("#vc_info").text("验证码不正确")
						$("#vc_info").addClass("text-danger");
						$("#vc_span").removeClass("glyphicon-ok");
						$("#vc_span").addClass("glyphicon-remove");
						$("#vc_div").removeClass("has-success");
						$("#vc_div").addClass(("has-error"));
						$("#commit").attr("disabled", "disabled");
						checkVc = false;
					}
				})
			}
		});

		//注销校验验证码
		var checkVcOut = false;
		$("#vc_out").keyup(function () {
			if (this.value.length == 6 && !checkVcOut) {
				$.post("userAction_checkVerificationCode", {"vc": this.value}, function (dataBack) {
					if ("success" == dataBack) {
						//校验成功
						//清空提示信息
						$("#vc_info_out").empty();
						//改变图标
						$("#vc_span_out").removeClass("glyphicon-remove");
						$("#vc_span_out").addClass("glyphicon-ok");
						//改变颜色
						$("#vc_div_out").removeClass("has-error");
						$("#vc_div_out").addClass(("has-success"));
						checkVcOut = true;
						$("#commit_out").removeAttr("disabled");
					} else {
						//校验失败
						$("#vc_info_out").text("验证码不正确")
						$("#vc_info_out").addClass("text-danger");
						$("#vc_span_out").removeClass("glyphicon-ok");
						$("#vc_span_out").addClass("glyphicon-remove");
						$("#vc_div_out").removeClass("has-success");
						$("#vc_div_out").addClass(("has-error"));
						$("#commit_out").attr("disabled", "disabled");
						checkVc = false;
					}
				})
			}
		});
	});


</script>
</body>
</html>
