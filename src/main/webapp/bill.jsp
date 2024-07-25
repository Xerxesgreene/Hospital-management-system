<%@page import="com.entity.User"%>
<%@page import="com.entity.Doctor"%>
<%@page import="com.entity.Bill"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.BillDao"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Appointment</title>
<%@include file="component/allcss.jsp"%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}

.backImg {
	background: linear-gradient(rgba(0, 0, 0, .4), rgba(0, 0, 0, .4)),
		url("img/hospital.jpg");
	height: 20vh;
	width: 100%;
	background-size: cover;
	background-repeat: no-repeat;
}
</style>
</head>
<body>
	<c:if test="${empty userObj }">
		<c:redirect url="user_login.jsp"></c:redirect>
	</c:if>
	<%@include file="component/navbar.jsp"%>

	<%
        User user = (User) session.getAttribute("userObj");
        int userId = user.getId();
    %>

   
<div class="container p-3">
    <table border="1" class="table">
        <thead>
            <tr>
                <th>Bill ID</th>
                <th>Appointment ID</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%-- Fetch bills for the logged-in user from the database --%>
            <%
                BillDao billDao = new BillDao(DBConnect.getConn());
                List<Bill> billList = billDao.getBillsByUserId(userId);
                for (Bill bill : billList) {
            %>
   <tr>
            <td><%= bill.getBid() %></td>
            <td><%= bill.getAppId() %></td>
            <td><a href="ViewBill.jsp?billId=<%= bill.getBid() %>">View Details</a></td>
        </tr>
            <%
                }
            %>
        </tbody>
    </table>
    </div>
</body>
</html>