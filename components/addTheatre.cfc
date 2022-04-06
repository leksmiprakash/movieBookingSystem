<cfscript>
    component {
        remote function registerQuery (){
            var tName    = form.tName;
            var tAddress = form.tAddress;
            var tEmail   = form.tEmail;
            var tPhone   = form.tPhone;
            var tPhoto   = form.tPhoto;
            Session.messageArray = ArrayNew(1);
            if(tName eq ""){
                ArrayAppend(Session.messageArray, "Please enter the FullName","true"); 
            }
            else if(tAddress eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Email","true"); 
            }
            else if(tEmail eq ""){
                ArrayAppend(Session.messageArray, "Please enter the UserName","true"); 
            }
            else if(tPhone eq ""){
                ArrayAppend(Session.messageArray, "Please enter the Password","true"); 
            }
            else if(ArrayIsEmpty(Session.messageArray)){
                var qService= new query();
                qService.setDatasource("cfsample");
                qService.setName("qRegisterQry");
                qService.addParam(name="tName", value="#trim(form.tName)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="tAddress", value="#trim(form.tAddress)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="userName", value="#trim(form.userName)#", cfsqltype="cf_sql_varchar");
                qService.addParam(name="password", value="#hash(trim(form.password))#", cfsqltype="cf_sql_varchar");
                qService.setSql("insert into  usersTable(fullName,email,userName,password) 
                values (:fullname, :email, :username, :password)");
                var result=qService.execute();
                var resultKey  = result.getPrefix().generatedkey;
                if(resultKey > 0){
                    ArrayAppend(Session.messageArray, "Successfully Registered","true"); 
                    location("/addressBook/register.cfm",false);
                }
                else{
                    ArrayAppend(Session.messageArray, "Something went wrong...","true"); 
                    location("/addressBook/register.cfm",false);
                }
            }
            return Session.messageArray ;
        }
    }
</cfscript>
