package hotel.web;

import hotel.dao.ReservationDao;
import hotel.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reservation/create")
public class ReservationCreateServlet extends HttpServlet {

    private final ReservationDao dao = new ReservationDao();

    @Override
    public void init() {
        dao.createTableIfNotExists(); // table auto create
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Reservation r = new Reservation();
        r.setGuestName(req.getParameter("guestName"));
        r.setEmail(req.getParameter("email"));
        r.setPhone(req.getParameter("phone"));
        r.setRoomType(req.getParameter("roomType"));
        r.setCheckIn(req.getParameter("checkIn"));
        r.setCheckOut(req.getParameter("checkOut"));

        try {
            dao.insert(r);
            req.getRequestDispatcher("/success.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
