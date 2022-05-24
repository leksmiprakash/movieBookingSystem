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
				</div>
				<cfset BookObj=CreateObject("component","component.moviesDetails")/>
				<cfset bookings=BookObj.displayBookingID(#url.bookId#)/>
				
				<div class="row ab-grids-sec align-items-center">
					<div class="col-lg-6 ab-right">
						<img class="img-fluid" src="movie/#bookings.movieImg#" width="250px" height="150px">
					</div>
					
					<div class="col-lg-6 ab-left pl-lg-4 mt-lg-0 mt-5">
						<h3 class="hny-title">#bookings.movieTitle#</h3>
						<p class="mt-3">#bookings.movieDescription#</p>
						<div class="ready-more mt-4">
							<button class="btn read-button" id="rzp-button1">Pay Now <span class="fa fa-angle-double-right ml-2" aria-hidden="true"></span></button>	
						</div>
					</div>
				</div>
			
				<div class="w3l-counter-stats-info text-center">
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter">#bookings.seat_count#</p>
								<h4>Tickets</h4>

							</div>
						</div>
					</div>
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter">#bookings.showName#</p>
								<h4>Show</h4>

							</div>
						</div>
					</div>
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter">#bookings.amount#</p>
								<h4>Total Amount</h4>

							</div>
						</div>
					</div>
					<div class="stats_left">
						<div class="counter_grid">
							<div class="icon_info">
								<p class="counter" style="font-size:40px!important;">#DateFormat(bookings.ticket_date)#</p>
								<h4>Date</h4>
								<input type="text" name="rzrpmtid" value="" id="rzrpmtid" >
								
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" id="bookAmount" value="#bookings.amount#">
				<input type="hidden" id="bookId" value="#url.bookId#">
				
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
        alert(response.error.metadata.order_id);
        alert(response.error.metadata.payment_id);
});
document.getElementById('rzp-button1').onclick = function(e){
	//alert("fvdfv");
    rzp1.open();
    e.preventDefault();
}
</script>