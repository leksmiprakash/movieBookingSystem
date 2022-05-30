<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayalldata" access="public" returnType="any" output="false">
          <cfset variables.getMovies = EntityLoad('Movies',{},'movieID desc')>
          <cfreturn variables.getMovies >    
     </cffunction>

    <cffunction  name="movieData" access="remote">

        <cfargument name="movieTitle" required="true">
        <cfargument name="movieGenre" required="true">
        <cfargument name="movieDuration" required="true">
        <cfargument name="movieRelDate" required="true">
        <cfargument name="movieDirector" required="true">
        <cfargument name="movieActors" required="true">
        <cfargument name="movieImg" required="true">
        <cfargument name="old_file" required="true">
        <cfargument name="updateId" required="true">
        <cfargument name="movieTrailer" required="true">
        <cfargument name="movieDesc" required="true">
        
        <cfset session.movieArray = ArrayNew(1) /> 
        <cfif arguments.movieTitle eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Name") />
        </cfif>
        <cfif arguments.movieGenre eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Genre") />
        </cfif>
        <cfif arguments.movieDuration eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Duration") />
        </cfif>
        <cfif arguments.movieRelDate eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Release Date") />
        </cfif>
        <cfif arguments.movieDirector eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Director") />
        </cfif>
        <cfif arguments.movieActors eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Actors") />
        </cfif>
        <cfif arguments.movieTrailer eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Trailer") />
        </cfif>
        <cfif arguments.movieDesc eq "">
            <cfset ArrayAppend(session.movieArray, "Please enter the Movie Description") />
        </cfif>
        <cfif ArrayIsEmpty(session.movieArray)>
            <cfif arguments.updateId gt 0>
                <cfif arguments.movieImg != "">
                    <cffile action="upload"
                        fileField="movieImg"
                        destination="F:\ColdFusion2021\cfusion\wwwroot\movieBookingSystem\movie"
                        nameconflict="makeunique"
                        result="img">
                    <cfset variables.img = img.serverFile>
                <cfelse>
                    <cfset variables.img = arguments.old_file>
                </cfif>
                <cfquery name="updateQuery">
                    UPDATE movies 
                    SET movieTitle = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieTitle#">, 
                        movieGenre = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieGenre#">,
                        movieDuration = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieDuration#">,
                        movieRelDate = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieRelDate#">,
                        movieDirector = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieDirector#">,
                        movieActors = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieActors#">,
                        movieImg = <cfqueryparam CFSQLType="cf_sql_varchar" value="#variables.img#">,
                        movieTrailer = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieTrailer#">,
                        movieDescription = <cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.movieDesc#">
                    WHERE movieID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.updateId#"> 
                </cfquery>
                <cfset ArrayAppend(session.movieArray, "Updated successfully") />
            <cfelse>
                <cfif arguments.movieImg != "">
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
                    INSERT INTO movies (movieTitle, movieGenre, movieDuration, movieRelDate,movieDirector,movieActors,movieImg,movieTrailer,movieDescription)
                    VALUES (
                        <cfqueryparam value="#arguments.movieTitle#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieGenre#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieDuration#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieRelDate#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieDirector#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieActors#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#img#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieTrailer#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.movieDesc#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cfset ArrayAppend(session.movieArray, "Inserted successfully") />
            </cfif>
        </cfif>
        <cflocation url="../addMovie.cfm" addtoken="no">
        <cfreturn session.movieArray>
    </cffunction>

    <cffunction name="deleteMovie" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="deleteId" required="true">
        <cfquery name="DeleteData"> 
            DELETE FROM movies 
            WHERE movieID = <cfqueryparam value="#arguments.deleteId#"  cfsqltype="cf_sql_integer">
        </cfquery>    
        <cfset variables.returnValue = true>
        <cfreturn variables.returnValue>
    </cffunction>

    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
          <cfargument name="editid" required="true">
          <cfquery name = "getMovieById"    >
               select *  from movies where movieID=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
          </cfquery>
          <cfreturn getMovieById> 
     </cffunction>

    <cffunction name="displayMovieShowing" access="public" returnType="any" output="false">
        <cfquery name = "getMovieshowing"    >
            select count(movieID) as movieCount from movies where status=1    
        </cfquery>
        <cfreturn getMovieshowing> 
    </cffunction>

    <cffunction name="displayUsersTotal" access="public" returnType="any" output="false">
        <cfquery name = "getUsersTotal"    >
            select count(user_id) as userCount from userstable where role=2  
        </cfquery>
        <cfreturn getUsersTotal> 
    </cffunction>

    <cffunction name="displayBooksTotal" access="public" returnType="any" output="false">
        <cfquery name = "getBooksTotal"    >
            select count(book_id) as bookCount from bookings where status=1   
        </cfquery>
        <cfreturn getBooksTotal> 
    </cffunction>

    <cffunction name="displayTheatresTotal" access="public" returnType="any" output="false">
        <cfquery name = "getTheatresTotal"    >
            select count(t_id) as theatreCount from theatres
        </cfquery>
        <cfreturn getTheatresTotal> 
    </cffunction>

    <cffunction name="displayBookingData" access="public" returnType="any" output="false">
        <cfquery name = "getBookings"    >
            select bookings.*,shows.*,showtimes.showName,showtimes.start_time,theatres.t_name,movies.movieTitle  
            from bookings
            join shows on bookings.show_id = shows.s_id 
            join movies on shows.movie_id = movies.movieID
            join theatres on bookings.t_id = theatres.t_id
            join showtimes on shows.st_id = showtimes.st_id order by ticket_date asc
        </cfquery>
        <cfreturn getBookings> 
    </cffunction>

</cfcomponent>