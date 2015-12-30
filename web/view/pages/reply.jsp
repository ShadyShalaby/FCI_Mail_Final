<!DOCTYPE html>

<html>
    <head>
        <title>Reply</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    </head>
    <body>

        <div class="container">

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

            <div class="row">

                <form class="form-signUp" action="../../ReplyServlet" method="post">
                    <h2 class="form-signin-heading" style="color:DodgerBlue">Reply Email</h2>

                    <div>
                        <input type="hidden" name="basicID" value="<%=request.getParameter("basicID")%>">
                    </div>

                    <div>
                        <label style="color:DodgerBlue">From: </label><br>
                        <input type="text" name="sender" value="<%=request.getParameter("sender")%>" readonly>
                    </div>

                    <div>
                        <label style="color:DodgerBlue">To: </label><br>
                        <input type="text" name="reciever" value="<%=request.getParameter("reciever")%>" readonly>
                    </div>

                    <div>
                        <label style="color:DodgerBlue">Subject: </label><br>
                        <input type="text" name="subject" value="<%=request.getParameter("subject")%>" readonly>
                    </div>

                    <div>
                        <label style="color:DodgerBlue">Message: </label><br>
                        <textarea name="body" rows="10" cols="40"></textarea>
                    </div>
                    <br>
                    <button  type="submit">Reply</button>
                </form>  

                <div class="col-md-3"></div>
            </div>

        </div>
    </body>
</html>

