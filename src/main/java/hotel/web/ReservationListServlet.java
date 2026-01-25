package hotel.web;

import hotel.dao.ReservationDao;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/reservation/list")
public class ReservationListServlet extends HttpServlet {
    private final ReservationDao dao = new ReservationDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("list", dao.findAll());
        req.getRequestDispatcher("/reservation-list.jsp").forward(req, resp);
    }
}
