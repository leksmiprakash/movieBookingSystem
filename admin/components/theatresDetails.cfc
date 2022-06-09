<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayalldata" access="public" returnType="any" output="false">
          <cfset local.getTheatres = EntityLoad('Theatres',{},'t_id desc')>
          <cfreturn local.getTheatres >    
     </cffunction>

    <cffunction  name="theatreData" access="remote">

        <cfargument name="tName" required="true">
        <cfargument name="tAddress" required="true">
        <cfargument name="tEmail" required="true">
        <cfargument name="tPhone" required="true">
        <cfargument name="tRate" required="true">
        <cfargument name="tPhoto" required="true">
        <cfargument name="old_file" required="true">
        <cfargument name="updateId" required="true">

        <cfset session.theatreArray = ArrayNew(1) /> 
        <cfif arguments.tName eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the Theatre Name") />
        </cfif>
        <cfif arguments.tAddress eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the first name") />
        </cfif>
        <cfif arguments.tEmail eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the last Name") />
        </cfif>
        <cfif arguments.tPhone eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the gender") />
        </cfif>
         <cfif arguments.tRate eq "">
            <cfset ArrayAppend(session.theatreArray, "Please enter the Rate") />
        </cfif>
        <cfif ArrayIsEmpty(session.theatreArray)>
            <cfif arguments.updateId gt 0>
                <cfif arguments.tPhoto != "">
                    <cffile action="upload"
                        fileField="tPhoto"
                        destination="F:\ColdFusion2021\cfusion\wwwroot\movieBookingSystem\theatre"
                        nameconflict="makeunique"
                        result="img">
                    <cfset local.img = img.serverFile>
                <cfelse>
                    <cfset local.img = arguments.old_file>
                </cfif>
                <cfquery name="updateQuery">
                    UPDATE theatres 
                    SET t_name = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.tName#">, 
                        t_address = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.tAddress#">,
                        t_email = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.tEmail#">,
                        t_phone = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.tPhone#">,
                        price = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.tRate#">,
                        t_photo = <cfqueryparam CFSQLType="cf_sql_varchar" value="#local.img#">
                    WHERE t_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.updateId#"> 
                </cfquery>
                <cfset ArrayAppend(session.theatreArray, "Updated successfully") />
                <cflocation url="../addTheatre.cfm" addtoken="no">
            <cfelse>
                <cfif arguments.tPhoto != "">
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
                        <cfqueryparam value="#arguments.tName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.tAddress#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.tEmail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.tPhone#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.tRate#" cfsqltype="cf_sql_varchar">,
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
        <cfargument name="deleteId" required="true">
        <cfquery name="DeleteData"> 
            DELETE FROM theatres 
            WHERE t_id = <cfqueryparam value="#arguments.deleteId#"  cfsqltype="cf_sql_integer">
        </cfquery>    
        <cfset local.returnValue = true>
        <cfreturn local.returnValue>
    </cffunction>

    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
          <cfargument name="editid" required="true">
          <cfquery name = "getTheatreById"    >
               select *  from theatres where t_id=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
          </cfquery>
          <cfreturn getTheatreById> 
     </cffunction>
    
    <!-----------------------------Shows---------------------------->

    <cffunction name="displayallShowNamedata" access="public" returnType="any" output="false">
        <cfset local.getShowNames = EntityLoad('ShowNames',{},'sn_id desc')>
        <cfreturn local.getShowNames >    
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
    
        <cfargument name="tId" required="true">
        <cfargument name="showNameId" required="true">
        <cfargument name="sTime" required="true">
        <cfargument name="updateId" required="true">

        <cfset session.showTimerray = ArrayNew(1) /> 
        <cfif arguments.tId eq "">
            <cfset ArrayAppend(session.showTimerray, "Please enter the Theatre Name") />
        </cfif>
        <cfif arguments.showNameId eq "">
            <cfset ArrayAppend(session.showTimerray, "Please enter the first name") />
        </cfif>
        <cfif arguments.sTime eq "">
            <cfset ArrayAppend(session.showTimerray, "Please enter the last Name") />
        </cfif>
        <cfif ArrayIsEmpty(session.showTimerray)>
            <cfif arguments.updateId gt 0>
                
                <cfquery name="updateQuery">
                    UPDATE showtimes 
                    SET theatre_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.tId#">, 
                        showName = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.showNameId#">,
                        start_time = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.sTime#">
                    WHERE st_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.updateId#"> 
                </cfquery>
                <cfset ArrayAppend(session.showTimerray, "Updated successfully") />
                <cflocation url="../addShowTime.cfm" addtoken="no">
            <cfelse>
                
                <cfquery result="result">
                    INSERT INTO showtimes (theatre_id, showName, start_time)
                    VALUES (
                        <cfqueryparam value="#arguments.tId#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#arguments.showNameId#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.sTime#" cfsqltype="cf_sql_varchar">
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
        <cfquery name = "getShows">
            select shows.*,showtimes.showName,showtimes.start_time,theatres.t_name,movies.movieTitle  
            from shows
            join movies on shows.movie_id = movies.movieID
            join theatres on shows.theatre_id = theatres.t_id
            join showtimes on shows.st_id = showtimes.st_id
        </cfquery>
        <cfreturn getShows> 
    </cffunction>

    <!------------------------------Password-------------------------->

    <cffunction name="updatePassword" access="remote" returnType="any" output="false">

        <cfargument name="oldPassword" required="true">
        <cfargument name="newPassword" required="true">
        <cfargument name="confirmPassword" required="true">
        <cfargument name="adminId" required="true">

        <cfset session.passwordArray = ArrayNew(1) /> 
        <cfif arguments.oldPassword eq "">
            <cfset ArrayAppend(session.passwordArray, "Please enter Old Password") />
        </cfif>
        <cfif arguments.newPassword eq "">
            <cfset ArrayAppend(session.passwordArray, "Please enter New Password") />
        </cfif>
        <cfif arguments.confirmPassword eq "">
            <cfset ArrayAppend(session.passwordArray, "Please enter Confirm Password") />
        </cfif>
         <cfif arguments.confirmPassword neq arguments.newPassword>
            <cfset ArrayAppend(session.passwordArray, "Confirm Password and password must be same") />
        </cfif>
        <cfif ArrayIsEmpty(session.passwordArray)>
            <cfquery name = "checkPassword">
                select user_id, password from userstable where user_id=<cfqueryparam value="#arguments.adminId#" cfsqltype="cf_sql_integer"> 
                and password =  <cfqueryparam value="#hash(arguments.oldPassword)#" cfsqltype="cf_sql_varchar"> 
            </cfquery>
            <cfif checkPassword.recordCount EQ 1>    
                <cfquery name="updatePassword">
                    UPDATE userstable 
                    SET password = <cfqueryparam CFSQLType="cf_sql_varchar" value="#hash(arguments.newPassword)#">
                    WHERE user_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.adminId#"> 
                </cfquery>
                <cfset ArrayAppend(session.passwordArray, "Password Updated Successfully") />
            <cfelse>
                <cfset ArrayAppend(session.passwordArray, "Please enter the correct password") />
            </cfif>
        </cfif>
        <cflocation url="../updatePassword.cfm" addtoken="no">
        <cfreturn session.passwordArray> 
    </cffunction>

    <cffunction  name="showsAddData" access="remote">
     
        <cfargument name="movieId" required="true">
        <cfargument name="tId" required="true">
        <cfargument name="stData" required="true">
        <cfargument name="showDate" required="true">
        <cfargument name="status" required="true">

        <cfset session.showsArray = ArrayNew(1) /> 
        <cfif arguments.movieId eq "">
            <cfset ArrayAppend(session.showsArray, "Please select the movie") />
        </cfif>
        <cfif arguments.tId eq "">
            <cfset ArrayAppend(session.showsArray, "Please select theatre") />
        </cfif>
        <cfif arguments.stData eq "">
            <cfset ArrayAppend(session.showsArray, "Please show time") />
        </cfif>
        <cfif arguments.showDate eq "">
            <cfset ArrayAppend(session.showsArray, "Please insert show time") />
        </cfif>
        <cfif arguments.status eq "">
            <cfset ArrayAppend(session.showsArray, "Please select show status") />
        </cfif>
        
        <cfif ArrayIsEmpty(session.showsArray)>
            
            <cfquery result="result">
                INSERT INTO shows (movie_id, theatre_id, start_date, st_id, status)
                VALUES (
                    <cfqueryparam value="#arguments.movieId#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.tId#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.showDate#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.stData#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>
            <cfset ArrayAppend(session.showsArray, "Inserted successfully") />
            <cflocation url="../addshow.cfm" addtoken="no">
        </cfif>
        <cfreturn session.showsArray>
    </cffunction>

    <cffunction name="stopShow" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="showId">
        <cfargument name="status">
        <cfquery name="showData"> 
            UPDATE shows set status = <cfqueryparam value="#arguments.status#"  cfsqltype="cf_sql_integer">
            WHERE s_id = <cfqueryparam value="#arguments.showId#"  cfsqltype="cf_sql_integer">
        </cfquery>    
        <cfset local.returnValue = true>
        <cfreturn local.returnValue>
    </cffunction>

</cfcomponent>