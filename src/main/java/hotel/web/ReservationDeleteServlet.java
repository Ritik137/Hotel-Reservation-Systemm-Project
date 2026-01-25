package hotel.web;

import java.io.IOException;

import hotel.dao.ReservationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reservation/delete")
public class ReservationDeleteServlet extends HttpServlet{
	private final ReservationDao dao = new ReservationDao();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		int id = Integer.parseInt(req.getParameter("id"));
		dao.deleteById(id);
		resp.sendRedirect(req.getContextPath() + "/reservation/list");
	}
}
