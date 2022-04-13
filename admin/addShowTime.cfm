<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Theatre</h1>
            <a class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" href="##" data-toggle="modal" data-target="##showTimeModal">
                <i class="fas fa-plus fa-sm text-white-50"></i> Add Theatre </a>
        </div>
        
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Theatre List </h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <cfset ShowTimesObj=CreateObject("component","components.theatresDetails")/>
                    <cfset alldata=ShowTimesObj.displayallShowTimedata()/>
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Theatre Name</th>
                                <th>Screen Name</th>
                                <th>Show</th>
                                <th>Show Starting Time</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Theatre Name</th>
                                <th>Screen Name</th>
                                <th>Show</th>
                                <th>Show Starting Time</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <cfloop array="#alldata#" item="alldatas">
                                <tr>
                                
                                    <td>#alldatas.getTheatre_id()#</td>
                                    <td>#alldatas.getScreen_id()#</td>
                                    <td>#alldatas.getshowName()#</td>
                                    <td>#alldatas.getStart_time()#</td>
                                    
                                    <td> <a class="btn btn btn-outline-primary btn-sm button-18 editbtn" data-conid="#alldatas.getSt_id()#" id="editbtn"  data-toggle="modal" data-target="##showTimeModal">
                                            Edit
                                        </a>
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
    <!-- showTimeModal Modal-->
    <div class="modal fade" id="showTimeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" action="components/theatresDetails.cfc?method=theatreData" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
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
                            <label for="inputEmail">Screen Name</label>
                            <cfset ScreensObj=CreateObject("component","components.theatresDetails")/>
                            <cfset screens=ScreensObj.displayallScreendata()/>
                            <select name="screenId" class="form-control" id="screenId" >
                                <option value="">Select</option>
                                <cfloop array="#screens#" item="screen">
                                    <option value="#screen.getScreen_id()#">#screen.getScreen_name()#</option>
                                </cfloop>
                            </select>
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Screen Name</label>
                            <cfset ShowNamesObj=CreateObject("component","components.theatresDetails")/>
                            <cfset showNames=ShowNamesObj.displayallShowNamedata()/>
                            <select name="showNameId" class="form-control" id="showNameId" >
                                <option value="">Select</option>
                                <cfloop array="#showNames#" item="showName">
                                    <option value="#showName.getShowName()#">#showName.getShowName()#</option>
                                </cfloop>
                            </select>
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Show Time</label>
                            <input type="time" id="sTime" name="sTime" class="form-control"/>
                            <input class="form-control" id="updateId" name="updateId" type="hidden" />
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
<!-- End of Main Content -->

</cfoutput>
<cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>                
<script>
$(document).on('click', '.editbtn', function() {
    var theatreId = $(this).data('conid');
     $.ajax({
        type: "post",
        url: 'components/theatresDetails.cfc?method=displayShowTimedata',
        data: {
            editid: theatreId
        },
        
        success: function(response) {
            p = JSON.parse(response);
            console.log(p);
            $("#updateId").val(p.DATA[0][0]);
            $("#tId").val(p.DATA[0][1]).change();
            $("#screenId").val(p.DATA[0][2]).change();
            $("#showNameId").val(p.DATA[0][3]).change();
            $("#sTime").val(p.DATA[0][4]);
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
