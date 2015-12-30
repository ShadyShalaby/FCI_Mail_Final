<!DOCTYPE html>

<html>
    <head>
        <title>Search</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../js/myscripts.js"></script>
        <script src="../js/jquery-1.11.3.min.js"></script>


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
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <h4 class="text-warning">Search for related user E-mail</h4>
                    <form role="form" method="post" action="../../SearchServlet">
                        <div class="form-group">
                            <label for="searchText" class="text-warning" id="searchTextLabel">Enter Text </label>
                            <input type="text" id="searchText" value="" name="searchText" class="form-control" >
                            <br>
                            <input class="btn btn-lg btn-primary btn-block" type="submit" value="Search">
                        </div>
                    </form>

                    <script>
                        $("#searchType").change(function () {

                            if ($(this).val() == "Date") {
                                $("#searchFrom").show();
                                $("#searchTo").show();
                                $("#searchText").hide();
                                $("#searchFromLabel").show();
                                $("#searchToLabel").show();
                                $("#searchTextLabel").hide();
                            }
                            else {
                                $("#searchFrom").hide();
                                $("#searchTo").hide();
                                $("#searchText").show();
                                $("#searchFromLabel").hide();
                                $("#searchToLabel").hide();
                                $("#searchTextLabel").show();
                            }
                        });
                    </script>

                </div>

            </div>
            <div class="col-md-4"></div>
        </div>

    </div>

</body>
</html>
