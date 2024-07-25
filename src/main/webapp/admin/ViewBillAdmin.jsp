<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.BillDao" %>
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
            text-align: right;
        }
    </style>
</head>
<body>

<c:if test="${empty userObj}">
    <c:redirect url="user_login.jsp"></c:redirect>
</c:if>

<div class="bill-details-container">
    <h2>Bill Details</h2>

    <!-- Payment Details -->
    <div class="payment-details">
        <%
            // Assuming you have a Bill object with billId
            int pid = Integer.parseInt(request.getParameter("pid")); // Retrieve pid from the request
            BillDao billDao = new BillDao(DBConnect.getConn());

            // Retrieve a list of AppIds associated with the given pid
            List<Integer> appIds = billDao.getAppIdsByPId(pid);

            AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnect.getConn());

            // Initialize total amount variable
            int totalAmount = 0;

            for (int appId : appIds) {
                Appointment appointment = appointmentDAO.getAppointmentById(appId);

                if (appointment != null) {
                    // Increment total amount for each row
                    totalAmount += 100;
        %>
            <p><strong>Payment Details</strong></p>
            <p>Name: <%= appointment.getFullName() %></p>
            <p>Date: <%= appointment.getAppoinDate() %></p>
        <%
                } else {
        %>
            <p>Appointment details not found for the given AppId <%= appId %>.</p>
        <%
                }
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
                <!-- Add more columns as needed -->
            </tr>
        </thead>
        <tbody>
            <!-- Replace the data below with actual data from your application -->
            <%
                // You can remove this condition, as the loop above will handle it
                // Check if the appointment is not null before rendering the details
                if (appIds != null && !appIds.isEmpty()) {
                    for (int appId : appIds) {
                        Appointment appointment = appointmentDAO.getAppointmentById(appId);
                        if (appointment != null) {
            %>
                <tr>
                    <td><%= appointment.getId() %></td>
                    <td><%= appointment.getUserId() %></td>
                    <td><%= appointment.getFullName() %></td>
                    <td><%= appointment.getGender() %></td>
                    <td><%= appointment.getAge() %></td>
                    <!-- Add more columns as needed -->
                </tr>
            <%
                        }
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Amount to be Paid -->
    <p class="amount-to-be-paid">Total Amount paid: ₹<%= totalAmount %></p>
</div>

</body>
</html>
