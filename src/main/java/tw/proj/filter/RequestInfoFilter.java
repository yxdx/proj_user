package tw.proj.filter;

import org.apache.struts2.ServletActionContext;

import javax.servlet.*;
import java.io.IOException;

/**
 * 未登录状态下请求信息页,跳转至登录页面
 *
 * @author ljc
 * @date 2018/10/12
 */
public class RequestInfoFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		Object nowUser = ServletActionContext.getRequest().getSession().getAttribute("nowUser");
		if (nowUser == null) {
			//未登录,跳转至登录页面
			ServletActionContext.getResponse().sendRedirect("index.jsp");
		}
		//已登录,放行
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}
}
