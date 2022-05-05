<cfscript>
    component {
        remote function registerQuery (){
            var name       = form.name;
            var email      = form.email;
            var age        = form.age;
            var gender     = form.gender;
            var password   = form.password;
            var cpassword  = form.cpassword;
            var phone      = form.phone;
            Session.registerArray = ArrayNew(1);
            if(name eq ""){
                ArrayAppend(Session.registerArray, "Please enter the FullName","true"); 
            }
            else if(email eq ""){
                ArrayAppend(Session.registerArray, "Please enter the Email","true"); 
            }
            else if(phone eq ""){
                ArrayAppend(Session.registerArray, "Please enter the phone","true"); 
            }
            else if(age eq ""){
                ArrayAppend(Session.registerArray, "Please enter the Age","true"); 
            }
            else if(gender eq ""){
                ArrayAppend(Session.registerArray, "Please enter the gender","true"); 
            }
            else if(password eq ""){
                ArrayAppend(Session.registerArray, "Please enter the Password","true"); 
            }
            else if(cpassword eq ""){
                ArrayAppend(Session.registerArray, "Please enter the Confirm Password","true"); 
            }
            else if(ArrayIsEmpty(Session.registerArray)){
                var qService= new query();
                qService.setName("qRegisterQry");
                qService.addParam(name="fullName", value="#trim(form.name)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="email", value="#trim(form.email)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="age", value="#trim(form.age)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="userName", value="#trim(form.userName)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="password", value="#hash(trim(form.password))#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="gender", value="#trim(form.gender)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="phone", value="#trim(form.phone)#", cfsqltype="cf_sql_varchar");
                qService.setSql("insert into  usersTable(fullName,email,age,userName,password,gender,phone) 
                values (:fullname, :email, :age, :userName, :password, :gender, :phone)");
                var result=qService.execute();
                var resultKey  = result.getPrefix().generatedkey;
                if(resultKey > 0){
                    ArrayAppend(Session.registerArray, "Successfully Registered","true"); 
                    //location("../login.cfm",false);
                }
                else{
                    ArrayAppend(Session.registerArray, "Something went wrong...","true"); 
                    //location("../registration.cfm",false);
                }
            }
            return Session.registerArray ;
        }
    }
</cfscript>
