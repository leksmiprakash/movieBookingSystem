<cfset session.loggedin = false>
<cfset sessionInvalidate()/>
<cfcookie name="CFID" value="" expires="now">
<cfcookie name="CFTOKEN" value="" expires="now">
<cfset  StructClear(Session) />
<cflocation url = "login.cfm" addtoken="no">

