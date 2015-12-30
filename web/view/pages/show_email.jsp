<%-- 
    Document   : show-email
    Created on : Dec 26, 2015, 1:30:11 PM
    Author     : Shady
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Email"%>
<%@page import="model.Email"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Email</title>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/myscripts.js"></script>
        <script src="../js/jquery-1.11.3.min.js"></script>
    </head>
    <body>


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
                    <img src="viewImage.jsp" class="img-circle" width="100" height="100">
                </div>
                <div class="col-md-2"></div>
            </div>
            <%
                // Check to be done
                User user = (User) session.getAttribute("user");
                Email email = (Email) session.getAttribute("showEmail");
            %>

            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <%
                            out.print("<table class='table'>");
                            out.print("<tr> <td>From</td> <td>" + email.getSender() + "</td> </tr>");
                            out.print("<tr> <td>To</td> <td>" + email.getReceiver() + "</td> </tr>");
                            out.print("<tr> <td>Subject</td> <td>" + email.getSubject() + "</td> </tr>");
                            out.print("<tr> <td>Message</td> <td>" + email.getBody() + "</td> </tr>");
                            out.print("</table>");
                        %>
                    </div> </div></div>
            <div class="row">
                <div class="col-md-12">
                    <%
                        out.print("<br>");

                        ArrayList<Email> replies = email.getReplies();
                        String repSender = "";
                        String repRec = "";
                        String repSubject = "";
                        for (Email rep : replies) {
                            repSubject = rep.getSubject();
                    %>



                    <div class="table-responsive">
                        <%
                                out.print("<table class='table'>");
                                out.print("<tr> <td>From</td> <td>" + rep.getSender() + "</td> </tr>");
                                out.print("<tr> <td>To</td> <td>" + rep.getReceiver() + "</td> </tr>");
                                out.print("<tr> <td>Subject</td> <td>" + rep.getSubject() + "</td> </tr>");
                                out.print("<tr> <td>Message</td> <td>" + rep.getBody() + "</td> </tr>");
                                out.print("<br>");
                            }
                            out.print("</table>");
                        %></div> </div></div><%
                            repSender = user.getUserEmail();
                            if (email.getSender().equals(repSender)) {
                                repRec = email.getReceiver();
                            } else {
                                repRec = email.getSender();
                            }
                            if (repSubject.equals("")) {
                                repSubject = "Re: " + email.getSubject();
                            }
                        %>

            <div class="row">
                <div class="col-md-2">
                    <form action="reply.jsp" method="post" class="form-group">
                        <input type="hidden" name="basicID" value="<%=email.getEmailID()%>">
                        <input type="hidden" name="sender" value="<%=repSender%>">
                        <input type="hidden" name="reciever" value="<%=repRec%>">
                        <input type="hidden" name="subject" value="<%=repSubject%>">
                        <input type="submit" name="submit" class="btn btn-lg btn-primary" value="Reply">
                    </form>
                </div>
                <!-- For Shrioo -->
                <div class="col-md-2">
                    <form action="fwd_email.jsp" method="post">
                        <input type="hidden" name="id" value="<%=email.getEmailID()%>">
                        <input type="submit" name="submit" class="btn btn-lg btn-primary" value="Forword">
                    </form>
                </div>
                <div class="col-md-8"></div>
            </div>

        </div>

    </body>
</html>
