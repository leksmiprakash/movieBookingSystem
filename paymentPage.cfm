<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
<cfoutput>
	<!--/breadcrumbs -->
	<div class="w3l-breadcrumbs">
		<nav id="breadcrumbs" class="breadcrumbs">
			<div class="container page-wrapper">
			<a href="index.html">Home</a> » <span class="breadcrumb_last" aria-current="page">Payment Page</span>
			</div>
		</nav>
	</div>
 <!--//breadcrumbs -->
	<!-- /about-->
	<div class="w3l-ab-grids py-5">
		<form class="payment-card-form" id="payment-card-form" action="" method="post">
			<div class="container py-lg-4">
				<div style="margin: 8px auto; display: block; text-align:center;">
				<cfif StructKeyExists(session, "bookedArray")>
					<div id="message" class="alert alert-success" role="alert">
						#session.bookedArray[1]#
					</div>
				</cfif>
				</div>
				<cfset variables.DecrptKey = "abc!@" />
				<cfset BookObj=CreateObject("component","component.moviesDetails")/>
				<cfset variables.bookingId = Decrypt(URL.bookId, DecrptKey) />
				<cfset bookings=BookObj.displayBookingID(#bookingId#)/>
				
				<div class="row ab-grids-sec align-items-center">
					<div class="col-lg-6 ab-right">
						<img class="img-fluid" src="movie/#bookings.movieImg#" width="250px" height="150px">
					</div>
					
					<div class="col-lg-6 ab-left pl-lg-4 mt-lg-0 mt-5">
						<h3 class="hny-title" style="color:black;">#bookings.movieTitle#</h3>
						<p class="mt-3" style="color:black;">#bookings.movieDescription#</p>
						<div class="ready-more mt-4">
							<button class="btn read-button" id="rzp-button1">Pay Now <span class="fa fa-angle-double-right ml-2" aria-hidden="true"></span></button>	
						</div>
					</div>
				</div>
			
				<div class="w3l-counter-stats-info text-center">
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter" style="color:black;">#bookings.seat_count#</p>
								<h4>Tickets</h4>

							</div>
						</div>
					</div>
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter" style="color:black;">#bookings.showName#</p>
								<h4>Show</h4>

							</div>
						</div>
					</div>
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter" style="color:black;">#bookings.amount#</p>
								<h4>Total Amount</h4>

							</div>
						</div>
					</div>
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter" style="font-size:40px!important;color:black;">#DateFormat(bookings.ticket_date)#</p>
								<h4>Date</h4>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" name="bookAmount" id="bookAmount" value="#bookings.amount#">
				<input type="hidden" name="bookId" id="bookId" value="#bookingId#">
				<input type="hidden" name="userId" id="userId" value="#session.userID#">
				<input type="hidden" name="rzrpmtid" value="" id="rzrpmtid" >
			</div>
		</form>
	</div>
	<!-- //about-->
	
</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>
<button class="btn read-button" id="rzp-button1">Pay Now <span class="fa fa-angle-double-right ml-2" aria-hidden="true"></span></button>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
	var amt	= $('#bookAmount').val();
	var amount = amt*100;
	var options = {
    "key": "rzp_test_Yoskj273KESacG", // Enter the Key ID generated from the Dashboard
    "amount": amount, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
    "currency": "INR",
    "name": "ProShowz Movie Booking",
    "description": "Test Transaction",
    "image": "https://example.com/your_logo",
    
    "handler": function (response){
        $("#rzrpmtid").val(response.razorpay_payment_id);
		var form = $("#payment-card-form").closest("form");
		var formData = new FormData(form[0]);
		//console.log(formData);
		$.ajax({
			data:formData,
			type: "post",
			url: "component/moviesDetails.cfc?method=completePayment",
			dataType: "json",  
			cache : false,
			processData: false,
			contentType: false,
			success: function(dataResult)
			{ 
				window.location= dataResult; 
			},
				error: function (jqXHR, exception) {    
				console.log("err"+exception);
			}
		}); 
    },
    "prefill": {
        "name": "ProShowz Pvt Lmtd",
        "email": "ProShowz@example.com",
        "contact": "9999999999"
    },
    "notes": {
        "address": "ProShowz Corporate Office"
    },
    "theme": {
        "color": "#3399cc"
    }
	
};
var rzp1 = new Razorpay(options);
rzp1.on('payment.failed', function (response){
        alert(response.error.code);
        alert(response.error.description);
        alert(response.error.source);
        alert(response.error.step);
        alert(response.error.reason);
});
document.getElementById('rzp-button1').onclick = function(e){
	//alert("fvdfv");
    rzp1.open();
    e.preventDefault();
}
</script>