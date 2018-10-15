package tw.proj.action;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;
import tw.proj.Utils.UserUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * 校验用户提交的数据
 *
 * @author ljc
 * @date 2018/10/11
 */
@Component("userInterceptor")
public class UserInterceptor extends MethodFilterInterceptor {

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		//提交非法字符进行注册及修改资料,分别拦截到注册页及信息页,include方法:signUp changeInfo
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		boolean checkAll = UserUtils.checkAll(name, password, email);
		if (!checkAll) {
			//拦截
			if (request.getSession().getAttribute("nowUser") != null) {
				//已登录用户,跳转到信息页
				return "info";
			} else {
				//未登录用户,跳转到注册页
				return "signUp";
			}
		}

		//放行
		return invocation.invoke();
	}
}
