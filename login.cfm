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
	<div style="margin: 8px auto; display: block; text-align:center;">

<!---728x90--->

 <cfoutput>
</div>
	<section class="w3l-loginhny py-5">
		<!-- login -->
		<div class="container py-lg-3">
		  <div class="w3l-hny-login">
			<div class="w3l-hny-login-info">
			<cfif StructKeyExists(session, "loginArray")>
				<div id="message" class="alert alert-success" role="alert">
					#session.loginArray[1]#
				</div>
			</cfif>
			  <h2>Login to your Account</h2>
			  <form action="component/login.cfc?method=getUserDetails" method="post" name="signup" id="signup" onsubmit="return Validation()">
				<label>Email</label>
				<div class="input-group">
				  <input type="email" name="email" id="email" placeholder="" autofocus style="color:green;">
				</div>
				<label>Password</label>
				<div class="input-group">
				  <input type="Password" name="password" id="password" placeholder="" style="color:green;">
				</div>
				<div class="login-check">
				  <label class="checkbox"><input type="checkbox" name="checkbox" /> Remember me</label>
				  <!--<a class="forgot" href="forgotPassword.cfm">Forgot password?</a>-->
				</div>
				<button class="btn read-button btn-login" type="submit">Login</button>
			  </form>
			  <p class="account1">Dont have an account yet? <a href="registration.cfm">Get it now</a></p>
			</div>
		  </div>
		</div>
	  </section>
	  <!-- //login -->
	  <div style="margin: 8px auto; display: block; text-align:center;">

<!---728x90--->
 
</div>
 </cfoutput>
	<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>