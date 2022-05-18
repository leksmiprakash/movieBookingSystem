<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Show</h1>
            <a class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" href="##" data-toggle="modal" data-target="##showModal">
                <i class="fas fa-plus fa-sm text-white-50"></i> Add Show </a>
        </div>
        <cfif StructKeyExists(session, "showsArray")>
            <div id="message" class="alert alert-success" role="alert">
                #session.showsArray[1]#
            </div>
        </cfif>
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Show List </h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <cfset ShowObj=CreateObject("component","components.theatresDetails")/>
                    <cfset alldata=ShowObj.displayallShowdata()/>
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Movie Name</th>
                                <th>Theatre Name</th>
                                <th>Show Name</th>
                                <th>Show Times</th>
                                <th>Show Starting Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Movie Name</th>
                                <th>Theatre Name</th>
                                <th>Show Name</th>
                                <th>Show Times</th>
                                <th>Show Starting Date</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <cfloop QUERY="#alldata#">
                                <tr>
                                
                                    <td>#alldata.movieTitle#</td>
                                    <td>#alldata.t_name#</td>
                                    <td>#alldata.showName#</td>
                                    <td>#TimeFormat(alldata.start_time)#</td>
                                    <td>#DateFormat(alldata.start_date)#</td>
                                    <td> 
                                        <cfif alldata.status==1 >
                                            <a href="##" class="btn btn btn-outline-primary btn-sm button-18 show" data-id="2" id="#alldata.s_id#">
                                                Stop Showing
                                            </a>
                                        <cfelse>
                                            <a href="##" class="btn btn btn-outline-danger btn-sm button-18 show" data-id="1" id="#alldata.s_id#">
                                                Start Showing
                                            </a>
                                        </cfif>
                                        </a>
                                    </td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- showTimeModal Modal-->
    <div class="modal fade" id="showModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" action="components/theatresDetails.cfc?method=showsAddData" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Name</label>
                            <cfset MoviesObj=CreateObject("component","components.moviesDetails")/>
                            <cfset movies=MoviesObj.displayalldata()/>
                            <select name="movieId" class="form-control" id="movieId" >
                                <option value="">Select</option>
                                <cfloop array="#movies#" item="movie">
                                    <option value="#movie.getMovieID()#">#movie.getMovieTitle()#</option>
                                </cfloop>
                            </select>
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Theatre Name</label>
                            <cfset TheatresObj=CreateObject("component","components.theatresDetails")/>
                            <cfset theatres=TheatresObj.displayalldata()/>
                            <select name="tId" class="form-control" id="tId" >
                                <option value="">Select</option>
                                <cfloop array="#theatres#" item="theatre">
                                    <option value="#theatre.getT_id()#">#theatre.getT_name()#</option>
                                </cfloop>
                            </select>
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Show Time</label>
                            <select name="stData" class="form-control" id="stData" >
                                <option value="">Select</option>
                                
                            </select>
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Show Time</label>
                            <input type="date" name="showDate" id="showDate" class="form-control" >
                        </div>
                    </div>
                    <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                        <label for="inputEmail">Show Time</label>
                        <select name="status" class="form-control" id="status" >
                            <option value="">Select</option>
                            <option value="1">Show Active</option>
                            <option value="2">Show Stops</option>
                            
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-primary" name ="saveTheatre" value="Save Show">
                    </div>
                </form>
            </div>
        </div>
    </div>
    </div>
    <!-- /.container-fluid -->
    

</cfoutput>
<cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>                
<script>
$(document).on('change', '#tId', function() {
    var theatreId = $( "#tId" ).val();
   // alert(theatreId);
     $.ajax({
        type: "post",
        url: 'components/theatresDetails.cfc?method=showTimeTheatre',
        data: {
            editid: theatreId
        },
        
        success: function(response) {
            var formoption = "";
            data = JSON.parse(response);
            console.log(data.DATA);
                var result = data.DATA;
                for (var i = 0; i < result.length; i++) {
                    var content = result[i].slice(',');
                    var id = content[0];
                    //alert()
                    var val = content[1];
                    $("#stData").append("<option value='"+id+"'>"+val+"</option>");
                }
               // formoption += "<option value='" + data[v] + "'>" + data[v]+ "</option>";
           
            // $('#stData').html(formoption);

            //$("#stData").html("<option value='"+ p.st_id +"'>" + p.showName + "</option>"); 
        }
    });
});
$(".show").click(function(){
    var showId =  $(this).attr('id');
    var status =  $(this).attr('data-id');
    if(confirm('Are you sure to update this show status ?')) {
        $.ajax({
            type:'POST',
            url:'components/theatresDetails.cfc?method=stopShow',
            data:{
                showId:showId,status:status
                },
            success: function(response){
                data = JSON.parse(response);
                //alert(data);
                if(data==true){
                    alert("Show status updated Successfully");
                    window.location.reload();  
                }else{
                    alert("Something Went Wrong");
                }
            }
        })
    }
});
</script>
