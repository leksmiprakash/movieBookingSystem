<cfscript>
    component {
        remote function getUserDetails (){
            var emails   = form.email;
            var passwords   = form.password;
            var userRole   = "2";
            //writeOutput(userName);
            Session.messageArray = ArrayNew(1);
            if(emails eq ""){
                ArrayAppend(Session.messageArray, "Please enter the UserName","true"); 
            }
            else if(passwords eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Password","true"); 
            }
            else if(ArrayIsEmpty(Session.messageArray)){
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
                    location("../index.cfm","no");
                    ArrayAppend(Session.messageArray, "Logged In Successfully","true"); 
                } 
                else {
                    location("../login.cfm","no");
                    ArrayAppend(Session.messageArray, "LogIn Error","true"); 
                } 
            }
            return Session.messageArray ;
        }
    }
</cfscript>