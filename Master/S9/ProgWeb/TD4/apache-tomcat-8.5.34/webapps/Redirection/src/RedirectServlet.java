import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/redir")
public class RedirectServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		String user = (String) session.getAttribute("USER");
		if(user != null) {

			out.println("<!DOCTYPE html>\n" + 
					"<html>\n" + 
					"\n" + 
					"<head>\n" + 
					"  <meta charset=\"utf-8\" />\n" + 
					"   <title>POST</title>\n" + 
					"</head>\n" + 
					"\n" + 
					"<body>\n" + 
					"  <form action=\"redir\" method=\"POST\">\n" + 
					"    <h1>Hi " + user +", please give us your request</h1>\n" + 
					"    Request <input type=\"text\" name=\"request\"/>\n" +  
					"    <input type=\"submit\" value=\"send\" />\n" + 
					"</form>\n" + 
					" <a href=\"logout\"> <button type=\\\"button\\\" id=\\\"btn-back\\\"> logout </button></a>" +
					"</body>\n" + 
					"\n" + 
					"</html>");
		}
		else
			req.getRequestDispatcher("index.html").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		if(req.getSession().getAttribute("USER") != null) {
			String paramValue = req.getParameter("request");

			PrintWriter out = resp.getWriter();
			if(paramValue == "" ||paramValue == null) {
				out.println("<html>");
				out.println("<head>");
				out.println("</head>");
				out.println("<body>");
				out.println("Your request is empty please enter your request");
				out.println("<a href=\"redir\"> <button type=\"button\" id=\"btn-back\"> Back </button></a>");
				out.println("</body>");
				out.println("</html>");
			}			
			else {
				resp.sendRedirect("http://google.fr/#q="+paramValue);
			}
		}
	}
}
