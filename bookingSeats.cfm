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
<cfset variables.userObject=CreateObject("component","component.moviesDetails")/>
<cfset variables.userData=userObject.getUserData(session.userID)/>
<div class="content">
	<br><br>
	<div class="main">
		<h2>Movie Booking</h2>
		<div class="demo">
			<div id="seat-map">
				<div class="front">SCREEN</div>					
			</div>
			<cfset variables.movieObject=CreateObject("component","component.moviesDetails")/>
           	<cfset variables.singleMovie=movieObject.displayMovieShowsbyId(form.showId)/>
			<div class="booking-details">
				<ul class="book-left">
					<li>Movie </li>
					<li>Date </li>
					<li>Time </li>
					<li>Tickets</li>
					<li>Total</li>
					<li>Seats :</li>
				</ul>
				<form method="post" action="component/moviesDetails.cfc?method=bookingData" >
					<ul class="book-right">
						<li>: #singleMovie.movieTitle#</li>
						<li>: #DateFormat(Now())#</li>
						<li>:#TimeFormat(singleMovie.start_time)#</li>
						<li>: <span id="counter">0</span></li>
						<li>: <b><i>$</i><span id="total">0</span></b></li>
						
						<input type="hidden" name="bookMovie" value="#singleMovie.movieID#" >
						<input type="hidden" name="showId" value="#form.showId#" >
						<input type="hidden" name="bookCount" id="bookCount" value="0">
						<input type="hidden" name="bookTotal" id="bookTotal" value="0">	
						<input type="hidden" name="theatreId" value="#singleMovie.theatre_id#" >
						<input type="hidden" value="#singleMovie.price#" name="price" id="price" >
					</ul>

					<cfset variables.ShowObject=CreateObject("component","component.moviesDetails")/>
					<cfset variables.eachTimes=ShowObject.displayShowSeats(form.showId,form.ticketDate)/>
					<cfset variables.seatArray = ArrayNew(1) /> 
					<cfloop QUERY="#eachTimes#">
						<cfset ArrayAppend(variables.seatArray, "#no_seats#") />
					</cfloop>
					<cfset variables.myConvertedList=seatArray.toList() />
					<input type="hidden" value="#myConvertedList#" name="seatsA" id="seatsA" >
					<ul id="selected-seats" class="scrollbar scrollbar1"></ul>
					<input type="hidden" name="bookSeats" id="bookSeats" value="0">
					<input type="hidden" name="userEmail" id="userEmail" value="#userData.email#">
					<input type="hidden" name="ticketDate" id="ticketDate" value="#form.ticketDate#">
					<input type="hidden" name="userId" id="userId" value="#session.userID#">
					<button class="checkout-button" type="submit">Book Now</button>	
					<div id="legend"></div>
				</form>
			</div>
			<div style="clear:both"></div>
	    </div>

</cfoutput>
			<script type="text/javascript">
				var rate = $('#price').val(); //price
				var price = parseInt(rate);
				$(document).ready(function() {
					var $cart = $('#selected-seats'), //Sitting Area
					$counter = $('#counter'), //Votes
					$total = $('#total'), //Total money
					$bookCount = $('#bookCount'),
					$bookTotal = $('#bookTotal'); 
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
								$('<li>'+(this.settings.row+1)+'_'+this.settings.label+'</li>')
									.attr('id', 'cart-item-'+this.settings.id)
									.data('seatId', this.settings.id)
									.appendTo($cart);
								$counter.text(sc.find('selected').length+1);
								$total.text(recalculateTotal(sc)+price);
								$bookCount.val(sc.find('selected').length+1);
								$bookTotal.val(recalculateTotal(sc)+price);

								var bookedSeats = $('#selected-seats li').map(function(){ 
									return $(this).text(); 
								}).get().join(','); 
								$('#bookSeats').val(bookedSeats);

								return 'selected';
							} else if (this.status() == 'selected') { //Checked
									//Update Number
									$counter.text(sc.find('selected').length-1);
									$bookCount.val(sc.find('selected').length-1);
									//update totalnum
									$total.text(recalculateTotal(sc)-price);
									$bookTotal.val(recalculateTotal(sc)-price);	
									//Delete reservation
									$('#cart-item-'+this.settings.id).remove();

									var bookedSeats = $('#selected-seats li').map(function(){ 
										return $(this).text(); 
									}).get().join(','); 
									$('#bookSeats').val(bookedSeats);

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
					var seats = $("#seatsA").val();
					var soldSeats = seats.split(',');
					console.log(soldSeats);
					sc.get(soldSeats).status('unavailable');
						
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

			<!--<script>
            	var amt=200*100;
                var options = {
                    "key": (#application.rkey#), // Enter the Key ID generated from the Dashboard
                    "amount": amt,
                    "currency": "INR",
                    "name": "BookMyTicket",
                    "description": "Test Transaction",
                    "image": "assets/images/favicon.png",
                    //"callback_url": "components/booking.cfc?method=makePayment",
                    "prefill": {
                        "name": "#booking.username#",
                        "email": "#booking.email#",
                        "contact": "8111945425"
                    },
                    "notes": {
                        // "address": "Razorpay Corporate Office"
                    },
                    "theme": {
                        // "color": "##3399cc"
                    },
                    "handler": function (response)
                    {
                        // console.log(response.razorpay_payment_id);
                        // console.log($("##bookids").val());
                        //  console.log($("##userids").val());
                        //   console.log($("##pmttotamt").val());
                        // var bid=$("##bookids").val();
                        // var uid=$("##userids").val();
                        // var tamt=$("##pmttotamt").val();
                        $("##rzrpmtid").val(response.razorpay_payment_id);
                        var form = $("##payment-card-form").closest("form");
                        var formData = new FormData(form[0]);
                        $.ajax({
                            data:formData,
                            type: "post",
                            url: "components/booking.cfc?method=makePayment",
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
                    }
                };
                var rzp1 = new Razorpay(options);
                rzp1.on('payment.failed', function (response) {
                    alert("Payment failed,Please check your credentials");
                    // console.log("res"+response);
                    //     alert(response.error.code);
                    //     alert(response.error.description);
                    //     alert(response.error.source);
                    //     alert(response.error.step);
                    //     alert(response.error.reason);
                    //     alert(response.error.metadata.order_id);
                    //     alert(response.error.metadata.payment_id);
                });
                document.getElementById('rzp-button1').onclick = function (e) {
                    rzp1.open();
                    e.preventDefault();
                }
            </script>-->
			
	</div>


</html>
