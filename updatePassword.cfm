<cfinclude  template = "includes/header.cfm"  runOnce = "true"></cfinclude>
	<!--/breadcrumbs -->
	<div class="w3l-breadcrumbs">
		<nav id="breadcrumbs" class="breadcrumbs">
			<div class="container page-wrapper">
				<a href="index.html">Home</a> » <span class="breadcrumb_last" aria-current="page">Login</span>
			</div>
		</nav>
	</div>
	<!--//breadcrumbs -->
    
<cfoutput>
	<div style="margin: 8px auto; display: block; text-align:center;">
       
    </div>
	<section class="w3l-loginhny py-5">
		<!-- login -->
		<div class="container py-lg-3">
			<div class="w3l-hny-login">
				<div class="w3l-hny-login-info">
                    <cfif StructKeyExists(session, "passwordArray")>
                        <div id="message" class="alert alert-success" role="alert">
                            #session.passwordArray[1]#
                        </div>
                    </cfif>
					<h2>Recover your Account</h2>
                    <form method="post" action="component/moviesDetails.cfc?method=updatePassword">
                        <label>Old Password</label>
						<div class="input-group">
                            <input class="form-control" name="oldPassword" id="oldPassword" type="password" placeholder="Old Password" />
                        </div>
                        <label>New Password</label>
						<div class="input-group">
                            <input class="form-control" name="newPassword" id="newPassword" type="password" placeholder="New Password" />
                        </div>
                        <label>Confirm Password</label>
						<div class="input-group">
                            <input class="form-control" name="confirmPassword" id="confirmPassword" type="password" placeholder="Confrim Password" />    
                        </div>
                        <input class="btn read-button btn-login" type="submit" value="Send Password">
                    </form>
                </div>
			</div>
		</div>
	</section>
	  <!-- //login -->
	<div style="margin: 8px auto; display: block; text-align:center;">
    </div>
</cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>