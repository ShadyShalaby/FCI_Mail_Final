<%-- 
    Document   : viewImage
    Created on : Dec 28, 2015, 4:07:36 PM
    Author     : sabry_ragab
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Image Page</title>
    </head>
    <body>

        <%
            try {

                 InputStream myImage = (InputStream) session.getAttribute("myImage");
                if (myImage != null) {
                   
                    // get the image from the database
                    byte[] imgData = IOUtils.toByteArray(myImage);
                     out.print(imgData);
                    // display the image
                    response.setContentType("image/jpg");
                    OutputStream o = response.getOutputStream();
                    o.write(imgData);
                    o.flush();
                    o.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        %> 
    </body>
</html>
