<cfcomponent displayname="userdata" hint="Data from user side">

    <cffunction name="displayLimitedData" access="public" returnType="any" output="false">
        <cfset variables.getMovies = EntityLoad('Movies',{},'movieID desc', {maxResults=4})>
        <cfreturn variables.getMovies >    
    </cffunction>

    <cffunction name="displayNewData" access="public" returnType="any" output="false">
        <cfset upcomingDate = NOW() >
        <cfset variables.getMovies = EntityLoad('Movies',{"movieRelDate" > NOW()},'movieID desc')>
        <cfreturn variables.getMovies >    
    </cffunction>

    <cffunction name="displaydata" access="remote" returnType="any" returnFormat="JSON" output="false">
        <cfargument name="editid" required="true">
        <cfquery name = "getMovieById"    >
            select *  from movies where movieID=<cfqueryparam value="#arguments.editid#"  cfsqltype="cf_sql_integer">      
        </cfquery>
        <cfreturn getMovieById> 
    </cffunction>
</cfcomponent>