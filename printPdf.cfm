<cfoutput>
    <cfdocument format="PDF" filename="file.pdf" overwrite="Yes">
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
        <html>
            <head>
                <title>Hello World</title>
            </head>
            <body>
                <cfset variables.DecrptKey = "abc!@" />
                <cfset BookObj=CreateObject("component","component.moviesDetails")/>
                <cfset variables.bookId = Decrypt(URL.bookingId, DecrptKey) />
            	<cfset bookings=BookObj.displayBookingID(#bookId#)/>
                <table class="table table-bordered" >
                    <thead>
                    <tr>
                        <th scope="col">Movie Name</th>
                        <th scope="col">Date</th>
                        <th scope="col">Time</th>
                        <th scope="col">Tickets</th>
                        <th scope="col">Total Amount</th>
                    </tr>
                    </thead>
                    <tbody>
                    
                        <tr>
                        <td>#movieTitle#</td>
                        <td> #DateFormat(ticket_date)# </td>
                        <td>#TimeFormat(start_time)# </td>
                        <td>#seat_count# </td>
                        <td>#amount# </td>
                        </tr>
                   
                    </tbody>
                </table>
            </body>
        </html>
    </cfdocument>
    <cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
    <cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes">
</cfoutput>