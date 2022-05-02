<cfscript>
    component {
        remote function getUserDetails (){
            var userNames   = form.userName;
            var passwords   = form.password;
            var adminRole   = "1";
            //writeOutput(userName);
            Session.messageArray = ArrayNew(1);
            if(userNames eq ""){
                ArrayAppend(Session.messageArray, "Please enter the UserName","true"); 
            }
            else if(passwords eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Password","true"); 
            }
            else if(ArrayIsEmpty(Session.messageArray)){
                qService = new query(); 
                qService.setName("qGet"); 
                qService.addParam(name="userName", value="#trim(form.userName)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="password", value="#hash(trim(form.password))#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="role", value="#adminRole#", cfsqltype="cf_sql_varchar");
                qService.setSql("
                SELECT user_id,userName
                FROM usersTable
                WHERE userName = :userName and password = :password and role = :role
                ");
                results = qService.execute().getResult();
                if (results.recordCount eq 1){
                    Session.adminID = results.user_id;
                    Session.adminUserName = results.userName;
                    Session.loggedinAdmin = true; 
                    ArrayAppend(Session.messageArray, "Logged In Successfully","true"); 
                    location("../dashboard.cfm","no");
                } 
                else {
                    
                    ArrayAppend(Session.messageArray, "LogIn Error","true"); 
                    location("../login.cfm","no");
                } 
            }
            return Session.messageArray ;
        }
    }
</cfscript>