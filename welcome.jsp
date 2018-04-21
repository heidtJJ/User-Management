<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="java.net.*"%>
<%@page import="UserManager.UserManager"%>

<%
	String signinPage = "signin.jsp";

	if(session.getAttribute("authed") != null){
		// Check to see if host has changed.
		if( !session.getAttribute("authed").equals(UserManager.getLocalAddress()) ){
			session.removeAttribute("authed");
  			response.sendRedirect(signinPage);
		}
	}
	else{
		// User is not authenticated yet
  		response.sendRedirect(signinPage);
	}
	
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Jared" >

    <title>Welcome!</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="vendor/simple-line-icons/css/simple-line-icons.css">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Muli" rel="stylesheet">

    <!-- Plugin CSS -->
    <link rel="stylesheet" href="device-mockups/device-mockups.min.css">

    <!-- Custom styles for this template -->
    <link href="css/new-age.min.css" rel="stylesheet">
  </head>
  <body id="page-top">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav" style="height=60%">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top"><h1>Welcome</h1></a>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="http://reach-new-heidts.com/my-website-connect.php">Contact</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <header class="masthead" style="height:91%">
      <div class="container h-100">
        <div class="row h-100">
          <div class="col-lg-7 my-auto">
            <div class="header-content mx-auto">
              <h1 class="mb-5">Welcome to the club <% out.print(session.getAttribute("email"));%>!</h1>
              <a href="logout.jsp" class="btn btn-outline btn-xl js-scroll-trigger"><strong>Click here to log out!</strong></a>
            </div>
          </div>
          </div>
        </div>
      </div>
    </header>
    <footer>
      <div class="container">
        <p>&copy; Jared Heidt 2018. All Rights Reserved.</p>
        <ul class="list-inline">
          <li class="list-inline-item">
            <a href="#">Privacy</a>
          </li>
          <li class="list-inline-item">
            <a href="#">Terms</a>
          </li>
          <li class="list-inline-item">
            <a href="#">FAQ</a>
          </li>
        </ul>
      </div>
    </footer>
  </body>
</html>