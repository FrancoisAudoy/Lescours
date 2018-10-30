import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/connect")
public class LogInServlet extends HttpServlet{

	@SuppressWarnings("unchecked")
	private void firstStep() {
		ServletContext context = getServletContext();
		Map<String,String> map = (HashMap<String, String>) context.getAttribute("map");

		if(map == null) {
			map = new HashMap<>();
			context.setAttribute("map", map);
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		firstStep();
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

	@SuppressWarnings("unchecked")
	private boolean isLogineValide(String id, String pass) {
		if(!(id == "" || id == null || pass == "" || pass == null)) {
			ServletContext context = getServletContext();
			HashMap<String, String> map = (HashMap<String, String>) context.getAttribute("map");
			if(map.get(id) == pass)
				return true;
		}
		return false;
	}
}
