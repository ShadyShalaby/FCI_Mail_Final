<%@page import="model.User"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Edit Profile Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/myscripts.js"></script>
        <script src="../js/jquery-1.11.3.min.js"></script>

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
            String updateResult = (String) session.getAttribute("updateResult");
            if (updateResult == null) {
                updateResult = "";
            }

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

            <div class="row">
                <div class="col-md-6">

                    <%                        if (updateResult.equals("Data is updated Successfully")) {
                            session.setAttribute("updateResult", null);
                    %>

                    <div class="alert alert-success fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Success!</strong> saved changes.
                    </div>


                    <%} else if (updateResult.equals("Incorrect Old password")) {
                        session.setAttribute("updateResult", null);
                    %>

                    <div class="alert alert-danger fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Incorrect!</strong> old password.
                    </div>

                    <%}%>

                    <form class="form-group" method="post"  name="updateUserData" action="../../UpdateDataServlet">
                        <h2 class="text-warning">Update personal data</h2>

                        <label for="inputName" class="text-muted">User Name </label>
                        <input type="text" id="inputName" name="name"  value="<%= user.getName()%>" class="form-control" required>

                        <input type="hidden"  id="inputpassword" name="password" value="<%= user.getPassword()%>" class="form-control" >

                        <label for="inputOldPassword" class="text-muted">Old Password </label> 
                        <input type="password"  id="inputOldPassword" name="oldPassword" class="form-control" required>

                        <label for="inputNewPassword" class="text-muted">New Password </label> 
                        <input type="password"  id="inputNewPassword" name="newPassword" class="form-control" required>


                        <input type="hidden" id="inputUserEmail" name="userEmail" value="<%= user.getUserEmail()%>" class="form-control" >


                        <label for="inputCountry" class="text-muted">Country </label> 
                        <input type="text" id="inputCountry" name="country" value="<%= user.getCountry()%>" class="form-control" >


                        <br>
                        <input id="update-btn" class="btn btn-lg btn-primary" 
                               value="Update Data" type="submit" onsubmit="return validateUpdateDataForm();">
                    </form>  


                </div>

                <div class="col-md-6">
                    <form class="form-group" method="post"   enctype="multipart/form-data" 
                          action="../../UpdateUserProfileServlet">
                        <h2 class="text-warning">Update Profile Picture</h2>
                        <input type="hidden" id="inputUserEmail" name="userEmail" value="<%= user.getUserEmail()%>" class="form-control" >
                        <label for="inputProfilePic" class="text-muted">Profile Picture</label> 
                        <input type="file" name="profilePic" id="inputProfilePic"  accept="image/*" class="form-control">
                        <br>
                        <input id="profile-btn" class="btn btn-lg btn-primary" value="Update Profile" type="submit">
                    </form>
                </div>
            </div>

        </div>

    </body>
</html>


