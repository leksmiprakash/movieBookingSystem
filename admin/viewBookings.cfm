<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Theatre List </h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <cfset ShowObj=CreateObject("component","components.moviesDetails")/>
                    <cfset alldata=ShowObj.displayBookingData()/>
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Movie Name</th>
                                <th>Theatre Name</th>
                                <th>Show Name</th>
                                <th>Show Times</th>
                                <th>Total Tickets</th>
                                <th>Show Amount</th>
                                <th>Show Date</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Movie Name</th>
                                <th>Theatre Name</th>
                                <th>Show Name</th>
                                <th>Show Times</th>
                                <th>Total Tickets</th>
                                <th>Show Amount</th>
                                <th>Show Date</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <cfloop QUERY="#alldata#">
                                <tr>
                                
                                    <td>#alldata.movieTitle#</td>
                                    <td>#alldata.t_name#</td>
                                    <td>#alldata.showName#</td>
                                    <td>#TimeFormat(alldata.start_time)#</td>
                                    <td>#alldata.seat_count#</td>
                                    <td>#alldata.amount#</td>
                                    <td>#DateFormat(alldata.ticket_date)#</td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
       
    </div>
    <!-- /.container-fluid -->
    

</cfoutput>
<cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>   