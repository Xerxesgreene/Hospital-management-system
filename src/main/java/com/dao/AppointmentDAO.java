package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.entity.Appointment;

public class AppointmentDAO {

	private Connection conn;

	public AppointmentDAO(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean addAppointment(Appointment ap) {
	    boolean f = false;

	    try {
	        // Check if the appointment slot is available
	        if (!isAppointmentAvailable(ap.getDoctorId(), ap.getAppoinDate(), ap.getAppoinTime())) {
	            // The slot is not available, return false
	            return false;
	        }

	        String sql = "INSERT INTO appointment(user_id, fullname, gender, age, appoint_date, appoint_time, email, phno, diseases, doctor_id, address, status, approval_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        try (PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, ap.getUserId());
	            ps.setString(2, ap.getFullName());
	            ps.setString(3, ap.getGender());
	            ps.setString(4, ap.getAge());
	            ps.setString(5, ap.getAppoinDate());
	            ps.setString(6, ap.getAppoinTime());
	            ps.setString(7, ap.getEmail());
	            ps.setString(8, ap.getPhNo());
	            ps.setString(9, ap.getDiseases());
	            ps.setInt(10, ap.getDoctorId());
	            ps.setString(11, ap.getAddress());
	            ps.setString(12, ap.getStatus());
	            ps.setString(13, ap.getApprovalStatus());

	            int i = ps.executeUpdate();
	            if (i == 1) {
	                f = true;
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return f;
	}
	public List<Appointment> getAllAppointmentByLoginUser(int userId) {
		List<Appointment> list = new ArrayList<Appointment>();
		Appointment ap = null;

		try {

			String sql = "select * from appointment where user_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ap = new Appointment();
				ap.setId(rs.getInt(1));
				ap.setUserId(rs.getInt(2));
				ap.setFullName(rs.getString(3));
				ap.setGender(rs.getString(4));
				ap.setAge(rs.getString(5));
				ap.setAppoinDate(rs.getString(6));
				ap.setAppoinTime(rs.getString(7));
				ap.setEmail(rs.getString(8));
				ap.setPhNo(rs.getString(9));
				ap.setDiseases(rs.getString(10));
				ap.setDoctorId(rs.getInt(11));
				ap.setAddress(rs.getString(12));
				ap.setStatus(rs.getString(13));
				ap.setApprovalStatus(rs.getString(14));
				list.add(ap);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Appointment> getAllAppointmentByDoctorLogin(int doctorId) {
		List<Appointment> list = new ArrayList<Appointment>();
		Appointment ap = null;

		try {

			String sql = "select * from appointment where doctor_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, doctorId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ap = new Appointment();
				ap.setId(rs.getInt(1));
				ap.setUserId(rs.getInt(2));
				ap.setFullName(rs.getString(3));
				ap.setGender(rs.getString(4));
				ap.setAge(rs.getString(5));
				ap.setAppoinDate(rs.getString(6));
				ap.setAppoinTime(rs.getString(7));
				ap.setEmail(rs.getString(8));
				ap.setPhNo(rs.getString(9));
				ap.setDiseases(rs.getString(10));
				ap.setDoctorId(rs.getInt(11));
				ap.setAddress(rs.getString(12));
				ap.setStatus(rs.getString(13));
				ap.setApprovalStatus(rs.getString(14));
				list.add(ap);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public Appointment getAppointmentById(int id) {

		Appointment ap = null;

		try {

			String sql = "select * from appointment where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ap = new Appointment();
				ap.setId(rs.getInt(1));
				ap.setUserId(rs.getInt(2));
				ap.setFullName(rs.getString(3));
				ap.setGender(rs.getString(4));
				ap.setAge(rs.getString(5));
				ap.setAppoinDate(rs.getString(6));
				ap.setAppoinTime(rs.getString(7));
				ap.setEmail(rs.getString(8));
				ap.setPhNo(rs.getString(9));
				ap.setDiseases(rs.getString(10));
				ap.setDoctorId(rs.getInt(11));
				ap.setAddress(rs.getString(12));
				ap.setStatus(rs.getString(13));
				ap.setApprovalStatus(rs.getString(14));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ap;
	}

	public boolean updateCommentStatus(int id, int doctId, String comm) {
	    boolean f = false;
	    try {
	        String sqlUpdateAppointment = "UPDATE appointment SET status=? WHERE id=? AND doctor_id=?";
	        try (PreparedStatement psUpdateAppointment = conn.prepareStatement(sqlUpdateAppointment)) {
	            psUpdateAppointment.setString(1, comm);
	            psUpdateAppointment.setInt(2, id);
	            psUpdateAppointment.setInt(3, doctId);

	            int i = psUpdateAppointment.executeUpdate();
	            if (i == 1) {
	                f = true;

	                String sqlInsertBill = "INSERT INTO bill (pid, appId, date) VALUES ((SELECT user_id FROM appointment WHERE id=?), ?, ?)";
	                try (PreparedStatement psInsertBill = conn.prepareStatement(sqlInsertBill)) {
	                    // Set values for the bill insertion
	                    psInsertBill.setInt(1, id);
	                    psInsertBill.setInt(2, id);
	                    
	                    // Assuming currentDate is a java.util.Date object representing the current date
	                    java.util.Date currentDate = new java.util.Date();
	                    // Convert the java.util.Date to java.sql.Date
	                    java.sql.Date sqlDate = new java.sql.Date(currentDate.getTime());
	                    // Set the date attribute
	                    psInsertBill.setDate(3, sqlDate);

	                    int rowsInserted = psInsertBill.executeUpdate();
	                    if (rowsInserted != 1) {
	                        // Handle the case where the insertion into the bill table fails
	                        f = false;
	                    }
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return f;
	}
	
	
	
	
	
	public boolean cancelAppointment(int id) {
	    boolean success = false;
	    try {
	        String sql = "DELETE FROM appointment WHERE id=?";
	        PreparedStatement preparedStatement = conn.prepareStatement(sql);
	        preparedStatement.setInt(1, id);

	        int affectedRows = preparedStatement.executeUpdate();
	        if (affectedRows == 1) {
	            success = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return success;
	}
	
	
	
	public boolean updateApprovalStatus(int id, String approvalStatus) {
	    boolean success = false;
	    try {
	        String sql = "UPDATE appointment SET approval_status=? WHERE id=?";
	        try (PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, approvalStatus);
	            ps.setInt(2, id);

	            int rowsAffected = ps.executeUpdate();
	            success = (rowsAffected > 0);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return success;
	}
	
	
	
	public List<Appointment> getAllAppointment() {
		List<Appointment> list = new ArrayList<Appointment>();
		Appointment ap = null;

		try {

			String sql = "select * from appointment order by id desc";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ap = new Appointment();
				ap.setId(rs.getInt(1));
				ap.setUserId(rs.getInt(2));
				ap.setFullName(rs.getString(3));
				ap.setGender(rs.getString(4));
				ap.setAge(rs.getString(5));
				ap.setAppoinDate(rs.getString(6));
				ap.setAppoinTime(rs.getString(7));
				ap.setEmail(rs.getString(8));
				ap.setPhNo(rs.getString(9));
				ap.setDiseases(rs.getString(10));
				ap.setDoctorId(rs.getInt(11));
				ap.setAddress(rs.getString(12));
				ap.setStatus(rs.getString(13));
				ap.setApprovalStatus(rs.getString(14));
				list.add(ap);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	public boolean isAppointmentAvailable(int doctorId, String appointDate, String appointTime) {
	    try {
	        String query = "SELECT * FROM appointment WHERE doctor_id = ? AND appoint_date = ? AND appoint_time = ?";
	        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
	            pstmt.setInt(1, doctorId);
	            pstmt.setString(2, appointDate);
	            pstmt.setString(3, appointTime);
	            
	            try (ResultSet rs = pstmt.executeQuery()) {
	                // If there is an appointment with the same date and time for the same doctor, return false
	                return !rs.next();
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

}