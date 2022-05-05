component{
    
    This.name = "TestApplication";
    This.clientmanagement="True";
    This.loginstorage="Session";
    This.sessionmanagement="True";
    This.datasource="movieBooking";
    This.sessiontimeout=createtimespan(0,0,10,0);
    This.applicationtimeout=createtimespan(5,0,0,0);
    This.ormenabled = "true";
    This.ormsettings = {datasource="movieBooking", logsql="true"};
   
    function onRequestStart(requestname){ 
        if(!structKeyExists(session, "userID") or !structKeyExists(session, "loggedin") ){
            if(!(FindNoCase("login",requestname) > 0 
            or FindNoCase("registration",requestname) > 0  
            or FindNoCase("movieListing",requestname) > 0
            or FindNoCase("about",requestname) > 0 
            or FindNoCase("index",requestname) > 0 ))
            {
               location("login.cfm",false);
            }
        }
    }

    function onMissingTemplate(targetPage){
        writeOutput('<center><h1>This Page your are looking for is not avilable.</h1>
		<p>Please Enter the correct URL</p></center>');
    }
}
