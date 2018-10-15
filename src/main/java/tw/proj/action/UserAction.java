package tw.proj.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import tw.proj.Utils.UserUtils;
import tw.proj.entity.User;
import tw.proj.service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author ljc
 * @date 2018/10/11
 */
@Controller("userAction")
@Scope("prototype")
public class UserAction extends ActionSupport implements ModelDriven<User> {
	@Resource(name = "userService")
	private UserService userService;
	private User user = new User();

	@Override
	public User getModel() {
		return this.user;
	}

	/**
	 * 注册-通过邮箱
	 * 需加入拦截器进行表单2次校验
	 */
	public String signUp() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		Object vcStatus = session.getAttribute("vcStatus");
		//验证当前提交的邮箱是否是之前接收过验证码的邮箱,及验证码是否正确
		if (!user.getEmail().equals(session.getAttribute("passEmail")) || !"pass".equals(vcStatus)) {
			//邮箱验证不通过,跳转至注册页
			return "signUp";
		}
		//邮箱验证通过,向数据库添加用户
		userService.addUser(user);
		//修正vcStatus值为验证等待,有bug,一次验证可以批量注册
		session.setAttribute("vcStatus", "wait");
		//改:修正vc值为null
		session.setAttribute("vc", null);
		//跳转至信息页
		return "info";
	}


	/**
	 * 登录
	 * 3天免登录
	 */
	public String signIn() {
		User userBack = userService.findUser(this.user);
		if (userBack == null) {
			//重新登录
			return "signIn";
		} else {
			//登录成功,并将此user添加进session中,以便修改资料时获取用户旧数据
			ServletActionContext.getRequest().getSession().setAttribute("nowUser", userBack);
			//设置3天免登录
			String cipherText = UserUtils.getCipherText(userBack.getEmail(), userBack.getPassword());
			Cookie cookie = new Cookie("information", cipherText);
			cookie.setMaxAge(60 * 60 * 24 * 3);
			ServletActionContext.getResponse().addCookie(cookie);
			//跳转到信息展示页面
			return "info";
		}

	}

	/**
	 * 退出登录
	 */
	public String signOut() {
		//清除session
		ServletActionContext.getRequest().getSession().removeAttribute("nowUser");
		//清除cookie
		Cookie[] cookies = ServletActionContext.getRequest().getCookies();
		delCookie(cookies);
		//跳转至登录页
		return "signIn";
	}

	/**
	 * 抽取方法,清除cookie
	 */
	private void delCookie(Cookie[] cookies) {
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("information".equals(cookie.getName())) {
					cookie.setValue("");
					cookie.setMaxAge(0);
					ServletActionContext.getResponse().addCookie(cookie);
					break;
				}
			}
		}
	}

	/**
	 * 修改资料
	 * 需加入拦截器进行表单2次拦截
	 */
	public String changeInfo() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		Object vcStatus = session.getAttribute("vcStatus");
		if (!"pass".equals(vcStatus) || !user.getEmail().equals(session.getAttribute("passEmail"))) {
			//邮箱验证不通过,跳转至信息页
			return "info";
		}
		//邮箱验证通过,修改数据
		User oldUser = (User) session.getAttribute("nowUser");
		userService.updateUser(oldUser, user);
		//修正vcStatus值为验证等待
		session.setAttribute("vcStatus", "wait");
		//修正vc值为null
		session.setAttribute("vc", null);
		//更新session中的nowUser
		session.setAttribute("nowUser", user);
		//bug:未更新cookie,导致自动登录无限重定向
		String cipherText = UserUtils.getCipherText(user.getEmail(), user.getPassword());
		Cookie cookie = new Cookie("information", cipherText);
		cookie.setMaxAge(60 * 60 * 24 * 3);
		ServletActionContext.getResponse().addCookie(cookie);
		//跳转至信息页
		return "info";
	}

	/**
	 * 注销
	 * 邮箱验证
	 */
	public String logOut() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		Object vcStatus = session.getAttribute("vcStatus");
		if (!"pass".equals(vcStatus)) {
			//邮箱验证不通过,跳转至信息页
			return "info";
		} else {
			//邮箱验证通过,从数库中删除此用户
			userService.deleteUser((User) session.getAttribute("nowUser"));
			//清除session
			session.removeAttribute("nowUser");
			//清除cookie
			Cookie[] cookies = ServletActionContext.getRequest().getCookies();
			delCookie(cookies);
		}
		//跳转至注册页
		return "signUp";
	}

	/**
	 * 通过邮件发送验证码
	 * ajax
	 */
	public String sendEmail() throws IOException {
		String recipient = ServletActionContext.getRequest().getParameter("email");
		boolean checkEmail = UserUtils.checkEmail(recipient);
		if (!checkEmail) {
			//响应邮箱格式错误
			ServletActionContext.getResponse().getWriter().write("邮箱格式错误");
		}
		//设置邮件主题
		String subject = "ProJ-验证码";
		//生成随机验证码,并存入session中
		String vc = UserUtils.generateVerificationCode();
		ServletActionContext.getRequest().getSession().setAttribute("vc", vc);
		//设置邮件内容,text/html
		String context = "<h3\talign=\"center\">验证码:" + vc + "</h3>";
		userService.sendMail(recipient, subject, context);
		//响应中文乱码
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().write("验证码发送成功");
		//将邮箱信息添加入session中,防止用户在完成验证后提交数据时更换邮箱
		ServletActionContext.getRequest().getSession().setAttribute("passEmail", recipient);
		return null;
	}

	/**
	 * 校验验证码
	 * ajax
	 */
	public String checkVerificationCode() throws IOException {
		String vcFromParam = ServletActionContext.getRequest().getParameter("vc");
		Object vcFromSession = ServletActionContext.getRequest().getSession().getAttribute("vc");
		if (vcFromSession != null) {
			if (vcFromSession.equals(vcFromParam)) {
				//邮箱验证成功,并添加成功状态至session,防止用户绕过邮箱验证进行数据提交
				ServletActionContext.getRequest().getSession().setAttribute("vcStatus", "pass");
				ServletActionContext.getResponse().getWriter().write("success");
			}
		} else {
			//邮箱验证失败
			ServletActionContext.getResponse().getWriter().write("error");
		}
		return null;
	}

	/**
	 * 查找邮箱是否已录入
	 * ajax
	 */
	public String findEmail() throws IOException {
		String email = ServletActionContext.getRequest().getParameter("email");
		User nowUser = (User) ServletActionContext.getRequest().getSession().getAttribute("nowUser");
		if (email != null) {
			if (nowUser != null) {
				if (email.equals(nowUser.getEmail())) {
					//此为修改信息操作,且不修改邮箱
					ServletActionContext.getResponse().getWriter().write(String.valueOf(false));
				}
			} else {
				boolean e = userService.findEmail(email);
				ServletActionContext.getResponse().getWriter().write(String.valueOf(e));

			}
		}
		return null;
	}

}
