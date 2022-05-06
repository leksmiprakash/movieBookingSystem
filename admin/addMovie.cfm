<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Movie</h1>
            <a class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" href="##" data-toggle="modal" data-target="##movieModal">
                <i class="fas fa-plus fa-sm text-white-50"></i> Add Movie </a>
        </div>
        <cfif StructKeyExists(session, "movieArray")>
            <div id="message" class="alert alert-success" role="alert">
                #session.movieArray[1]#
            </div>
        </cfif>
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Movie List </h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <cfset MoviesObj=CreateObject("component","components.moviesDetails")/>
                    <cfset alldata=MoviesObj.displayalldata()/>
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Movie Name</th>
                                <th>Movie Genre</th>
                                <th>Movie Duration</th>
                                <th>Movie Release Date</th>
                                <th>Movie Director</th>
                                <th>Movie Actors</th>
                                <th>Movie Trailer</th>
                                <th>Poster</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Movie Name</th>
                                <th>Movie Genre</th>
                                <th>Movie Duration</th>
                                <th>Movie Release Date</th>
                                <th>Movie Director</th>
                                <th>Movie Actors</th>
                                <th>Movie Trailer</th>
                                <th>Poster</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <cfloop array="#alldata#" item="alldatas">
                                <tr>
                                
                                    <td>#alldatas.getMovieTitle()#</td>
                                    <td>#alldatas.getMovieGenre()#</td>
                                    <td>#alldatas.getMovieDuration()#</td>
                                    <td>#alldatas.getMovieRelDate()#</td>
                                    <td>#alldatas.getMovieDirector()#</td>
                                    <td>#alldatas.getMovieActors()#</td>
                                    <td> 
                                        <iframe width="180" height="110" src="#alldatas.getMovieTrailer()#" allow="autoplay; fullscreen" 
                                        frameborder="0" allowfullscreen>
                                        </iframe>
                                    </td>
                                    <td><img src="../movie/#alldatas.getMovieImg()#" width="80px" height="80px"></td>
                                    <td> <a class="btn btn btn-outline-primary btn-sm button-18 editbtn" data-conid="#alldatas.getMovieID()#" id="editbtn"  data-toggle="modal" data-target="##movieModal">
                                            Edit
                                        </a>
                                        <a href="##" class="btn btn btn-outline-primary btn-sm button-18 trash" id="#alldatas.getMovieID()#" >Delete</a>
                                    </td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
    <!-- movieModal Modal-->
    <div class="modal fade" id="movieModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" action="components/moviesDetails.cfc?method=movieData" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Name</label>
                            <input class="form-control input-sm" id="movieTitle" name="movieTitle" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Genre</label>
                            <input class="form-control" id="movieGenre" name="movieGenre" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Duration</label>
                            <input class="form-control" id="movieDuration" name="movieDuration" type="text" placeholder="hrs.mins" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Release Date</label>
                            <input class="form-control" id="movieRelDate" name="movieRelDate" type="date" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Director</label>
                            <input class="form-control" id="movieDirector" name="movieDirector" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Actors</label>
                            <input class="form-control" id="movieActors" name="movieActors" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Photo</label>
                            <input class="form-control" id="movieImg" name="movieImg" type="file" />
                            <input type="hidden" name="old_file" id="old_file" value="" />
                            <input class="form-control" id="updateId" name="updateId" type="hidden" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Trailer</label>
                            <input class="form-control" id="movieTrailer" name="movieTrailer" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Movie Description</label>
                            <input class="form-control" id="movieDesc" name="movieDesc" type="text" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-primary" name ="saveMovie" value="Save Movie">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End of Main Content -->

</cfoutput>
<cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>                
<script>
$(document).on('click', '.editbtn', function() {
    var movieId = $(this).data('conid');
     $.ajax({
        type: "post",
        url: 'components/moviesDetails.cfc?method=displaydata',
        data: {
            editid: movieId
        },
        
        success: function(response) {
            p = JSON.parse(response);
            console.log(p);
            $("#updateId").val(p.DATA[0][0]);
            $("#movieTitle").val(p.DATA[0][2]);
            $("#movieGenre").val(p.DATA[0][3]);
            $("#movieDuration").val(p.DATA[0][4]);
            
            let dateStr = new Date(p.DATA[0][5]);
            var now = new Date(p.DATA[0][5]);
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var today = now.getFullYear() + "-" + (month) + "-" + (day);
            $("#movieRelDate").val(today);
            $("#movieDirector").val(p.DATA[0][6]);
            $("#movieActors").val(p.DATA[0][7]);
            $("#old_file").val(p.DATA[0][1]);
            $("#movieDesc").val(p.DATA[0][8]);
            $("#movieTrailer").val(p.DATA[0][9]);
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
$(".trash").click(function(){
    var deleteId =  $(this).attr('id');
    if(confirm('Are you sure to remove this record ?')) {
        $.ajax({
            type:'POST',
            url:'components/moviesDetails.cfc?method=deleteMovie',
            data:{deleteId:deleteId},
            success: function(response){
                data = JSON.parse(response);
                //alert(data);
                if(data==true){
                    alert("Deleted Successfully");
                    window.location.reload();     
                }else{
                    alert("Something Went Wrong");
                }
            }
        })
    }
});
</script>
