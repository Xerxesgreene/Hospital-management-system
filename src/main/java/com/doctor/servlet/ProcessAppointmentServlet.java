package com.doctor.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.AppointmentDAO;
import com.db.DBConnect;

@WebServlet("/processAppointment")
public class ProcessAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get the appointment ID and selected appointment status from the form
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            String approvalStatus = request.getParameter("approvalStatus");

            // Call the AppointmentDAO method to update the appointment status
            AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnect.getConn());
            if ("Approve".equals(approvalStatus)) {
                appointmentDAO.updateApprovalStatus(appointmentId, "Approved");
            } else if ("Reject".equals(approvalStatus)) {
                appointmentDAO.updateApprovalStatus(appointmentId, "Rejected");
            }

            // Redirect back to the page displaying the appointments
            response.sendRedirect("doctor/patient.jsp"); // Update with the correct URL
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any exceptions or errors, perhaps redirecting to an error page
            response.sendRedirect("doctor/patient.jsp");
        }
    }
}