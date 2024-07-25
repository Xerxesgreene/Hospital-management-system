<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.entity.Specalist"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.SpecialistDao"%>
<%@ page import="com.dao.BillDao" %>
<%@ page import="com.entity.Bill" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="com.dao.AppointmentDAO" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADD DOCTOR</title>
<%@include file="../component/allcss.jsp"%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<%@include file="navbar.jsp"%>
	<div class="container-fluid p-3">
		<div class="row">

			<div class="col-md-5 offset-md-4">
				<div class="card paint-card">
					<div class="card-body">
						
	<table border="1" class="table">
    <thead>
        <tr>
           
            <th>User Id</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%-- Fetch bills for the logged-in user from the database --%>
        <%
            BillDao billDao = new BillDao(DBConnect.getConn());
        		 List<Bill> billList = billDao.getAllBills();

                // Use a Set to keep track of unique pids
                Set<Integer> uniquePids = new HashSet<>();

                for (Bill bill : billList) {
                    // Check if pid is not in the set to avoid repetitions
                    if (uniquePids.add(bill.getPid())) {
            %>
                        <tr>
                            <td><%= bill.getPid() %></td>
                            <td><a href="ViewBillAdmin.jsp?pid=<%= bill.getPid() %>">View Details</a></td>
                        </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
						
					</div>
				</div>
			</div>


			
		</div>
	</div>
</body>
</html>