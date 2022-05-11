

<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
<style>
.dot {
  height: 5px;
  width: 5px;
  background-color: #090909dd;
  border-radius: 50%;
  display: inline-block;
}
</style>
<cfoutput>
	<!--/breadcrumbs -->
	<div class="w3l-breadcrumbs">
		<nav id="breadcrumbs" class="breadcrumbs">
			<div class="container page-wrapper">
				<a href="index.html">Home</a> » <span class="breadcrumb_last" aria-current="page">Plans</span>
			</div>
		</nav>
	</div>
	<!--//breadcrumbs -->
	<!--/pricing-->
	<section class="w3l-pricinghny">
		<div class="pricing-inner-info py-5">
			<div class="container py-lg-4">
			<div style="margin: 8px auto; display: block; text-align:center;">

<!---728x90--->

 
</div>
				<!--/pricing-info-grids-->
				<div class="pricing-info-grids">
				<cfset BookObj=CreateObject("component","component.moviesDetails")/>
            	<cfset bookings=BookObj.displayBookingData()/>
				<!--/pricing-info-grids-->
				<div class="pricing-info-grids">
					<cfloop QUERY="#bookings#">
					<!--/box-->
					<div class="price-box">
						<div class="grid grid-column-2">
							<div class="column">
								<h6 class="pricehead"><span class="fa fa-bullseye mr-3" aria-hidden="true"></span>
								#bookings.movieTitle#
								</h6>
							</div>
							<div class="column text-lg-center">
								<p class="price-title">
								 #DateFormat(bookings.ticket_date)# <span class="dot"></span> 
								 #TimeFormat(bookings.start_time)# <span class="dot"></span> #bookings.seat_count# Tickets</p>
							</div>
							<div class="column price-number text-md-right">
								<h3 class="pricing"> <sup class="pri1"><i class="fa fa-inr"></i></sup>#bookings.amount# 
								<!--<sup class="pri">99</sup>-->
								</h3>
								<a href="PrintPdf.cfm" class="btn read-button">Print Ticket</a>
							</div>
						</div>
					</div>
					<!--/box-->
					</cfloop>

				</div>
				<!--/pricing-info-grids-->
			</div>
		</div>
	</section>
	<!--//pricing-->
	<div style="margin: 8px auto; display: block; text-align:center;">

<!---728x90--->
 
</div>

</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>