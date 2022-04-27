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
                            <cfset variables.singleMovie=movieObject.displayMoviebyId(#url.id#)/>
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
									<a href="bookingSeats.cfm" class="btn read-button">Book Now</a>
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