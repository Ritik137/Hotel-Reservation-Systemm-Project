package hotel.dao;

import hotel.model.Reservation;
import hotel.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ReservationDao
 * ----------------
 * This class handles all database operations (CRUD)
 * related to the "reservations" table.
 */
public class ReservationDao {

    /**
     * Creates the reservations table if it does not already exist.
     * This method is usually called once when the application starts.
     */
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

    /**
     * Inserts a new reservation record into the database.
     *
     * @param r Reservation object containing form data
     * @return number of rows inserted (should be 1)
     */
    public int insert(Reservation r) {
        String sql = """
          INSERT INTO reservations(guest_name, email, phone, room_type, check_in, check_out)
          VALUES(?,?,?,?,?,?)
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

    /**
     * Fetches all reservation records from the database.
     *
     * @return List of Reservation objects
     */
    public List<Reservation> findAll() {
        String sql = "SELECT * FROM reservations ORDER BY id DESC";
        List<Reservation> list = new ArrayList<>();

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setGuestName(rs.getString("guest_name"));
                r.setEmail(rs.getString("email"));
                r.setPhone(rs.getString("phone"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));

                list.add(r);
            }
            return list;

        } catch (Exception e) {
            throw new RuntimeException("FindAll failed", e);
        }
    }

    /**
     * Fetches a single reservation by ID.
     *
     * @param id Reservation ID
     * @return Reservation object or null if not found
     */
    public Reservation findById(int id) {
        String sql = "SELECT * FROM reservations WHERE id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setGuestName(rs.getString("guest_name"));
                r.setEmail(rs.getString("email"));
                r.setPhone(rs.getString("phone"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));

                return r;
            }

        } catch (Exception e) {
            throw new RuntimeException("FindById failed", e);
        }
    }

    /**
     * Updates an existing reservation record.
     *
     * @param r Reservation object with updated values
     * @return number of rows updated
     */
    public int update(Reservation r) {
        String sql = """
            UPDATE reservations
            SET guest_name=?, email=?, phone=?, room_type=?, check_in=?, check_out=?
            WHERE id=?
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getEmail());
            ps.setString(3, r.getPhone());
            ps.setString(4, r.getRoomType());
            ps.setString(5, r.getCheckIn());
            ps.setString(6, r.getCheckOut());
            ps.setInt(7, r.getId());

            return ps.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("Update failed", e);
        }
    }

    /**
     * Deletes a reservation by ID.
     *
     * @param id Reservation ID
     * @return number of rows deleted
     */
    public int deleteById(int id) {
        String sql = "DELETE FROM reservations WHERE id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("Delete failed", e);
        }
    }
}
