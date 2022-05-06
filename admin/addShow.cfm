<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Theatre</h1>
            <a class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" href="##" data-toggle="modal" data-target="##showModal">
                <i class="fas fa-plus fa-sm text-white-50"></i> Add Theatre </a>
        </div>
        
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Theatre List </h6>
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
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Movie Name</th>
                                <th>Theatre Name</th>
                                <th>Show Name</th>
                                <th>Show Times</th>
                                <th>Show Starting Date</th>
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
                <form method="post" action="components/theatresDetails.cfc?method=showTimeData" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
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
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-primary" name ="saveTheatre" value="Save Theatre">
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
function changeImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imageDisplay').attr('src', e.target.result).width(250).height(250);
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
