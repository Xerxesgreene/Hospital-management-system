package com.doctor.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.AppointmentDAO;
import com.db.DBConnect;
import com.entity.Appointment;

@WebServlet("/appAppointment")
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userid"));
        String fullname = req.getParameter("fullname");
        String gender = req.getParameter("gender");
        String age = req.getParameter("age");
        String appoint_date = req.getParameter("appoint_date");
        String appoint_time = req.getParameter("appoint_time");
        String email = req.getParameter("email");
        String phno = req.getParameter("phno");
        String diseases = req.getParameter("diseases");
        int doctor_id = Integer.parseInt(req.getParameter("doct"));
        String address = req.getParameter("address");

        Connection conn = null;
        try {
            conn = DBConnect.getConn();
            AppointmentDAO dao = new AppointmentDAO(conn);
            HttpSession session = req.getSession();

            // Check appointment availability
            if (!dao.isAppointmentAvailable(doctor_id, appoint_date, appoint_time)) {
                session.setAttribute("errorMsg", "The selected appointment slot is not available. Please choose another slot.");
                resp.sendRedirect("user_appointment.jsp");
                return;
            }

            Appointment ap = new Appointment(userId, fullname, gender, age, appoint_date, appoint_time, email, phno, diseases, doctor_id,
                    address, "Pending", "Pending");

            if (dao.addAppointment(ap)) {
                session.setAttribute("succMsg", "Appointment request sent Successfully");
                resp.sendRedirect("user_appointment.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server");
                resp.sendRedirect("user_appointment.jsp");
            }
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}