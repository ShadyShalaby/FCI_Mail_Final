
<%@page import="java.util.ArrayList"%>
<%@page import="model.Email"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>
        <title>Home Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/inboxScript.js"></script>

    </head>
    <body>

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
        <h1></h1>
        <div class="container-fluid">
            <div class="row">

                <div class="col-sm-9 col-md-10">




                </div>
            </div>
            <hr>
            <div class="row">


                <!--main-->
                <div class="col-sm-9 col-md-10">
                    <!-- tabs -->

                    <!-- tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="inbox">
                            <table class="table table-striped table-hover">
                                <tbody>
                                    <!-- inbox header -->
                                    <tr>
                                        <td>
                                            <label>

                                                <input type="checkbox"   id="selectAll"  title="select all">
                                            </label>
                                        </td> 
                                        <td>
                                            <button class="btn btn-default" title="delete selected" ><i class="glyphicon glyphicon-trash"></i></button>
                                            <button class="btn btn-default" title="Archive selected" ><i class="glyphicon glyphicon-folder-open"></i></button>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <%
                                        ArrayList<Email> emails = new ArrayList<Email>();
                                        User user = (User) request.getSession().getAttribute("user");
                                        emails = (ArrayList<Email>) request.getSession().getAttribute("searchResults");

                                        for (int i = 0; i < emails.size(); i++) {

                                    %>
                                    <tr>
                                        <td>

                                            <label>
                                                <form action="../../ShowEmailServlet">
                                                    <input type="checkbox"  class="all">
                                                    <input type="hidden" name="id" value="<%out.print(emails.get(i).getEmailID());%>"/>

                                                    <input type="submit" value="Show"/>
                                                </form>
                                            </label> <span class="name"><% out.print(emails.get(i).getSender()); %></span></td>
                                        <td><span class="subject"><% out.print(emails.get(i).getSubject()); %></span> 
                                            <small class="text-muted"><%
                                                String body = emails.get(i).getBody();
                                                int bodyLen = emails.get(i).getBody().length();
                                                if (bodyLen < 25) {
                                                    out.print(body);
                                                } else {
                                                    out.print(body.substring(0, 24) + "...");
                                                }
                                                %></small></td>
                                        <td><span class="badge"><% out.print(emails.get(i).getEmailDateTime()); %></span> </td>
                                    </tr>

                                    <%
                                        }

                                    %>

                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade in" id="profile">
                            <div class="list-group">
                                <div class="list-group-item">
                                    <span class="text-center">This tab folder is empty.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-md-12">

                        <div class="well text-right">
                            <small>Last updated: 4/14/2015: 3:02 PM</small>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
