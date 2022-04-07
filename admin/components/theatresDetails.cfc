<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayalldata" access="public" returnType="any" output="false">
          <cfset variables.gettheatre = EntityLoad('Theatres','tid desc')>
          <cfreturn variables.gettheatre >    
     </cffunction>

    <cffunction  name="theatreData" access="remote">
        <cfset session.messageArray = ArrayNew(1) /> 
        <cfif form.tName eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Theatre Name") />
        </cfif>
        <cfif form.tAddress eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the first name") />
        </cfif>
        <cfif form.tEmail eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the last Name") />
        </cfif>
        <cfif form.tPhone eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the gender") />
        </cfif>
        
        <cfif ArrayIsEmpty(session.messageArray)>
                <cfif form.tPhoto != "">
                    <cffile action="upload"
                        fileField="tPhoto"
                        destination="F:\ColdFusion2021\cfusion\wwwroot\movieBookingSystem\theatre"
                        nameconflict="makeunique"
                        result="img">
                    <cfset img = img.serverFile>
                <cfelse>
                    <cfset img = "no-image.png">
                </cfif>
                <cfquery result="result">
                    INSERT INTO treg (name, address, email, phone, photo)
                    VALUES (
                        <cfqueryparam value="#form.tName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tAddress#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tEmail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tPhone#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#img#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cflocation url="../addTheatre.cfm" addtoken="no">
                <cfset ArrayAppend(session.messageArray, "Inserted successfully") />
        </cfif>
        <cfreturn session.messageArray>
    </cffunction>
    <cffunction name="deleteQuery" output="false" access="public">
        <cfquery name="DeleteData"> 
                DELETE FROM contactNumbers 
                WHERE id = #URL.id# 
        </cfquery> 
        <cfreturn>
    </cffunction>
    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
          <cfargument name="editid" required="true">
          <cfquery name = "getcontactbyid"    >
               select *  from contactNumbers where id=<cfqueryparam value="#form.editid#"  cfsqltype="cf_sql_integer">      
          </cfquery>
          <cfreturn getcontactbyid> 
     </cffunction>
</cfcomponent>