<cfoutput>
    <cfdocument format="PDF" filename="file.pdf" overwrite="Yes">
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
        <html>
            <head>
                <title>Ticket </title>
            </head>
            <body>
                <cfset variables.DecrptKey = "abc!@" />
                <cfset BookObj=CreateObject("component","component.moviesDetails")/>
                <cfset variables.bookId = Decrypt(URL.bookingId, DecrptKey) />
            	<cfset bookings=BookObj.displayBookingID(#bookId#)/>
                <h1 align="center">Ticket</h1>
                <hr>
                <h1 align="center"><img src="barcode/barcode.jpg" width="180px" height="180px"></h1>
                    <pre>
                        
                    <b> Movie Name      <i>#bookings.movieTitle# (#bookings.movieGenre# )</i></b>
                
                
                    <b> Booked Date     <i>#DateFormat(bookings.date)# </i></b>
                
                
                    <b> Show Date       <i>#DateFormat(bookings.ticket_date)# </i></b>
                
                
                    <b> Show Time       <i>#TimeFormat(bookings.start_time)# </i></b>
                    
                
                    <b> Tickets         <i>#bookings.seat_count# nos </i></b>
                
                
                    <b> Total Amount    <i>#bookings.amount# Rs.</i></b>
                        
                    </pre>
                <hr>
            </body>
        </html>
    </cfdocument>
    <cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
    <cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes">
</cfoutput>