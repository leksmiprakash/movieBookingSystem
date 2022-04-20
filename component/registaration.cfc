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
            Session.messageArray = ArrayNew(1);
            if(name eq ""){
                ArrayAppend(Session.messageArray, "Please enter the FullName","true"); 
            }
            else if(email eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Email","true"); 
            }
            else if(phone eq ""){
                ArrayAppend(Session.messageArray, "Please enter the phone","true"); 
            }
            else if(age eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Age","true"); 
            }
            else if(gender eq ""){
                ArrayAppend(Session.messageArray, "Please enter the gender","true"); 
            }
            else if(password eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Password","true"); 
            }
            else if(cpassword eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Confirm Password","true"); 
            }
            else if(ArrayIsEmpty(Session.messageArray)){
                var qService= new query();
                qService.setName("qRegisterQry");
                qService.addParam(name="fullName", value="#trim(form.name)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="email", value="#trim(form.email)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="age", value="#trim(form.age)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="password", value="#hash(trim(form.password))#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="gender", value="#trim(form.gender)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="phone", value="#trim(form.phone)#", cfsqltype="cf_sql_varchar");
                qService.setSql("insert into  usersTable(fullName,email,age,password,gender,phoneNo) 
                values (:fullname, :email, :age, :password, :gender, :phone)");
                var result=qService.execute();
                var resultKey  = result.getPrefix().generatedkey;
                if(resultKey > 0){
                    ArrayAppend(Session.messageArray, "Successfully Registered","true"); 
                    location("/addressBook/register.cfm",false);
                }
                else{
                    ArrayAppend(Session.messageArray, "Something went wrong...","true"); 
                    location("/movieBookingSystem/registration.cfm",false);
                }
            }
            return Session.messageArray ;
        }
    }
</cfscript>
