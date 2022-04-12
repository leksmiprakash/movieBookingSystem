<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Theatre</h1>
            <a class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" href="##" data-toggle="modal" data-target="##screenModal">
                <i class="fas fa-plus fa-sm text-white-50"></i> Add Theatre </a>
        </div>
        
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Theatre List </h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <cfset ScreensObj=CreateObject("component","components.theatresDetails")/>
                    <cfset alldata=ScreensObj.displayallScreendata()/>
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Theatre Name</th>
                                <th>Screen Name</th>
                                <th>Seates</th>
                                <th>Charge</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Theatre Name</th>
                                <th>Screen Name</th>
                                <th>Seates</th>
                                <th>Charge</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <cfloop array="#alldata#" item="alldatas">
                                <tr>
                                
                                    <td>#alldatas.getTheatre_id()#</td>
                                    <td>#alldatas.getScreen_name()#</td>
                                    <td>#alldatas.getSeats()#</td>
                                    <td>#alldatas.getCharge()#</td>
                                    <td><a class="btn btn btn-outline-primary btn-sm button-18 editbtn" data-conid="#alldatas.getScreen_id()#" id="editbtn"  data-toggle="modal" data-target="##screenModal">
                                            Edit
                                        </a></td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
    <!-- theatreModal Modal-->
    <div class="modal fade" id="screenModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" action="components/theatresDetails.cfc?method=screenData" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Theatre Name</label>
                            <input class="form-control input-sm" id="tName" name="tName" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Screen Name</label>
                            <input class="form-control" id="sName" name="sName" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Seates</label>
                            <input class="form-control" id="seats" name="seats" type="text" />
                        </div>
                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                            <label for="inputEmail">Charge</label>
                            <input class="form-control" id="charge" name="charge" type="text" />
                            <input class="form-control" id="updateId" name="updateId" type="hidden" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-primary" name ="saveScreen" value="Save Screen">
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
    var screenId = $(this).data('conid');
     $.ajax({
        type: "post",
        url: 'components/theatresDetails.cfc?method=displayScreendata',
        data: {
            editid: screenId
        },
        
        success: function(response) {
            p = JSON.parse(response);
            console.log(p);
            $("#updateId").val(p.DATA[0][0]);
            $("#tName").val(p.DATA[0][1]);
            $("#sName").val(p.DATA[0][2]);
            $("#seats").val(p.DATA[0][3]);
            $("#charge").val(p.DATA[0][4]);
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
