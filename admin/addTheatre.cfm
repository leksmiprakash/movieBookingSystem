<cfoutput>
    <cfinclude  template = "include/header.cfm"  runOnce = "true"></cfinclude>
          <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-6 col-lg-9">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        Add Theatre
                                    </div>
                                    <form method="post" action="components/auth.cfc?method=getUserDetails">
                                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                                            <label for="inputEmail">Theatre Name</label>
                                            <input class="form-control input-sm" id="tName" name="userName" type="text" />
                                        </div>
                                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                                            <label for="inputEmail">Theatre Address</label>
                                            <input class="form-control" id="inputEmail" name="tAddress" type="text" />
                                        </div>
                                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                                            <label for="inputEmail">Theatre Email</label>
                                            <input class="form-control" id="inputEmail" name="tEmail" type="text" />
                                        </div>
                                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                                            <label for="inputEmail">Theatre Phone No</label>
                                            <input class="form-control" id="inputEmail" name="tPhone" type="text" />
                                        </div>
                                        <div class="form-group mb-3 col-lg-9"  style="margin: 0 auto;">
                                            <label for="inputEmail">Theatre Photo</label>
                                            <input class="form-control" id="inputEmail" name="tPhoto" type="file" />
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                            <input class="btn btn-primary" type="submit" value="Log In">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
    <cfinclude  template = "include/footer.cfm"  runOnce = "true"></cfinclude>  
</cfoutput>              