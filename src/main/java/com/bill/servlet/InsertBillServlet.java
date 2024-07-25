package com.bill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.BillDao;
import com.db.DBConnect;

@WebServlet("/insertBill")
public class InsertBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get the appointmentId and userId parameters from the form
        String appointmentId = request.getParameter("appointmentId");
        String userId = request.getParameter("userId");

        // Create a BillDao instance
        BillDao billDao = new BillDao(DBConnect.getConn());

        try {
            // Call the insertBill method
            boolean result = billDao.insertBill(appointmentId, userId);

            if (result) {
                out.println("<h3>Insertion into bill table successful</h3>");
            } else {
                out.println("<h3>Insertion into bill table failed</h3>");
            }
        } finally {
            // Note: In a real-world application, consider using try-with-resources to close connections
            // Close resources (if needed)
            billDao.close(); // Assuming you have a close method in BillDao to close the connection
        }
    }
}
