<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
            <a href="##" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                    class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
        </div>
            <cfif StructKeyExists(session, "messageArray")>
                <div id="message" class="alert alert-success" role="alert">
                    #session.messageArray[1]#
                </div>
            </cfif>
        <!-- Content Row -->
        <div class="row">
            
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 col-lg-3 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <cfset variables.movieObject=CreateObject("component","components.moviesDetails")/>
                                <cfset variables.Movie=movieObject.displayMovieShowing()/>
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Movies (Currently Showing)</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">#Movie.movieCount#</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 col-lg-3 mb-4">
                <div class="card border-left-success shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <cfset variables.bookObject=CreateObject("component","components.moviesDetails")/>
                                <cfset variables.book=bookObject.displaybooksTotal()/>
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                   Toatal Bookings</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">#book.bookCount#</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 col-lg-3 mb-4">
                <div class="card border-left-info shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <cfset variables.theatreObject=CreateObject("component","components.moviesDetails")/>
                                <cfset variables.theatre=theatreObject.displaytheatresTotal()/>
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                   Toatal Theatres</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">#theatre.theatreCount#</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 col-lg-3 mb-4">
                <div class="card border-left-warning shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <cfset variables.userObject=CreateObject("component","components.moviesDetails")/>
                                <cfset variables.user=userObject.displayUsersTotal()/>
                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                    Toatal Users</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">#user.userCount#</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-comments fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content Row -->
    </div>
    <!-- /.container-fluid -->
     </div>
    <!-- End of Main Content -->
    <cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>  
</cfoutput>              