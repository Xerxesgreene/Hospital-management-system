<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.BillDao" %>
<%@ page import="com.entity.Bill" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.entity.Doctor" %>
<%@ page import="com.dao.DoctorDao" %>
<%@ page import="com.entity.Appointment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="com.dao.AppointmentDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .bill-details-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .amount-to-be-paid {
            margin-top: 10px;
            text-align: right; /* Adjusted to right-align */
        }
    </style>
</head>
<body>

    <div class="bill-details-container">
        <h2>Bill Details</h2>

        <!-- Payment Details -->
        <div class="payment-details">
            <%
                // Assuming you have a Bill object with billId
                int billId = Integer.parseInt(request.getParameter("billId"));
                BillDao billDao = new BillDao(DBConnect.getConn());
                int appId = billDao.getAppIdByBillId(billId);

                AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnect.getConn());
                Appointment appointment = appointmentDAO.getAppointmentById(appId);

                // Check if the appointment is not null before rendering the details
                if (appointment != null) {
            %>
                <p><strong>Payment Details</strong></p>
                <p>Name: <%= appointment.getFullName() %></p>
                <p>Date: <%= appointment.getAppoinDate() %></p>
            <%
                } else {
            %>
                <p>Appointment details not found for the given billId.</p>
            <%
                }
            %>
        </div>

        <!-- Appointment Details Table -->
        <table>
            <thead>
                <tr>
                    <th>Appointment ID</th>
                    <th>User ID</th>
                    <th>Full Name</th>
                    <th>Gender</th>
                    <th>Age</th>
                    <th>Consulted Doctor Id</th>
                    <!-- Add more columns as needed -->
                </tr>
            </thead>
            <tbody>
                <!-- Replace the data below with actual data from your application -->
                <%
                    // Check if the appointment is not null before rendering the details
                    if (appointment != null) {
                %>
                    <tr>
                        <td><%= appointment.getId() %></td>
                        <td><%= appointment.getUserId() %></td>
                        <td><%= appointment.getFullName() %></td>
                        <td><%= appointment.getGender() %></td>
                        <td><%= appointment.getAge() %></td>
                        <td><%= appointment.getDoctorId() %></td>
                        <!-- Add more columns as needed -->
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Amount to be Paid -->
        <p class="amount-to-be-paid">Amount to be paid: ₹100</p>
        <form>
            <input type="button" value="Print Bill" onclick="window.print()" />
        </form>
    </div>
</body>
</html>
