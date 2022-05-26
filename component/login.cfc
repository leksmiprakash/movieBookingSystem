<cfscript>
    component {
        remote function getUserDetails (){
            var emails   = form.email;
            var passwords   = form.password;
            var userRole   = "2";
            //writeOutput(userName);
            Session.loginArray = ArrayNew(1);
            if(emails eq ""){
                ArrayAppend(Session.loginArray, "Please enter the UserName","true"); 
            }
            else if(passwords eq ""){
                ArrayAppend(Session.loginArray, "Please enter the Password","true"); 
            }
            else if(ArrayIsEmpty(Session.loginArray)){
                qService = new query(); 
                qService.setName("qGet"); 
                qService.addParam(name="email", value="#trim(form.email)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="password", value="#hash(trim(form.password))#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="role", value="#userRole#", cfsqltype="cf_sql_varchar");
                qService.setSql("
                SELECT user_id,userName
                FROM usersTable
                WHERE email = :email and password = :password and role = :role
                ");
                results = qService.execute().getResult();
                if (results.recordCount eq 1){
                    Session.userID = results.user_id;
                    Session.userName = results.userName;
                    Session.loggedin = true; 
                    ArrayAppend(Session.loginArray, "Logged In Successfully","true"); 
                    location("../index.cfm","no");
                } 
                else {
                    ArrayAppend(Session.loginArray, "Incorrect Credentials","true"); 
                    location("../login.cfm","no");
                } 
            }
            return Session.loginArray ;
        }
    }
</cfscript>