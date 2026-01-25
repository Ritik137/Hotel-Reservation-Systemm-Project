package dao;

import com.ritik.hotel.model.Reservation;
import com.ritik.hotel.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class ReservationDao {

    public void createTableIfNotExists() {
        String sql = """
                CREATE TABLE IF NOT EXISTS reservations(
                    id INT PRIMARY KEY AUTO_INCREMENT,
                    guest_name VARCHAR(100) NOT NULL,
                    email VARCHAR(120) NOT NULL,
                    phone VARCHAR(20),
                    room_type VARCHAR(50),
                    check_in VARCHAR(20),
                    check_out VARCHAR(20)
                )
                """;

        try (Connection con = DBUtil.getConnection();
             Statement st = con.createStatement()) {
            st.execute(sql);
        } catch (Exception e) {
            throw new RuntimeException("Table create failed", e);
        }
    }

    public int insert(Reservation r) {
        String sql = """
                INSERT INTO reservations(guest_name, email, phone, room_type, check_in, check_out)
                VALUES(?, ?, ?, ?, ?, ?)
                """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getEmail());
            ps.setString(3, r.getPhone());
            ps.setString(4, r.getRoomType());
            ps.setString(5, r.getCheckIn());
            ps.setString(6, r.getCheckOut());

            return ps.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("Insert failed", e);
        }
    }
}
