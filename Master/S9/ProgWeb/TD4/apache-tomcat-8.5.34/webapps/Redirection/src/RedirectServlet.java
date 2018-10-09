import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/redir")
public class RedirectServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		String paramValue = req.getParameter("request");

		PrintWriter out = resp.getWriter();
		if(paramValue == null) {
			out.println("<html>");
			out.println("<head>");
			out.println("</head>");
			out.println("<body>");
			out.println("Your request is empty please enter your request");
			out.println("<a href=\"index.html\"> <button type=\"button\" id=\"btn-back\"> Back </button></a>");
			out.println("</body>");
			out.println("</html>");
		}			
	}
}
