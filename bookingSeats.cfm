<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
<style>
body{
	padding:0;
	margin:0;
    background:url(bookingAssets/images/banner2.jpg) no-repeat center;
    background-size: cover;
    -webkit-background-size: cover;
    -o-background-size: cover;
    -ms-background-size: cover;
    -moz-background-size: cover;
	font-family: 'Open Sans', sans-serif !important;
}
</style>
<cfoutput>
<div class="content">
	<br><br>
	<div class="main">
		<h2>Movie Booking</h2>
		<div class="demo">
			<div id="seat-map">
				<div class="front">SCREEN</div>					
			</div>
			<cfset variables.movieObject=CreateObject("component","component.moviesDetails")/>
           	<cfset variables.singleMovie=movieObject.displayMovieShowsbyId(#url.showId#)/>
			<div class="booking-details">
				<ul class="book-left">
					<li>Movie </li>
					<li>Date </li>
					<li>Time </li>
					<li>Tickets</li>
					<li>Total</li>
					<li>Seats :</li>
				</ul>
				<form>
					<ul class="book-right">
						<li>: #singleMovie.movieTitle#</li>
						<input type="hidden" name="bookMovie" value="#singleMovie.movieID#" >
						<li>: #DateFormat(Now())#</li>
						<input type="hidden" name="bookDate" value="#DateFormat(Now())#" >
						<li>:#TimeFormat(singleMovie.start_time)#</li>
						<input type="hidden" name="bookTime" value="#singleMovie.start_time#" >
						<li>: <span id="counter">0</span></li>
						<input type="hidden" name="bookCount" id="bookCount" >
						<li>: <b><i>$</i><span id="total">0</span></b></li>
						<input type="hidden" name="bookTotal" id="bookTotal" >
					</ul>
					<div class="clear"></div>
					<ul id="selected-seats" class="scrollbar scrollbar1"></ul>
					<input type="hidden" name="bookSeats" id="bookSeats" >
					<button class="checkout-button">Book Now</button>	
					<div id="legend"></div>
				</form>
			</div>
			<div style="clear:both"></div>
	    </div>

</cfoutput>
			<script type="text/javascript">
				// $.ajax({
				// 	type: "post",
				// 	url: 'component/moviesDetails.cfc?method=displayMovieShowsbyId',
				// 	data: {
				// 		editid: movieId
				// 	},
				// 	success: function(response) {
				// 		p = JSON.parse(response);
				// 		console.log(p);
				// 		$("#updateId").val(p.DATA[0][0]);
				// 		$("#movieTitle").val(p.DATA[0][2]);
				// 		$("#movieGenre").val(p.DATA[0][3]);
				// 		$("#movieDuration").val(p.DATA[0][4]);
						
				// 		let dateStr = new Date(p.DATA[0][5]);
				// 		var now = new Date(p.DATA[0][5]);
				// 		var day = ("0" + now.getDate()).slice(-2);
				// 		var month = ("0" + (now.getMonth() + 1)).slice(-2);
				// 		var today = now.getFullYear() + "-" + (month) + "-" + (day);
				// 		$("#movieRelDate").val(today);
				// 		$("#movieDirector").val(p.DATA[0][6]);
				// 		$("#movieActors").val(p.DATA[0][7]);
				// 		$("#old_file").val(p.DATA[0][1]);
				// 	}
				// });
				var price = 10; //price
				$(document).ready(function() {
					var $cart = $('#selected-seats'), //Sitting Area
					$counter = $('#counter'), //Votes
					$total = $('#total'); //Total money
					
					var sc = $('#seat-map').seatCharts({
						map: [  //Seating chart
							'aaaaaaaaaa',
							'aaaaaaaaaa',
							'__________',
							'aaaaaaaa__',
							'aaaaaaaaaa',
							'aaaaaaaaaa',
							'aaaaaaaaaa',
							'aaaaaaaaaa',
							'aaaaaaaaaa',
							'__aaaaaa__'
						],
						naming : {
							top : false,
							getLabel : function (character, row, column) {
								return column;
							}
						},
						legend : { //Definition legend
							node : $('#legend'),
							items : [
								[ 'a', 'available',   'Available' ],
								[ 'a', 'unavailable', 'Sold'],
								[ 'a', 'selected', 'Selected']
							]					
						},
						click: function () { //Click event
							if (this.status() == 'available') { //optional seat
								$('<li>Row-'+(this.settings.row+1)+' Seat-'+this.settings.label+'</li>')
									.attr('id', 'cart-item-'+this.settings.id)
									.data('seatId', this.settings.id)
									.appendTo($cart);

								$counter.text(sc.find('selected').length+1);
								$total.text(recalculateTotal(sc)+price);
											
								return 'selected';
							} else if (this.status() == 'selected') { //Checked
									//Update Number
									$counter.text(sc.find('selected').length-1);
									//update totalnum
									$total.text(recalculateTotal(sc)-price);
										
									//Delete reservation
									$('#cart-item-'+this.settings.id).remove();
									//optional
									return 'available';
							} else if (this.status() == 'unavailable') { //sold
								return 'unavailable';
							} else {
								return this.style();
							}
						}
					});
					//sold seat
					sc.get(['1_2', '4_4','4_5','6_6','6_7','8_5','8_6','8_7','8_8', '10_1', '10_2']).status('unavailable');
						
				});
				//sum total money
				function recalculateTotal(sc) {
					var total = 0;
					sc.find('selected').each(function () {
						total += price;
					});
							
					return total;
				}
			</script>
	</div>


</html>
