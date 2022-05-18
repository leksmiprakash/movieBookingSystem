
<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
	<!-- main-slider -->
<cfoutput>
	<section class="w3l-main-slider position-relative" id="home">
		<div class="companies20-content">
			<div class="owl-one owl-carousel owl-theme">
				<div class="item">
					<li>
						<div class="slider-info banner-view bg bg2">
							<div class="banner-info">
								<h3>Latest Movie Trailers</h3>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<span class="over-para"> Consequuntur hic odio
									voluptatem tenetur consequatur.</span>
								</p>
							</div>
						</div>
					</li>
				</div>
				<div class="item">
					<li>
						<div class="slider-info  banner-view banner-top1 bg bg2">
							<div class="banner-info">
								<h3>Latest Online Movies</h3>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<span class="over-para"> Consequuntur hic odio
									voluptatem tenetur consequatur.</span>
								</p>
							</div>
						</div>
					</li>
				</div>
				<div class="item">
					<li>
						<div class="slider-info banner-view banner-top2 bg bg2">
							<div class="banner-info">
								<h3>Latest Movie Trailers</h3>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<span class="over-para"> Consequuntur hic odio
									voluptatem tenetur consequatur.</span>
								</p>
							</div>
						</div>
					</li>
				</div>
				<div class="item">
					<li>
						<div class="slider-info banner-view banner-top3 bg bg2">
							<div class="banner-info">
								<h3>Latest Online Movies</h3>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<span class="over-para"> Consequuntur hic odio
									voluptatem tenetur consequatur.</span>
								</p>
							</div>
						</div>
					</li>
				</div>
			</div>
		</div>
	</section>
	<!-- //banner-slider-->
	<!--grids-sec1-->
	<section class="w3l-grids">
		<div class="grids-main py-5">
			<div class="container py-lg-3">
				<div class="headerhny-title">
					<div class="w3l-title-grids">
						<div class="headerhny-left">
							<h3 class="hny-title">Popular Movies</h3>
						</div>
						<div class="headerhny-right text-lg-right">
							<h4><a class="show-title" href="movieListing.cfm">Show all</a></h4>
						</div>
					</div>
				</div>
				<cfset MoviesObj=CreateObject("component","component.moviesDetails")/>
                <cfset limitedMovies=MoviesObj.displayLimitedData()/>
				<div class="w3l-populohny-grids">
					<cfloop array="#limitedMovies#" item="limitedMovie">
						<div class="item vhny-grid">
							<div class="box16">
								<a href="movieSingle.cfm?id=#limitedMovie.getMovieID()#">
									<figure>
										<img class="img-fluid" src="movie/#limitedMovie.getMovieImg()#" alt="">
									</figure>
									<div class="box-content">
										<h3 class="title">#limitedMovie.getMovieTitle()#</h3>
										<h4> <span class="post"><span class="fa fa-clock-o"> </span>#limitedMovie.getMovieDuration()# Hrs</span>
											<span class="post fa fa-heart text-right"></span>
										</h4>
									</div>
								</a>
							</div>
						</div>
					</cfloop>
				</div>
			</div>
		</div>
	</section>
	<!--//grids-sec1-->
	<!--grids-sec2-->
	<section class="w3l-grids">
		<div class="grids-main py-5">
			<div class="container py-lg-3">
				<div class="headerhny-title">
					<div class="w3l-title-grids">
						<div class="headerhny-left">
							<h3 class="hny-title">New Releases</h3>
						</div>
						<div class="headerhny-right text-lg-right">
							<h4><a class="show-title" href="movieListing.cfm">Show all</a></h4>
						</div>
					</div>
				</div>
				<div class="owl-three owl-carousel owl-theme">
				<cfset MoviesObj=CreateObject("component","component.moviesDetails")/>
                <cfset newMovies=MoviesObj.displayNewData()/>
					<cfloop array="#newMovies#" item="newMovie">
						<div class="item vhny-grid">
							<div class="box16 mb-0">
								<a href="movieListing.cfm">
									<figure>
										<img class="img-fluid" src="movie/#newMovie.getMovieImg()#" alt="">
									</figure>
									<div class="box-content">
										<h4> <span class="post"><span class="fa fa-clock-o"> </span> #newMovie.getMovieDuration()# Hrs
											</span>
											<span class="post fa fa-heart text-right"></span>
										</h4>
									</div>
									<span class="fa fa-play video-icon" aria-hidden="true"></span>
								</a>
							</div>
							<h3> <a class="title-gd" href="movieListing.cfm">#newMovie.getMovieTitle()# Mins</a></h3>
							<p>#newMovie.getMovieGenre()# Mins</p>
							<div class="button-center text-center mt-4">
								<a href="movieSingle.cfm?id=#newMovie.getMovieID()#" class="btn watch-button">Book now</a>
							</div>
						</div>
					</cfloop>
				</div>
			</div>

		</div>
	</section>
	</cfoutput>
	<div style="margin: 8px auto; display: block; text-align:center;">
	</div>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>