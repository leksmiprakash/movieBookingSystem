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
                    <cfset ShowObj=CreateObject("component","components.theatresDetails")/>
                    <cfset alldata=ShowObj.displayallShowdata()/>
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Movie Name</th>
                                <th>Screen Name</th>
                                <th>Show Times</th>
                                <th>Show Starting Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Movie Name</th>
                                <th>Screen Name</th>
                                <th>Show Times</th>
                                <th>Show Starting Date</th>
                                
                            </tr>
                        </tfoot>
                        <tbody>
                            <cfloop array="#alldata#" item="alldatas">
                                <tr>
                                
                                    <td>#alldatas.getMovie_id()#</td>
                                    <td>#alldatas.getTheatre_id()#</td>
                                    <td>#alldatas.getSt_id()#</td>
                                    <td>#alldatas.getStart_date()#</td>
                                    
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
<script>
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
