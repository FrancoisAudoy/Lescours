

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/world")
public class HelloServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String paramValue = req.getParameter("name");
		
		if(paramValue != null )
			req.getSession().setAttribute("name", paramValue);
		else
			paramValue = (String) req.getSession().getAttribute("name");
		
		resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        
        out.println("<html>");
        out.println("<head>");
		out.println(" <link rel=\"stylesheet\" href=\"table.css\"/>");
		out.println("</head>");
        printHeaders(req, out);
        out.println("<body>");
        out.println("Hello " + paramValue + " !");
        out.println("</body>");
        out.println("</html>");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/html");
		String paramValue = req.getParameter("name");
		
		if(paramValue != null)
			req.getSession().setAttribute("name", paramValue);
		else
			paramValue = (String) req.getSession().getAttribute("name");
		
		PrintWriter out = resp.getWriter();
		String content = req.getReader().readLine();
		
		out.println("<html>");
		out.println("<head>");
		out.println(" <link rel=\"stylesheet\" href=\"table.css\"/>");
		out.println("</head>");
		out.println("<body>");
		printHeaders(req, out);	
		out.println("<br>Content :" + content +"</br>");
		out.println("Hello " + paramValue + " !");
		out.println("</body>");
		out.println("</html>");
	}
	
	private void printHeaders(HttpServletRequest req, PrintWriter out) {
        out.println("<b>Request Method: </b>" + req.getMethod() + "<br/>");
        out.println("<b>Request URI: </b>" + req.getRequestURI() + "<br/>");
        out.println("<b>Request Protocol: </b>" + req.getProtocol() + "<br/><br/>");
        out.println("<table><thead>\n");
        out.println("\t<tr>\n<th>Header Name</th><th>Header Value</th></tr>\n");
        out.println("</thead><tbody>");
        Enumeration headerNames = req.getHeaderNames();
        while(headerNames.hasMoreElements()) {
                String headerName = (String)headerNames.nextElement();
                out.println("\t<tr>\n\t\t<td>" + headerName + "</td>");
                out.println("<td>" + req.getHeader(headerName) + "</td>\n");
                out.println("\t</tr>\n");
        }
        out.println("</tbody></table>");
}

	
}
