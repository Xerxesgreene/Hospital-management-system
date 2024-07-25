

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Index page</title>
<%@include file="component/allcss.jsp"%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.3);
	 background-color: #001f3f;
	 color: #ffffff;
	 font-family: 'helvetica';
}


.custom-font {
        font-family: 'helvetica';

</style>
</head>

<body>
<%@include file="component/navbar.jsp"%>


<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="img/back.jpg" class="d-block w-100" alt="..." height="600px">
      
    </div>
    <div class="carousel-item">
      <img src="img/hms.jpg" class="d-block w-100" alt="..." height="600px">
    
    </div>
    <div class="carousel-item">
      <img src="img/hms12.jpg" class="d-block w-100" alt="..." height="600px">
     
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<div class="container p-4">
		<p class="text-center fs-1 custom-font">YOUR HEALTH OUR RESPONSIBILITY.</p>
		
		<p class="text-center fs-5 custom-font">Our Key Features:</p>

		<div class="row">
			<div class="col-md-8 mt-2">
				<div class="row">
					<div class="col-md-8">
						<div class="card paint-card">
							<div class="card-body">
								<p class="fs-5">100% Safety</p>
								<p>We assure you 100% safety in our hospitals because your well-being is our top priority.</p>
							</div>
						</div>
					</div>
					<div class="col-md-8 mt-2">
						<div class="card paint-card">
							<div class="card-body">
								<p class="fs-5">Clean Environment</p>
								<p>In our hospitals, a clean environment is not just a promise; it's a commitment to your health and comfort</p>
							</div>
						</div>
					</div>
					<div class="col-md-8 mt-2">
						<div class="card paint-card">
							<div class="card-body">
								<p class="fs-5">Friendly Doctors</p>
								<p>At our hospital, you'll find more than doctors; you'll find friends dedicated to your well-being.</p>
							</div>
						</div>
					</div>
					<div class="col-md-8 mt-2">
						<div class="card paint-card">
							<div class="card-body">
								<p class="fs-5">Medical Research</p>
								<p>At our hospital, we don't just provide care; we lead the way in medical research, shaping a healthier future for all.</p>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<img alt="" src="img/back2.jpg">
			</div>

		</div>
	</div>

	<hr>

	<div class="container p-3">
		<p class="text-center fs-3 ">Our Veteran Doctors</p>
		
		<div class="row">
			<div class="col-md-4">
				<div class="card paint-card">
					<div class="card-body text-center">
						<img src="img/doc.jpeg" width="350px" height="350px">
						<p class="fw-bold fs-3">Dr. Jefferson Farfan</p>
						<p class="fs-7">(CEO Chairman)</p>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card paint-card">
					<div class="card-body text-center">
						<img src="img/doc2.jpeg" width="350px" height="350px">
						<p class="fw-bold fs-3">Dr. Fikayo Tomori</p>
						<p class="fs-7">(Chief Doctor)</p>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card paint-card">
					<div class="card-body text-center">
						<img src="img/doc3.jpeg" width="350px" height="350px">
						<p class="fw-bold fs-3">Dr. Fiolla Voughan</p>
						<p class="fs-7">(Chief Doctor)</p>
					</div>
				</div>
			</div>

			

		</div>

	</div>
	<%@include file="component/footer.jsp" %>
	
</body>
</html>