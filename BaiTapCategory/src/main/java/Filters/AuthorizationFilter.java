package Filters;

import java.io.IOException;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/admin/*", "/manager/*", "/user/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String url = req.getRequestURI();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int roleId = user.getRoleid();
        
        if (roleId == 3 && url.startsWith(req.getContextPath() + "/admin")) {
            chain.doFilter(request, response);
        } else if (roleId == 2 && url.startsWith(req.getContextPath() + "/manager")) {
            chain.doFilter(request, response);
        } else if (roleId == 1 && url.startsWith(req.getContextPath() + "/user")) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp"); 
        }
    }
}