<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayalldata" access="public" returnType="any" output="false">
          <cfset variables.getMovies = EntityLoad('Movies',{},'movieID desc')>
          <cfreturn variables.getMovies >    
     </cffunction>

    <cffunction  name="movieData" access="remote">
        <cfset session.messageArray = ArrayNew(1) /> 
        <cfif form.movieTitle eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Movie Name") />
        </cfif>
        <cfif form.movieGenre eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Movie Genre") />
        </cfif>
        <cfif form.movieDuration eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Movie Duration") />
        </cfif>
        <cfif form.movieRelDate eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Movie Release Date") />
        </cfif>
        <cfif form.movieDirector eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Movie Director") />
        </cfif>
        <cfif form.movieActors eq "">
            <cfset ArrayAppend(session.messageArray, "Please enter the Movie Actors") />
        </cfif>
        <cfif ArrayIsEmpty(session.messageArray)>
            <cfif form.updateId gt 0>
                <cfif form.movieImg != "">
                    <cffile action="upload"
                        fileField="movieImg"
                        destination="F:\ColdFusion2021\cfusion\wwwroot\movieBookingSystem\movie"
                        nameconflict="makeunique"
                        result="img">
                    <cfset variables.img = img.serverFile>
                <cfelse>
                    <cfset variables.img = form.old_file>
                </cfif>
                <cfquery name="updateQuery">
                    UPDATE movies 
                    SET movieTitle = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.movieTitle#">, 
                        movieGenre = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.movieGenre#">,
                        movieDuration = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.movieDuration#">,
                        movieRelDate = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.movieRelDate#">,
                        movieDirector = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.movieDirector#">,
                        movieActors = <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.movieActors#">,
                        movieImg = <cfqueryparam CFSQLType="cf_sql_varchar" value="#variables.img#">
                    WHERE movieID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.updateId#"> 
                </cfquery>
                <cflocation url="../dashboard.cfm" addtoken="no">
                <cfset ArrayAppend(session.messageArray, "Updated successfully") />
            <cfelse>
                <cfif form.movieImg != "">
                    <cffile action="upload"
                        fileField="movieImg"
                        destination="F:\ColdFusion2021\cfusion\wwwroot\movieBookingSystem\movie"
                        nameconflict="makeunique"
                        result="img">
                    <cfset img = img.serverFile>
                <cfelse>
                    <cfset img = "no-image.png">
                </cfif>
                <cfquery result="result">
                    INSERT INTO movies (movieTitle, movieGenre, movieDuration, movieRelDate,movieDirector,movieActors,movieImg)
                    VALUES (
                        <cfqueryparam value="#form.movieTitle#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.movieGenre#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.movieDuration#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.movieRelDate#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.movieDirector#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.movieActors#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#img#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cflocation url="../addMovie.cfm" addtoken="no">
                <cfset ArrayAppend(session.messageArray, "Inserted successfully") />
            </cfif>
        </cfif>
        <cfreturn session.messageArray>
    </cffunction>
    <cffunction name="deleteQuery" output="false" access="public">
        <cfquery name="DeleteData"> 
                DELETE FROM movies 
                WHERE movieID = #URL.id# 
        </cfquery> 
        <cfreturn>
    </cffunction>
    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
          <cfargument name="editid" required="true">
          <cfquery name = "getMovieById"    >
               select *  from movies where movieID=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
          </cfquery>
          <cfreturn getMovieById> 
     </cffunction>
</cfcomponent>