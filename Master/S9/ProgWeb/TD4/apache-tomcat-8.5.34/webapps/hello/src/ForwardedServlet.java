

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/forw")
public class ForwardedServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String paramValue = req.getParameter("name");
		
		resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Zavez été forwaded</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("Hello " + paramValue + " !");
		out.println("</br> Ici c'est FORWARDED !!!");
		out.println("</body>");
		out.println("</html>");
	}
}
