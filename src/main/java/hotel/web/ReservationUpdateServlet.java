package hotel.web;

import hotel.dao.ReservationDao;
import hotel.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reservation/update")
public class ReservationUpdateServlet extends HttpServlet {

    private final ReservationDao dao = new ReservationDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Reservation r = new Reservation();
        r.setId(id);
        r.setGuestName(req.getParameter("guestName"));
        r.setEmail(req.getParameter("email"));
        r.setPhone(req.getParameter("phone"));
        r.setRoomType(req.getParameter("roomType"));
        r.setCheckIn(req.getParameter("checkIn"));
        r.setCheckOut(req.getParameter("checkOut"));

        try {
            int rows = dao.update(r);
            req.setAttribute("rows", rows);
            req.getRequestDispatcher("/success.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
