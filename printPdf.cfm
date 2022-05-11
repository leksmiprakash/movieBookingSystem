<cfoutput>
    <cfdocument format="PDF" filename="file.pdf" overwrite="Yes">
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
        <html>
            <head>
                <title>Hello World</title>
            </head>
            <body>
                <cfset BookObj=CreateObject("component","component.moviesDetails")/>
            	<cfset bookings=BookObj.displayBookingData()/>
                <table class="table table-bordered" >
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Movie Name</th>
                        <th scope="col">Gender</th>
                        <th scope="col">DOB</th>
                        <th scope="col">Address</th>
                        <th scope="col">Email Id</th>
                        <th scope="col">Phone Number</th>
                    </tr>
                    </thead>
                    <tbody>
                    <cfloop query="userData">
                        <tr>
                        <th scope="row"><img src="./images/#userData.image#" width="80px" height="80px"></th>
                        <td>#userData.firstName# #userData.lastName#</td>
                        <td>
                            #userData.gender==1?"Male":"Female"#
                        </td>
                        <td>#userData.phone#</td>
                        <td>#userData.address#, #userData.street# </td>
                        <td>#userData.email#</td>
                        <td>#userData.dob#</td>
                        </tr>
                    </cfloop> 
                    </tbody>
                </table>
            </body>
        </html>
    </cfdocument>
    <cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
    <cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes">
</cfoutput>