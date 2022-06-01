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
                        <tr>
                            <th>Movie Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </th>
                            <td>#bookings.movieTitle# (#bookings.movieGenre# )</td>
                        </tr>
                        <tr>
                            <th>Booked Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </th>
                            <td>#DateFormat(bookings.date)# </td>
                        </tr>
                        <tr>
                            <th>Show Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </th>
                            <td>#DateFormat(bookings.ticket_date)# </td>
                        </tr>
                        <tr>
                            <th>Show Time &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </th>
                            <td>#TimeFormat(bookings.start_time)# </td>
                        </tr>    
                        <tr>
                            <th>Tickets &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </th>
                            <td>#bookings.seat_count# </td>
                        </tr>
                        <tr>
                            <th>Total Amount &nbsp;&nbsp;: </th>
                            <td>#bookings.amount# </td>
                        </tr>
                        <tr>
                            <th>Barcode &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </th>
                            <td></td>
                        </tr>
                        
                </table>
                
            </body>
        </html>
    </cfdocument>
    <cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
    <cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes">
</cfoutput>