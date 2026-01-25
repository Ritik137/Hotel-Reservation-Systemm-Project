package web;

import dao.ReservationDao;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SetupServlet extends HttpServlet{
	private final ReservationDao dao = new ReservationDao();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			dao.createTableIfNotExists();
			resp.setContentType("text/plain");
			resp.getWriter().println("Table 'reservation ready!");
			
	}
}
