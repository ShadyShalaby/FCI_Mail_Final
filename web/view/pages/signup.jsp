<!DOCTYPE html>

<html>
    <head>
        <title>Sign Up Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/myscripts.js"></script>

    </head>
    <body>

        <script>
            function isEmail(email) {
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                return regex.test(email);
            }
            function sendajax() {

                var email = document.getElementById("inputUserEmail").value;
                var xmlhttp = new XMLHttpRequest();

                xmlhttp.open("GET", "../../checkEmailExistence?email=" + email, true);
                xmlhttp.send();
                var serverResponse = "";
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        serverResponse = xmlhttp.responseText;
                        if (serverResponse == "OK")
                        {
                            if (!isEmail(email))
                            {
                                alert("Not a valid e-mail address format.");
                                return false;
                            }
                            return true;

                        }
                        else
                        {
                            alert("Email is already taken. please choose different one.");
                            return false;
                        }

                    }
                    return false;
                }

            }
        </script>


        <div class="container">

            <nav class="navbar ">

                <div class="navbar-header">
                    <a class="navbar-brand bg-primary" href="#">FCI Mail</a>
                </div>
                <div>
                    <ul class="nav navbar-nav">
                        <li><a href="signin.jsp"><span class="glyphicon glyphicon-log-in"></span> Sign in </a></li>
                        <li><a href="../../index.html"> Home Page </a></li>
                    </ul>
                </div>

            </nav>

            <%
                String signupResult = "", userEmail = "", country = " ", name = " ";

                if ((String) session.getAttribute("signupResult") != null) {
                    signupResult = (String) session.getAttribute("signupResult");
                    userEmail = (String) session.getAttribute("userEmail");
                    country = (String) session.getAttribute("country");
                    name = (String) session.getAttribute("name");
                    session.invalidate();//delete it
                }

            %>

            <div class="row">
                <div class="col-md-6">
                    <form class="form-group" method="post"   enctype="multipart/form-data"  action="../../SignUpServlet" 
                          onsubmit="return sendajax()">
                        <h2 class="text-warning">Please sign up</h2>

                        <label for="inputName" class="text-muted">User Name </label>
                        <input type="text" id="inputName" name="name"  value="<%= name%>" class="form-control" required>


                        <label for="inputPassword" class="text-muted">Password </label> 
                        <input type="password"  id="inputpassword" name="password" class="form-control" required>


                        <label for="inputUserEmail" class="text-muted">E-mail </label> 
                        <input type="text"id="inputUserEmail" name="userEmail" value="<%= userEmail%>" class="form-control"  required>


                        <label for="inputCountry" class="text-muted">Country </label> 
                        <input type="text" id="inputCountry" name="country" value="<%= country%>" class="form-control" >


                        <label for="inputProfilePic" class="text-muted">Profile Picture</label> 
                        <input type="file" name="profilePic" id="inputProfilePic"  accept="image/*" class="form-control">


                        <br>
                        <input id="signup-btn" class="btn btn-lg btn-primary" value="Sign up" type="submit">
                    </form>  

                    <% if (!signupResult.equals("") && signupResult != null) {
                    %>

                    <div class="alert alert-danger fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Sorry,</strong> this e-mail is exist.
                    </div>

                    <%}%>

                </div>
                <div class="col-md-6"></div>
            </div>

        </div>

    </body>
</html>


