package web;

import java.io.IOException;

import dao.ReservationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reservation;

public class ReservationCreateServlet extends HttpServlet{
	 private final ReservationDao dao = new ReservationDao();

	    public void init() {
	        dao.createTableIfNotExists(); // server start pe table ready
	    }

	    @Override
	    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	        Reservation r = new Reservation();
	        r.setGuestName(req.getParameter("guestName"));
	        r.setEmail(req.getParameter("email"));
	        r.setPhone(req.getParameter("phone"));
	        r.setRoomType(req.getParameter("roomType"));
	        r.setCheckIn(req.getParameter("checkIn"));
	        r.setCheckOut(req.getParameter("checkOut"));

	        try {
	            int rows = dao.insert(r);
	            req.setAttribute("rows", rows);
	            req.getRequestDispatcher("/success.jsp").forward(req, resp);
	        } catch (Exception e) {
	            req.setAttribute("error", e.getMessage());
	            req.getRequestDispatcher("/error.jsp").forward(req, resp);
	        }
	    }
	}