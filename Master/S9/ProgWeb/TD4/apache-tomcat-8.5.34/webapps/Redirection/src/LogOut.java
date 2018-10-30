import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/logout")
public class LogOut extends HttpServlet {


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		session.invalidate();
		req.getRequestDispatcher("index.html").forward(req, resp);
	}

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");

		if(isLogineValide(id, pass)) {
			HttpSession session = req.getSession();
			session.setAttribute("USER", id);
			resp.sendRedirect("redir");
		}			
		else {
			req.getRequestDispatcher("InvalidLog.html").forward(req, resp);
		}
	}
	
	private boolean isLogineValide(String id, String pass) {
		return !(id == "" || id == null || pass == "" || pass == null);
			
	}
}
