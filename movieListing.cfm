<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
<cfoutput>
	<!--/breadcrumbs -->
	<div class="w3l-breadcrumbs">
		<nav id="breadcrumbs" class="breadcrumbs">
			<div class="container page-wrapper">
				<a href="index.html">Home</a> » <span class="breadcrumb_last" aria-current="page">Genre</span>
			</div>
		</nav>
	</div>
	<!--//breadcrumbs -->
	<!--/genre -->
	
	<!--grids-sec1-->
	<section class="w3l-grids">
		<div class="grids-main py-5">
			<div class="container py-lg-4">
				<div class="headerhny-title">
					<div class="w3l-title-grids">
						<div class="headerhny-left">
							<h3 class="hny-title">Latest Movies</h3>
						</div>
					</div>
				</div>
                <cfset MoviesObj=CreateObject("component","component.moviesDetails")/>
                <cfset Movies=MoviesObj.displayNewData()/>
                
                <div class="w3l-populohny-grids">
                    <cfloop array="#Movies#" item="Movie">					
                        <div class="item vhny-grid">
                            <div class="box16 mb-0">
                                <a href="movieSingle.cfm">
                                    <figure>
                                        <img class="img-fluid" src="movie/#Movie.getMovieImg()#" alt="">
                                    </figure>
                                    <div class="box-content">
                                        <h3 class="title">#Movie.getMovieTitle()#</h3>
                                        <h4> <span class="post"><span class="fa fa-clock-o"> </span> #Movie.getMovieDuration()# Hrs

                                            </span>

                                            <span class="post fa fa-heart text-right"></span>
                                        </h4>
                                    </div>
                                    
                                </a>
                            </div>
							<div class="button-center text-center mt-4">
								<a href="movieSingle.cfm?id=#Movie.getMovieID()#" class="btn watch-button">Book now</a>
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
		<div class="grids-main py-4">
			<div class="container py-lg-4">
				<div class="headerhny-title">
					<h3 class="hny-title">Must to watch</h3>
				</div>
				<div class="owl-two owl-carousel owl-theme">
					<div class="item">
						<div class="two-gridshny-grids">
							<div class="two-gridshny-left">
								<div class="box16 mb-4">
									<a href="genre-single.html">
										<figure>
											<img class="img-fluid" src="assets/images/1.jpg" alt="">
										</figure>
										<div class="box-content">
											<h4> <span class="post"><span class="fa fa-clock-o"> </span> 2 Hr 4min

												</span>

												<span class="post fa fa-heart text-right"></span>
											</h4>
										</div>
										<span class="fa fa-play video-icon" aria-hidden="true"></span>
									</a>
								</div>
							</div>
							<div class="two-gridshny-right">
								<h3> <a class="title-gd mt-0" href="genre-single.html">That’s what I want to show you
										how to do here.</a></h3>

							</div>
						</div>
					</div>
					<div class="item vhny-grid">
						<div class="two-gridshny-grids">
							<div class="two-gridshny-left">
								<div class="box16 mb-4">
									<a href="genre-single.html">
										<figure>
											<img class="img-fluid" src="assets/images/2.jpg" alt="">
										</figure>
										<div class="box-content">
											<h4> <span class="post"><span class="fa fa-clock-o"> </span> 2 Hr 4min

												</span>

												<span class="post fa fa-heart text-right"></span>
											</h4>
										</div>
										<span class="fa fa-play video-icon" aria-hidden="true"></span>
									</a>
								</div>
							</div>
							<div class="two-gridshny-right">
								<h3> <a class="title-gd mt-0" href="genre-single.html">That’s what I want to show you
										how to do here.</a></h3>

							</div>
						</div>
					</div>
					<div class="item vhny-grid">
						<div class="two-gridshny-grids">
							<div class="two-gridshny-left">
								<div class="box16 mb-4">
									<a href="genre-single.html">
										<figure>
											<img class="img-fluid" src="assets/images/3.jpg" alt="">
										</figure>
										<div class="box-content">
											<h4> <span class="post"><span class="fa fa-clock-o"> </span> 2 Hr 4min

												</span>

												<span class="post fa fa-heart text-right"></span>
											</h4>
										</div>
										<span class="fa fa-play video-icon" aria-hidden="true"></span>
									</a>
								</div>
							</div>
							<div class="two-gridshny-right">
								<h3> <a class="title-gd mt-0" href="genre-single.html">That’s what I want to show you
										how to do here.</a></h3>

							</div>
						</div>
					</div>
					<div class="item vhny-grid">
						<div class="two-gridshny-grids">
							<div class="two-gridshny-left">
								<div class="box16 mb-4">
									<a href="genre-single.html">
										<figure>
											<img class="img-fluid" src="assets/images/4.jpg" alt="">
										</figure>
										<div class="box-content">
											<h4> <span class="post"><span class="fa fa-clock-o"> </span> 2 Hr 4min

												</span>

												<span class="post fa fa-heart text-right"></span>
											</h4>
										</div>
										<span class="fa fa-play video-icon" aria-hidden="true"></span>
									</a>
								</div>
							</div>
							<div class="two-gridshny-right">
								<h3> <a class="title-gd mt-0" href="genre-single.html">That’s what I want to show you
										how to do here.</a></h3>

							</div>
						</div>
					</div>
					<div class="item vhny-grid">
						<div class="two-gridshny-grids">
							<div class="two-gridshny-left">
								<div class="box16 mb-4">
									<a href="genre-single.html">
										<figure>
											<img class="img-fluid" src="assets/images/5.jpg" alt="">
										</figure>
										<div class="box-content">
											<h4> <span class="post"><span class="fa fa-clock-o"> </span> 2 Hr 4min

												</span>

												<span class="post fa fa-heart text-right"></span>
											</h4>
										</div>
										<span class="fa fa-play video-icon" aria-hidden="true"></span>
									</a>
								</div>
							</div>
							<div class="two-gridshny-right">
								<h3> <a class="title-gd mt-0" href="genre-single.html">That’s what I want to show you
										how to do here.</a></h3>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--grids-sec2-->
	<!--//genre -->
	<div style="margin: 8px auto; display: block; text-align:center;">

<!---728x90--->
 
</div>
</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>