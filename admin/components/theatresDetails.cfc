<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayalldata" access="public" returnType="any" output="false">
          <cfset variables.getTheatres = EntityLoad('Theatres',{},'t_id desc')>
          <cfreturn variables.getTheatres >    
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
            <cfif form.updateId gt 0>
                <cfif form.tPhoto != "">
                    <cffile action="upload"
                        fileField="tPhoto"
                        destination="F:\ColdFusion2021\cfusion\wwwroot\movieBookingSystem\theatre"
                        nameconflict="makeunique"
                        result="img">
                    <cfset variables.img = img.serverFile>
                <cfelse>
                    <cfset variables.img = form.old_file>
                </cfif>
                <cfquery name="updateQuery">
                    UPDATE theatres 
                    SET t_name = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.tName#">, 
                        t_address = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.tAddress#">,
                        t_email = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.tEmail#">,
                        t_phone = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.tPhone#">,
                        t_photo = <cfqueryparam CFSQLType="cf_sql_varchar" value="#variables.img#">
                    WHERE t_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.updateId#"> 
                </cfquery>
                <cflocation url="../dashboard.cfm" addtoken="no">
                <cfset ArrayAppend(session.messageArray, "Updated successfully") />
            <cfelse>
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
                    INSERT INTO theatres (t_name, t_address, t_email, t_phone, t_photo)
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
        </cfif>
        <cfreturn session.messageArray>
    </cffunction>
    <cffunction name="deleteQuery" output="false" access="public">
        <cfquery name="DeleteData"> 
                DELETE FROM theatres 
                WHERE t_id = #URL.id# 
        </cfquery> 
        <cfreturn>
    </cffunction>
    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
          <cfargument name="editid" required="true">
          <cfquery name = "getTheatreById"    >
               select *  from theatres where t_id=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
          </cfquery>
          <cfreturn getTheatreById> 
     </cffunction>

<!-------------------Screen--------------------------->

    <cffunction name="displayallScreendata" access="public" returnType="any" output="false">
        <cfset variables.getScreens = EntityLoad('Screens',{},'screen_id desc')>
        <cfreturn variables.getScreens >    
    </cffunction>

    <cffunction name="displayScreendata" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editid" required="true">
        <cfquery name = "getScreenById"    >
            select *  from screens where screen_id=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
        </cfquery>
        <cfreturn getScreenById> 
    </cffunction>

    <cffunction  name="screenData" access="remote">
        <cfset session.messageArray = ArrayNew(1) /> 
        <cfif form.tId eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Theatre Name") />
        </cfif>
        <cfif form.sName eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Screen name") />
        </cfif>
        <cfif form.seats eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the total Seats") />
        </cfif>
        <cfif form.charge eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Cost") />
        </cfif>
        <cfif ArrayIsEmpty(session.messageArray)>
            <cfif form.updateId gt 0>
                <cfquery name="updateQuery">
                    UPDATE screens 
                    SET theatre_id = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.tId#">, 
                        screen_name = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.sName#">,
                        seats = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.seats#">,
                        charge = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.charge#">
                    WHERE screen_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.updateId#"> 
                </cfquery>
                <cflocation url="../dashboard.cfm" addtoken="no">
                <cfset ArrayAppend(session.messageArray, "Updated successfully") />
            <cfelse>
                <cfquery result="result">
                    INSERT INTO screens (theatre_id, screen_name, seats, charge)
                    VALUES (
                        <cfqueryparam value="#form.tId#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.sName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.seats#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.charge#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cflocation url="../addScreen.cfm" addtoken="no">
                <cfset ArrayAppend(session.messageArray, "Inserted successfully") />
            </cfif>
        </cfif>
        <cfreturn session.messageArray>
    </cffunction>

    <!-----------------------------Shows---------------------------->

    <cffunction name="displayallShowNamedata" access="public" returnType="any" output="false">
        <cfset variables.getShowNames = EntityLoad('ShowNames',{},'sn_id desc')>
        <cfreturn variables.getShowNames >    
    </cffunction>

    <!------------------------------ShowTime-------------------------->

    <cffunction name="displayallShowTimedata" access="public" returnType="any" output="false">
        <cfset variables.getShowTimes = EntityLoad('ShowTimes',{},'st_id desc')>
        <cfreturn variables.getShowTimes >    
    </cffunction>

    <cffunction name="displayShowTimedata" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editid" required="true">
        <cfquery name = "getShowTimeById"    >
            select *  from ShowTimes where St_id=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
        </cfquery>
        <cfreturn getShowTimeById> 
    </cffunction>

    <cffunction name="getScreens" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="theatreId" required="true">
        <cfquery name = "getScreensById"    >
            select *  from screens where theatre_id=<cfqueryparam value="#arguments.theatreId#"  cfsqltype="cf_sql_integer">      
        </cfquery>
        <cfreturn getScreensById> 
    </cffunction>


    <!------------------------------Show-------------------------->

    <cffunction name="displayallShowdata" access="public" returnType="any" output="false">
        <cfset variables.getShows = EntityLoad('Shows',{},'s_id desc')>
        <cfreturn variables.getShows>    
    </cffunction>


</cfcomponent>