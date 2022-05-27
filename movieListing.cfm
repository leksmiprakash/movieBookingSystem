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
                <cfset variables.EncrptKey = "abc!@" />
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
								<a href="movieSingle.cfm?id=#URLEncodedFormat(Encrypt(Movie.getMovieID(), EncrptKey))#" class="btn watch-button">Book now</a>
							</div>
                        </div>
                    </cfloop>
                </div>
			</div>
		</div>
	</section>
	<!--//grids-sec1-->


	<!--//genre -->
	<div style="margin: 8px auto; display: block; text-align:center;">

<!---728x90--->
 
</div>
</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>