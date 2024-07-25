<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.entity.Doctor"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>dashboard</title>
<%@include file="../component/allcss.jsp"%>
<style type="text/css">
 .paint-card {
        box-shadow: 8px 0 40px 0 rgba(1, 0, 0, 0.3);
         width: 120%;
        border: none;
    }

    .table th, .table td {
        text-align: center;
        vertical-align: middle;
    }

    .table thead th {
        background-color: #001f3f; /* Header background color */
        color: #ffffff; /* Header text color */
    }

    .table tbody tr:nth-child(even) {
        background-color: #f2f2f2; /* Alternate row background color */
    }

    .table tbody tr:hover {
        background-color: #cce5ff; /* Hovered row background color */
    }

    /* Style for buttons */
    .btn {
        margin-right: 0px;
        width: 80px;
    }
</style>
</head>
<body>
	<c:if test="${empty doctObj }">
		<c:redirect url="../doctor_login.jsp"></c:redirect>
	</c:if>

	<%@include file="navbar.jsp"%>
	<div class="container p-3">
		<div class="row">
			<div class="col-md-12">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-3 text-center">Patient Details</p>
						<c:if test="${not empty errorMsg}">
							<p class="fs-4 text-center text-danger">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<c:if test="${not empty succMsg}">
							<p class=" fs-4 text-center text-success">${succMsg}</p>
							<c:remove var="succMsg" scope="session" />
						</c:if>

						<table class="table">
							<thead>
								<tr>
									<th scope="col" style="width: 10%;">Name</th>
									<th scope="col" style="width: 10%;">Gender</th>
									<th scope="col" style="width: 10%;">Age</th>
									<th scope="col" style="width: 10%;">Appointment Date</th>
									<th scope="col" style="width: 10%;">Appointment Time</th>
									<th scope="col" style="width: 10%;">Email</th>
									<th scope="col" style="width: 10%;">Mob No</th>
									<th scope="col" style="width: 10%;">Diseases</th>
									<th scope="col" style="width: 10%;">Approve/Reject</th>
									<th scope="col" style="width: 10%;">Approval Status</th>								
									<th scope="col" style="width: 10%;">Action</th>
									<th scope="col" style="width: 10%;">Report</th>									
									<th scope="col" style="width: 10%;">Delete</th>
									
								</tr>
							</thead>
							<tbody>
								<%
								Doctor d = (Doctor) session.getAttribute("doctObj");
								AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
								List<Appointment> list = dao.getAllAppointmentByDoctorLogin(d.getId());
								for (Appointment ap : list) {
									String buttonDisabled = "disabled";
								    if ("Pending".equals(ap.getApprovalStatus())) {
								        buttonDisabled = "";
								    }
								%>
								<tr>
									<th class="align-middle"><%=ap.getFullName()%></th>
									<td class="align-middle"><%=ap.getGender()%></td>
									<td class="align-middle"><%=ap.getAge()%></td>
									<td class="align-middle"><%=ap.getAppoinDate()%></td>
									<td class="align-middle"><%=ap.getAppoinTime()%></td>
									<td class="align-middle"><%=ap.getEmail()%></td>
									<td class="align-middle"><%=ap.getPhNo()%></td>
									<td class="align-middle"><%=ap.getDiseases()%></td>
									
   <td class="align-middle">
    <form action="../processAppointment" method="post" class="form-inline">
        <input type="hidden" name="id" value="<%=ap.getId()%>">
        <div class="d-flex align-items-center">
           
            <select name="approvalStatus" class="form-control" style="min-width: 120px;">
                <option value="Approve">Approve</option>
                <option value="Reject">Reject</option>
            </select>
            <div class="form-group ml-2">
                <button type="submit" class="btn btn-primary btn-sm" <%= buttonDisabled %>>Submit</button>
            </div>
        </div>
    </form>
</td>

									<td class="align-middle"><%=ap.getApprovalStatus()%></td>
									
									<td class="align-middle">
										<%
										if ("Pending".equals(ap.getStatus())) {
										%> 
										<a href="comment.jsp?id=<%=ap.getId()%>"
										class="btn btn-success btn-sm">Comment</a>
										 <%
										 } else {
										 %> 
										 <a href="#" class="btn btn-success btn-sm disabled">Comment</a> 
										 <%
										 }
										 %>
									</td>
									<td class="align-middle"><%=ap.getStatus()%></td>
									
									<td class="align-middle">
										<a href="../cancelAppointment?id=<%=ap.getId()%>"
										class="btn btn-danger btn-sm">Delete</a>
									</td>
									
									
									
								</tr>
								<%
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