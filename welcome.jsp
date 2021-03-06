<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="UserManager.UserManager"%>
<%@page import="java.net.*"%>

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

<jsp:include page="jspSegments/welcomeHeader.jsp"/>

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
      
<jsp:include page="jspSegments/welcomeFooter.jsp"/>