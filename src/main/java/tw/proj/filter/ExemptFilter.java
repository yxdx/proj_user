package tw.proj.filter;

import org.apache.struts2.ServletActionContext;
import tw.proj.Utils.UserUtils;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 免登陆,自动跳转至信息页
 *
 * @author ljc
 * @date 2018/10/12
 */
public class ExemptFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		Cookie[] cookies = httpServletRequest.getCookies();
		String information = "";
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("information".equals(cookie.getName())) {
					information = cookie.getValue();
					break;
				}
			}
		}
		if (!("".equals(information))) {
			Object nowUser = ServletActionContext.getRequest().getSession().getAttribute("nowUser");
			if (nowUser == null) {
				String email = UserUtils.getEmail(information);
				String password = UserUtils.getPasswords(information);
				httpServletResponse.setStatus(302);
				httpServletResponse.setHeader("Location", "userAction_signIn?email=" + email + "&password=" + password);
			}
		}
		chain.doFilter(request, response);

	}

	@Override
	public void destroy() {

	}
}
