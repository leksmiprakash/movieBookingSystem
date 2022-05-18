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
					<h2>Recover your Account</h2>
					<form method="post" action="component/moviesDetails.cfc?method=forgotPassword" >
						<label>Email</label>
						<div class="input-group">
							<input type="email" name="email" placeholder="Email"  autofocus>
						</div>
						<input class="btn read-button btn-login" type="submit" value="Send Password">
					</form>
					<p class="account1">Already have an account? <a href="login.cfm">Login now</a></p>
				</div>
			</div>
		</div>
	</section>
	  <!-- //login -->
	  <div style="margin: 8px auto; display: block; text-align:center;">

 
</div>
 </cfoutput>
<cfinclude  template = "includes/footer.cfm"  runOnce = "true"></cfinclude>