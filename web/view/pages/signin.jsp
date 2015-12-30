<!DOCTYPE html>

<html>
    <head>
        <title>sign in fci mail</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/myscripts.js"></script>

    </head>
    <body>

        <div class="container">

            <nav class="navbar">

                <div class="navbar-header">
                    <a class="navbar-brand bg-primary" href="#">FCI Mail</a>
                </div>
                <div>
                    <ul class="nav navbar-nav ">
                        <li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
                        <li><a href="../../index.html"> Home Page </a></li>
                    </ul>
                </div>

            </nav>

            <%
                String signinResult = "", userEmail = "", password = "";

                if ((String) session.getAttribute("signinResult") != null) {
                    signinResult = (String) session.getAttribute("signinResult");
                    userEmail = (String) session.getAttribute("userEmail");
                    password = (String) session.getAttribute("password");
                    session.invalidate();//delete it
                }

            %>


            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    
                    <% if( !signinResult.equals("") && signinResult != null){
                        %>
                    
                     <div class="alert alert-warning fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Incorrect!</strong> Email or Password. 
                    </div>
                    <br>
                    <%}%>
                    <form class="form-signin" id="signinForm" method="post" action="../../SignInServlet">
                        <h2 class="form-signin-heading">Please sign in</h2>
                        <label for="inputEmail" >Email address </label>
                        <input type="text" id="inputEmail" value="<%= userEmail%>" name="userEmail" class="form-control" required>
                        <label for="inputPassword">Password</label>
                        <input type="password" id="inputPassword" value="<%= password%>" class="form-control" name="password" required>
                        <input class="btn btn-lg btn-primary btn-block" type="submit" value="Sign in">
                    </form>  

                   
                </div>
                <div class="col-md-4"></div>
            </div>

        </div>

    </body>
</html>
