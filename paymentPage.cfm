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
		<div class="container py-lg-4">
			<div style="margin: 8px auto; display: block; text-align:center;">
			</div>
			<cfset BookObj=CreateObject("component","component.moviesDetails")/>
			<cfset bookings=BookObj.displayBookingID(#url.bookId#)/>
			<cfloop query="bookings">
				<div class="row ab-grids-sec align-items-center">
					<div class="col-lg-6 ab-right">
						<img class="img-fluid" src="movie/#bookings.movieImg#" width="250px" height="150px">
					</div>
					
					<div class="col-lg-6 ab-left pl-lg-4 mt-lg-0 mt-5">
						<h3 class="hny-title">#bookings.movieTitle#</h3>
						<p class="mt-3">#bookings.movieDescription#</p>
						<div class="ready-more mt-4">
							<a href="##" class="btn read-button">Pay Now <span class="fa fa-angle-double-right ml-2" aria-hidden="true"></span></a>
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
								<p class="counter">5063</p>
								<h4>Year of Use</h4>

							</div>
						</div>
					</div>
				</div>
			</cfloop>
		</div>
	</div>
	<!-- //about-->
	<div style="margin: 8px auto; display: block; text-align:center;">
	</div>
	
	<div style="margin: 8px auto; display: block; text-align:center;">
	</div>
</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>