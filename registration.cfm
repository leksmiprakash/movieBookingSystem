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
			
           <cfif StructKeyExists(session, "registerArray") >
                <div id="message" class="alert alert-success" role="alert">
                    #session.registerArray[1]#
                </div>
            </cfif>
			  <h2>Register to your Account</h2>
			  <form action="component/registaration.cfc?method=registerQuery" method="post" name="signup" id="signup" onsubmit="return ValidationSignup()">
                <label>Name</label>
				<div class="input-group">
				    <input type="text" name="name" id="name" placeholder="" autofocus>
				</div>
                <label>Age</label>
				<div class="input-group">
				    <input type="text" name="age" id="age" placeholder="">
				</div>
                <label>Gender</label>
				<div class="input-group">
                    <select class="form-control" name="gender" id="gender" autofocus>
                        <option value="">------Select Gender------</option>
                        <option value="1">Male</option>
                        <option value="2">Female</option>
                    </select>
				</div>
                <label>Mobile Number</label>
				<div class="input-group">
				    <input type="text" name="phone" id="phone" placeholder="">
				</div>
				<label>Email</label>
				<div class="input-group">
				    <input type="email" name="email" id="email" placeholder=""  onchange="checkAvailability()">
					<span id="user-availability-status"></span> 
				</div>
				<label>Username</label>
				<div class="input-group">
				    <input type="text" name="userName" id="userName" placeholder="">
				</div>
				<label>Password</label>
				<div class="input-group">
				    <input type="Password" name="password" id="password" placeholder="">
				</div>
                <label>Confirm Password</label>
				<div class="input-group">
				    <input type="Password" name="cpassword" id="cpassword" placeholder="">
				</div>
				
				<input class="btn read-button btn-login" type="submit" value="Register">
			  </form>
			  <p class="account1">Already have an account? <a href="login.cfm">Login now</a></p>
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