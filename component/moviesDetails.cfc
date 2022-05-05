<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayLimitedData" access="public" returnType="any" output="false">
        <cfset variables.getMovies = EntityLoad('Movies',{status="1"},'movieID desc', {maxResults=4})>
        <cfreturn variables.getMovies >    
    </cffunction>

    <cffunction name="displayNewData" access="public" returnType="any" output="false">
        <cfset upcomingDate = NOW() >
        <cfset variables.getMovies = EntityLoad('Movies',{status="1"},'movieID desc')>
        <cfreturn variables.getMovies >    
    </cffunction>

    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editid" required="true">
        <cfquery name = "getMoviedata"    >
            select *  from movies where movieID=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">  and status = "1"    
        </cfquery>
        <cfreturn getMoviedata> 
    </cffunction>

    <cffunction name="displayMoviebyId" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="id" required="true">
        <cfquery name = "getMovieById"    >
            select *  from movies where movieID=<cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">  and status = "1"    
        </cfquery>
        <cfreturn getMovieById> 
    </cffunction>

     <cffunction name="displayMovietheatres" access="public" returnType="any" output="false">
        <cfargument name="id" required="true">
        <cfquery name = "getMovietheatres"    >
            select DISTINCT shows.theatre_id,theatres.t_name 
            from shows 
            join theatres on shows.theatre_id = theatres.t_id where shows.movie_id=<cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn getMovietheatres> 
    </cffunction>

    <cffunction name="displayShowTimes" access="public" returnType="any" output="false">
        <cfargument name="movieId" required="true">
        <cfargument name="theatreId" required="true">
        <cfquery name = "getMovieShows"    >
            select shows.s_id,showtimes.showName,showtimes.start_time
            from shows 
            join showtimes on shows.st_id = showtimes.st_id
            where shows.movie_id=<cfqueryparam value="#arguments.movieId#"  cfsqltype="cf_sql_integer">  
            and shows.theatre_id=<cfqueryparam value="#arguments.theatreId#"  cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn getMovieShows> 
    </cffunction>
    
    <cffunction name="displayMovieShowsbyId" access="public" returnType="any" output="false">
        <cfargument name="showId" required="true">
        <cfquery name = "getMovieById"    >
            select movies.*,shows.*,showtimes.showName,showtimes.start_time,theatres.t_name,theatres.price  
            from shows 
            join movies on shows.movie_id = movies.movieID
            join theatres on shows.theatre_id = theatres.t_id
            join showtimes on shows.st_id = showtimes.st_id
            where shows.s_id=<cfqueryparam value="#arguments.showId#"  cfsqltype="cf_sql_integer"> 
        </cfquery>
        <cfreturn getMovieById> 
    </cffunction>
    <cffunction name="displayShowSeats" access="public" returnType="any" output="false">
        <cfargument name="showId" required="true">
        <cfargument name="ticketDate" required="true">
        <cfquery name = "getSeatById"    >
            select no_seats  from bookings where show_id=<cfqueryparam value="#arguments.showId#" cfsqltype="cf_sql_integer"> 
            and ticket_date=<cfqueryparam value="#arguments.ticketDate#" cfsqltype="cf_sql_date"> 
        </cfquery>
        <cfreturn getSeatById> 
    </cffunction>

    <cffunction  name="bookingData" access="remote">
        <cfset session.bookedArray = ArrayNew(1) /> 
        <cfif form.bookSeats eq "">
            <cfset ArrayAppend(session.bookedArray, "Please select Seats to continue") />
        </cfif>
        
        <cfif ArrayIsEmpty(session.bookedArray)>
            <cfquery result="result">
                INSERT INTO bookings (t_id, user_id, show_id, no_seats, amount, seat_count,ticket_date)
                VALUES (
                    <cfqueryparam value="#form.theatreId#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#session.userID#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#form.showId#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#form.bookSeats#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.bookTotal#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#form.bookCount#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.ticketDate#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>
            <cfset ArrayAppend(session.bookedArray, "Booked successfully") />
            <cflocation url="../movieListing.cfm" addtoken="no">
        </cfif>
        <cfreturn session.bookedArray>
    </cffunction>

    <cffunction name="displayBookingData" access="public" returnType="any" output="false">
        <cfquery name = "getBookings"    >
            select bookings.*,shows.*,showtimes.showName,showtimes.start_time,theatres.t_name,movies.movieTitle  
            from bookings
            join shows on bookings.show_id = shows.s_id 
            join movies on shows.movie_id = movies.movieID
            join theatres on bookings.t_id = theatres.t_id
            join showtimes on shows.st_id = showtimes.st_id
            where bookings.user_id=<cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_integer"> order by ticket_date desc
        </cfquery>
        <cfreturn getBookings> 
    </cffunction>

</cfcomponent>