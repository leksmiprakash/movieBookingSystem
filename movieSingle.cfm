<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
<cfoutput>
    <section class="w3l-text-8 genre-single">
		<div class="text-bg-image">
		</div>
		<div class="container py-5">
			<div class="d-grid-1 py-lg-4">
				<div class="text">
					<h6 class="text-logo">Movie Details</h6>
					<div class="genre-single-page my-lg-5 my-4">
						<div class="row ab-grids-sec align-items-center">
                            <cfset variables.movieObject=CreateObject("component","component.moviesDetails")/>
							<cfset variables.DecrptKey = "abc!@" />
							<cfset variables.movieId = Decrypt(URL.id, DecrptKey) />
                            <cfset variables.singleMovie=movieObject.displayMoviebyId(#movieId#)/>
							<div class="col-lg-4 gen-right">
								<a href="##"><img class="img-fluid" src="movie/#singleMovie.movieImg#"></a>
							</div>
							<div class="col-lg-8 gen-left pl-lg-4 mt-lg-0 mt-5">
                                
								<h3 class="hny-title">#singleMovie.movieTitle#</h3>
								<p class="mt-2">#singleMovie.movieGenre#</p>
								<ul class="admin-post mt-1">
									<li>
										<a href="##"><span class="fa fa-clock-o"></span>#singleMovie.movieRelDate#</a>
									</li>
									<li>
										<a href="##"><span class="fa fa-user"></span> Admin</a>
									</li>
								</ul>
								<div class="share-more d-flex mt-4">
									
									<cfset variables.theratreShowObject=CreateObject("component","component.moviesDetails")/>
                            		<cfset variables.eachtheatres=theratreShowObject.displayMovietheatres(#movieId#)/>
									<table class="table table-bordered">
										<cfloop QUERY="#eachtheatres#">
											<tr>
												<th >#t_name#</th>
												<cfset variables.ShowTimeObject=CreateObject("component","component.moviesDetails")/>
                            					<cfset variables.eachTimes=ShowTimeObject.displayShowTimes(#movieId#,#theatre_id#)/>
												<form action="bookingSeats.cfm" method="post">
													<td>
														<select class="form-control" id="showId" name="showId">
															<option value="0">-----select-----</option>
															<cfloop QUERY="#eachTimes#">
																<option value="#s_id#"> #showName#-#TimeFormat(start_time)# </option>
															</cfloop>
														</select>
													</td>
													<td><input type="date" class="form-control " name="ticketDate" id="ticketDate"></td>
													<td><button type="submit" class="btn btn-info">Book</button></td>
												</form>
											</tr>
										</cfloop>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="genre-single-page mb-lg-5 mb-4">
						<div class="row ab-grids-sec">
							<div class="col-lg-5 gen-right-1">
								<p>#singleMovie.movieDescription#</p>
							</div>
							<div class="col-lg-6 gen-right-3">
								<div class="mb-3">
									<p><b>Director :</b> #singleMovie.movieDirector#</p>
								</div>
								<div class="mb-3">
									<p><b>Actors :</b> #singleMovie.movieActors#</p>
								</div>
								<div class="mb-3">
									<p><b>Duration :</b> #singleMovie.movieDuration#</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		</div>
	</section>
</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>
<script>
$(document).on('change','#showId' ,function(){
	var val = $('#showId option:selected').val();
	var text = $('#showId option:selected').text();
	var data = text.split('-');
	var date = new Date();
	var hours = date.getHours();
	var minutes = date.getMinutes();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	minutes = minutes < 10 ? '0'+minutes : minutes;
	var strTime = hours + ':' + minutes + ' ' + ampm;
	if(data[1] <= strTime){
		$('#ticketDate').attr('class', 'form-control openDate');
	}
	else{
		$('#ticketDate').attr('class', 'form-control closeDate');
	}
  	var dtToday = new Date();
	var month = dtToday.getMonth() + 1;
	var day = dtToday.getDate() +1;
	var year = dtToday.getFullYear();
	var openday = dtToday.getDate();
	var openyear = dtToday.getFullYear();
	if(month < 10)
		month = '0' + month.toString();
	if(day < 10)
		day = '0' + day.toString();
	var maxDate = year + '-' + month + '-' + day;
	//alert(maxDate);
	$('.closeDate').attr('min', maxDate);
	if(openday < 10)
		openday = '0' + openday.toString();
	var maxOpenDate = openyear + '-' + month + '-' + openday;
	//alert(maxOpenDate);
	$('.openDate').attr('min', maxOpenDate);
})
</script>