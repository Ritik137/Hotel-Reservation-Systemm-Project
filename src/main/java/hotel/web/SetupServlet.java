package hotel.web;

import hotel.dao.ReservationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/setup")
public class SetupServlet extends HttpServlet {
    private final ReservationDao dao = new ReservationDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        dao.createTableIfNotExists();
        resp.setContentType("text/plain");
        resp.getWriter().println("✅ Table 'reservations' ready!");
    }
}
