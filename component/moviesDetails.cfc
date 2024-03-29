<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayLimitedData" access="public" returnType="any" output="false">
        <cfset local.getMovies = EntityLoad('Movies',{status="1"},'movieID desc', {maxResults=4})>
        <cfreturn local.getMovies >    
    </cffunction>

    <cffunction name="displayNewData" access="public" returnType="any" output="false">
        <cfset upcomingDate = NOW() >
        <cfset local.getMovies = EntityLoad('Movies',{status="1"},'movieID desc')>
        <cfreturn local.getMovies >    
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

        <cfargument name="bookMovie" required="true">
        <cfargument name="showId" required="true">
        <cfargument name="bookCount" required="true">
        <cfargument name="bookTotal" required="true">
        <cfargument name="theatreId" required="true">
        <cfargument name="price" required="true">   
        <cfargument name="bookSeats" required="true">   
        <cfargument name="userEmail" required="true">
        <cfargument name="ticketDate" required="true">
        <cfargument name="userId" required="true">
        
        <cfset session.bookedArray = ArrayNew(1) /> 
        <cfif arguments.bookSeats eq "">
            <cfset ArrayAppend(session.bookedArray, "Please select Seats to continue") />
        </cfif>
        
        <cfif ArrayIsEmpty(session.bookedArray)>
            <cfquery result="result">
                INSERT INTO bookings (t_id, user_id, show_id, no_seats, amount, seat_count,ticket_date)
                VALUES (
                    <cfqueryparam value="#arguments.theatreId#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#arguments.userId#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#arguments.showId#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#arguments.bookSeats#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.bookTotal#" cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value="#arguments.bookCount#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.ticketDate#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>
            <cfmail to = "#arguments.userEmail#" from = "lekshmi.prakash@techversantinfo.com" subject = "Booking successfull" >  
                Congrats Your Ticket have been created !! on #arguments.ticketDate# #arguments.bookCount# Tickets. Total #arguments.bookTotal# Rs
            </cfmail> 
            <cfset local.EncrptKey = "abc!@" />
            <cfset ArrayAppend(session.bookedArray, "Complete your payment to continue") />
            <cflocation url = "../paymentPage.cfm?bookId=#URLEncodedFormat(Encrypt(result.generated_key, EncrptKey))#" addtoken="no">
        </cfif>
        <cflocation url = "../bookingSeats.cfm" addtoken="no">
        <cfreturn session.bookedArray>
    </cffunction>

    <cffunction name="displayBookingData" access="public" returnType="any" output="false">
        <cfquery name = "getBookings">
            select bookings.*,shows.*,showtimes.showName,showtimes.start_time,theatres.t_name,movies.movieTitle,
                   userstable.userName,userstable.email,userstable.phone
            from bookings
            join shows on bookings.show_id = shows.s_id 
            join movies on shows.movie_id = movies.movieID
            join theatres on bookings.t_id = theatres.t_id
            join showtimes on shows.st_id = showtimes.st_id
            join userstable on bookings.user_id = userstable.user_id
            where bookings.user_id=<cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_integer"> 
            and  bookings.status='1' order by ticket_date desc
        </cfquery>
        <cfreturn getBookings> 
    </cffunction>
    <cffunction name="getUserData" access="public" returnType="any" output="false">
        <cfargument name="userID" required="true">
        <cfquery name = "getuserById"    >
            select *  from userstable where user_id=<cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn getuserById> 
    </cffunction>

    <cffunction name="displayBookingID" access="public" returnType="any" output="false">
        <cfargument name="bookingId" required="true">
        <cfquery name = "getBooking" >
            select bookings.*,shows.*,showtimes.showName,showtimes.start_time,theatres.t_name,movies.* 
            from bookings
            join shows on bookings.show_id = shows.s_id 
            join movies on shows.movie_id = movies.movieID
            join theatres on bookings.t_id = theatres.t_id
            join showtimes on shows.st_id = showtimes.st_id
            where bookings.user_id=<cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_integer"> 
            and bookings.book_id=<cfqueryparam value="#arguments.bookingId#"  cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn getBooking> 
    </cffunction>
    
    <cffunction name="updatePassword" access="remote" returnType="any" output="false">

        <cfargument name="oldPassword" required="true">
        <cfargument name="newPassword" required="true">
        <cfargument name="confirmPassword" required="true">
        <cfargument name="userId" required="true">

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
                select user_id, password from userstable where user_id=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer"> 
                and password =  <cfqueryparam value="#hash(arguments.oldPassword)#" cfsqltype="cf_sql_varchar"> 
            </cfquery>
            <cfif checkPassword.recordCount EQ 1>    
                <cfquery name="updatePassword">
                    UPDATE userstable 
                    SET password = <cfqueryparam CFSQLType="cf_sql_varchar" value="#hash(arguments.newPassword)#">
                    WHERE user_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.userId#"> 
                </cfquery>
                <cfset ArrayAppend(session.passwordArray, "Password Updated Successfully") />
            <cfelse>
                <cfset ArrayAppend(session.passwordArray, "Please enter the correct password") />
            </cfif>
            
        </cfif>
        <cflocation url="../updatePassword.cfm" addtoken="no">
        <cfreturn session.passwordArray> 
    </cffunction>

    <cffunction name = "completePayment" returnType = "any" returnformat="JSON"  access = "remote" output="true">
        
        <cfargument name="bookAmount" required="true">
        <cfargument name="bookId" required="true">
        <cfargument name="userId" required="true">
        <cfargument name="rzrpmtid" required="true">
        <cfquery name="insertQuery"  result="paymentResult">
            INSERT INTO `payments`(`user_id`, `booking_id`, `amount`,`txn_id`) 
            VALUES (
            <cfqueryparam value ="#arguments.userId#" cfsqltype = "cf_sql_integer"/>,
            <cfqueryparam value ="#arguments.bookId#" cfsqltype = "cf_sql_integer"/>,
            <cfqueryparam value ="#arguments.bookAmount#" cfsqltype = "cf_sql_integer"/>,
            <cfqueryparam value ="#arguments.rzrpmtid#" cfsqltype = "cf_sql_varchar"/>);
        </cfquery>
        <cfset local.getNumberOfRecords = listLen(paymentResult.generated_key)>
        <cfif local.getNumberOfRecords GT 0>
             <cfquery name="updateBooking" result="bookingResult">
                UPDATE `bookings` SET status='1'
                where book_id=<cfqueryparam value ="#arguments.bookId#" cfsqltype = "cf_sql_integer"/>;
            </cfquery>
            <cfset local.getNumberOfRecords = listLen(bookingResult.RecordCount)> 
            <cfif local.getNumberOfRecords GT 0>
               
                <cfset local.goto="myBookings.cfm"/>
            <cfelse>
                
                <cfset local.goto="paymentPage.cfm?bookId="&arguments.bookId/>
            </cfif>
        </cfif>
        <cfreturn local.goto>
    </cffunction>

    <cffunction  name="forgotPassword" access="remote">
        <cfset session.emailArray = ArrayNew(1) /> 
        <cfif form.email eq "">
            <cfset ArrayAppend(session.emailArray, "Please enter your email to continue") />
        </cfif>
        
        <cfif ArrayIsEmpty(session.emailArray)>
            <cfquery name = "checkEmail">
                select user_id, email, password from userstable where email=<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar"> 
            </cfquery>
            <cfif checkEmail.recordCount EQ 1>    
                <cfmail to = "#Form.email#" from = "lekshmi.prakash@techversantinfo.com" subject = "Recover Password" >  
                    Recover Your Password !! Your Current password is #checkEmail.password# . Change your Password
                </cfmail> 
                <cfset ArrayAppend(session.emailArray, "Password send Successfully") />
            <cfelse>
                <cfset ArrayAppend(session.emailArray, "Please enter the correct email") />
            </cfif>
            <cflocation url="../index.cfm" addtoken="no">
        </cfif>
        <cfreturn session.emailArray>
    </cffunction>

</cfcomponent>