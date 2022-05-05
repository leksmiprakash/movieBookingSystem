<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayalldata" access="public" returnType="any" output="false">
          <cfset variables.getTheatres = EntityLoad('Theatres',{},'t_id desc')>
          <cfreturn variables.getTheatres >    
     </cffunction>

    <cffunction  name="theatreData" access="remote">
        <cfset session.theatreArray = ArrayNew(1) /> 
        <cfif form.tName eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the Theatre Name") />
        </cfif>
        <cfif form.tAddress eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the first name") />
        </cfif>
        <cfif form.tEmail eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the last Name") />
        </cfif>
        <cfif form.tPhone eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the gender") />
        </cfif>
         <cfif form.tRate eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the Rate") />
        </cfif>
        <cfif ArrayIsEmpty(session.theatreArray)>
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
                        price = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.tRate#">,
                        t_photo = <cfqueryparam CFSQLType="cf_sql_varchar" value="#variables.img#">
                    WHERE t_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.updateId#"> 
                </cfquery>
                <cfset ArrayAppend(session.theatreArray, "Updated successfully") />
                <cflocation url="../addTheatre.cfm" addtoken="no">
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
                    INSERT INTO theatres (t_name, t_address, t_email, t_phone, price, t_photo)
                    VALUES (
                        <cfqueryparam value="#form.tName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tAddress#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tEmail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tPhone#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.tRate#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#img#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cfset ArrayAppend(session.theatreArray, "Inserted successfully") />
                <cflocation url="../addTheatre.cfm" addtoken="no">
            </cfif>
        </cfif>
        <cfreturn session.theatreArray>
    </cffunction>

   <cffunction name="deleteTheatre" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editId" required="true">
        <cfquery name="DeleteData"> 
            DELETE FROM theatres 
            WHERE t_id = <cfqueryparam value="#arguments.editId#"  cfsqltype="cf_sql_integer">
        </cfquery> 
        <cfif DeleteData.recordCount EQ 1>      
            <cfset variables.returnValue = true>
        <cfelse>
            <cfset variables.returnValue = false>
        </cfif>
        <cfreturn variables.returnValue>
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
        <cfquery name = "getShowTimes"    >
            select showTimes.*, theatres.t_name from showTimes join theatres on  showTimes.theatre_id = theatres.t_id
        </cfquery>
        <cfreturn variables.getShowTimes >    
    </cffunction>

    <cffunction name="displayShowTimedata" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editid" required="true">
        <cfquery name = "getShowTimeById"    >
            select *  from ShowTimes where St_id=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
        </cfquery>
        <cfreturn getShowTimeById> 
    </cffunction>

    <cffunction name="showTimeTheatre" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editid" required="true">
        <cfquery name = "getShowTimeById"    >
            select st_id,showName  from ShowTimes where theatre_id=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
        </cfquery>
        <cfreturn getShowTimeById> 
    </cffunction>

    <cffunction  name="showTimeData" access="remote">
        <cfset session.showTimerray = ArrayNew(1) /> 
        <cfif form.tId eq "">
            <cfset ArrayAppend(session.showTimerray, "Please enter the Theatre Name") />
        </cfif>
        <cfif form.showNameId eq "">
            <cfset ArrayAppend(session.showTimerray, "Please enter the first name") />
        </cfif>
        <cfif form.sTime eq "">
            <cfset ArrayAppend(session.showTimerray, "Please enter the last Name") />
        </cfif>
        <cfif ArrayIsEmpty(session.showTimerray)>
            <cfif form.updateId gt 0>
                
                <cfquery name="updateQuery">
                    UPDATE showtimes 
                    SET theatre_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.tId#">, 
                        showName = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.showNameId#">,
                        start_time = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.sTime#">
                    WHERE st_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.updateId#"> 
                </cfquery>
                <cfset ArrayAppend(session.showTimerray, "Updated successfully") />
                <cflocation url="../addShowTime.cfm" addtoken="no">
            <cfelse>
                
                <cfquery result="result">
                    INSERT INTO showtimes (theatre_id, showName, start_time)
                    VALUES (
                        <cfqueryparam value="#form.tId#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#form.showNameId#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.sTime#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cfset ArrayAppend(session.showTimerray, "Inserted successfully") />
                <cflocation url="../addShowTime.cfm" addtoken="no">
            </cfif>
        </cfif>
        <cfreturn session.showTimerray>
    </cffunction>


    <!------------------------------Show-------------------------->

    <cffunction name="displayallShowdata" access="public" returnType="any" output="false">
        <cfset variables.getShows = EntityLoad('Shows',{},'s_id desc')>
        <cfreturn variables.getShows>    
    </cffunction>

    

</cfcomponent>