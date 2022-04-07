<cfscript>
    component {
        public function getUserDetails (){
            var userNames   = form.userName;
            var passwords   = form.password;
            writeOutput(userName);
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
                qService.setSql("
                SELECT user_id,userName
                FROM usersTable
                WHERE userName = :userName and password = :password
                ");
                results = qService.execute().getResult();
                if (results.recordCount eq 1){
                    Session.userID = results.user_id;
                    Session.userName = results.userName;
                    Session.loggedin = true; 
                    location("/onlineMovieBookingSystem/admin/dashboard.cfm","no");
                    ArrayAppend(Session.messageArray, "Logged In Successfully","true"); 
                } 
                else {
                    location("/onlineMovieBookingSystem/admin/index.cfm","no");
                    ArrayAppend(Session.messageArray, "LogIn Error","true"); 
                } 
            }
            return Session.messageArray ;
        }
    }
</cfscript>