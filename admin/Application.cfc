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
    // function onRequestStart(requestname){ 
    //     if(!structKeyExists(session, "adminID") or !structKeyExists(session, "loggedinAdmin") ){
    //         if(!(FindNoCase("admin/login",requestname) > 0 ))
    //         {
    //            location("/movieBookingSystem/admin/login.cfm",false);
    //         }
    //     }
    // }
    function onError(Exception,EventName){
        writeOutput('<center><h1>An error occurred</h1>
		<p>Please Contact the developer</p>
		<p>Error details: #Exception.message#</p></center>');
    }
    function onMissingTemplate(targetPage){
        writeOutput('<center><h1>This Page your are looking for is not avilable.</h1>
		<p>Please Enter the correct URL</p></center>');
    }
}