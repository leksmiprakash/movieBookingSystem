<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Profile</h1>
            
        </div>
        <cfif StructKeyExists(session, "passwordArray")>
            <div id="message" class="alert alert-success" role="alert">
                #session.passwordArray[1]#
            </div>
        </cfif>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow-lg border-0 rounded-lg mt-5">
                        <div class="card-header"><h3 class="text-center font-weight-light my-4">Update Password</h3></div>
                        <div class="card-body">
                            <form method="post" action="components/theatresDetails.cfc?method=updatePassword">
                                <div class="form-floating mb-3">
                                    <input class="form-control" name="oldPassword" id="oldPassword" type="password" placeholder="Old Password" />
                                </div>
                                <div class="form-floating mb-3">
                                    <input class="form-control" name="newPassword" id="newPassword" type="password" placeholder="New Password" />
                                </div>
                                <div class="form-floating mb-3">
                                    <input class="form-control" name="confirmPassword" id="confirmPassword" type="password" placeholder="Confrim Password" />    
                                </div>
                                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <input type="hidden" name="adminId" id="adminId" value="#session.adminID#" />    
                                    <button class="btn btn-primary" type="submit">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
    
</div>
<!-- End of Main Content -->

</cfoutput>
<cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>                
