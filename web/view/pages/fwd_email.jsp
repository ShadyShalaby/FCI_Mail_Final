<%-- 
    Document   : fwd_email
    Created on : Dec 28, 2015, 2:25:09 AM
    Author     : Sherif Diab
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="java.sql.Date"%>
<%@page import="model.Email"%>
<%@page import="model.DBAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forward Page</title>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/myscripts.js"></script>
        <script src="../js/jquery-1.11.3.min.js"></script>

        <script>
            function checkForm(form) {
                if (form.receiver.value == "") {
                    alert("please enter received email");
                    return false;

                }
                else if (form.subject.value == "") {
                    alert("please enter subject email");
                    return false;
                }
                else {
                    return true;

                }
            }
        </script>
    </head>
    <body>
        <%

            // validate session 
            User user = (User) session.getAttribute("user");
            if (user == null) {
        %>
        <jsp:forward page="signin.jsp" />
        <%
            }
        %>
        <%
            String sender = "";
            sender = session.getAttribute("userEmail").toString();
            String emailID = request.getParameter("id");
            int emID = Integer.parseInt(emailID);
            DBAccess database = new DBAccess();
            Email email = database.getEmail(emID);
            String subject = "Fwd: " + email.getSubject();
            String fwdMessage = "";


        %>

        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <img src="../images/cu.PNG" width="100" height="100">
                </div>
                <div class="col-md-6">
                    <br><br>
                    <nav class="navbar ">

                        <div class="navbar-header">
                            <a class="navbar-brand bg-primary" href="#">FCI CU Mail</a>
                        </div>
                        <div>
                            <ul class="nav navbar-nav">
                                <li><a href="new_email.jsp">Compose</a></li>
                                <li><a href="../../ArchiveServlet">Show Archive</a></li>
                                <li><a href="../../SentEmailServlet">Sent Email</a></li> 
                                <li><a href="../../InboxServlet">Inbox</a></li> 
                                <li><a href="search.jsp">Search</a></li>
                                <li><a href="editProfile.jsp">Edit profile</a></li> 
                                <li><a href="../../LogoutServlet">LogOut</a></li>
                            </ul>
                        </div>

                    </nav>
                </div>

                <div class="col-md-2">
                    <br><br><br>
                    <p class="text-success"> wellcome, <strong><%= user.getName()%></strong></p> 
                </div>

                <div class="col-md-2">
                    <img src="viewImage.jsp" class="img-circle" width="100" height="100">
                </div>
            </div>
            <%            // Check to be done
                fwdMessage += "From: " + email.getSender() + "\n" + "To:" + email.getReceiver() + "\n"
                        + "Subject: " + email.getSubject() + "\n" + "Date: " + email.getEmailDateTime() + "\nMessage: " + email.getBody() + "\n";

                ArrayList<Email> replies = email.getReplies();
                String repSender = "";
                String repRec = "";
                String repSubject = "";
                for (Email rep : replies) {
                    repSubject = rep.getSubject();
                    fwdMessage += "#######################" + "\n";

                    fwdMessage += "From: " + rep.getSender() + "\n" + "To:" + rep.getReceiver() + "\n"
                            + "Subject" + rep.getSubject() + "\n" + "Message: " + rep.getBody() + "\n";

                }
                // out.println(fwdMessage);
%>

            <div class="row">
                <div class="col-md-6">
                    <form name="fwd email form" method="post"  class="form-group" action="../../fwdEmailServlet" onsubmit="return checkForm(this)">
                        <div class="table-responsive">
                            <table  class="table">
                                <h3 class="text-warning bg-danger text-center"> Forward Email</h3>
                                <tr>
                                    <td>TO:</td>
                                    <td> <input type="text" class="form-control"  name="receiver" > </td>
                                </tr>

                                <tr>
                                    <td> Subject:</td>
                                    <td> <input type="text"  class="form-control" name="subject"  value="<%=subject%>" > </td>
                                </tr>


                                <tr>

                                    <td> Forwarded Message: </td>
                                    <td> <textarea name="fwdmsg" class="form-control" rows="20" cols="40" readonly><%=fwdMessage%></textarea> </td>
                                </tr>

                                <tr>

                                    <td> Message: </td>
                                    <td> <textarea name="msg" class="form-control" rows="20" cols="40"></textarea> </td>
                                </tr>
                                <tr> 
                                    <td> <input type="submit" class="btn btn-lg btn-primary" name="send_btn" value="Send" > </td>
                                </tr>
                            </table>
                        </div>


                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
