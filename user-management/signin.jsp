<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="UserManager.UserManager"%>

<%
	String welcomePage = "welcome.jsp";

	// Check if user is already authenticated.
	if(session.getAttribute("authed") != null){
		
		// Check to see if host has changed.
		if( session.getAttribute("authed").equals( UserManager.getLocalAddress() ) ){
  			response.sendRedirect(welcomePage);// redirect the user to welcome page
		}
		else{
			session.removeAttribute("authed");// remove the invalid authenticated variable
		}

	}
	
	boolean formSubmitted = false;
	boolean authenticated = false;
	
	String userEmail = request.getParameter("email");
	String userPassword = request.getParameter("password");

	if(userEmail != null && userPassword != null){
	
		formSubmitted = true;
		try {
			authenticated = UserManager.authenticateUser(userEmail, userPassword);
		} catch (Exception e) {
			out.println(e);	
			e.printStackTrace();
		}
		
	}	
%>	

<jsp:include page="jspSegments/signInHeader.jsp"/>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="images/img-01.png" alt="IMG">
				</div>

				<form class="login100-form validate-form" method="POST">
					<span class="login100-form-title">
						Member Login
					</span>
<%
	if(formSubmitted){
		if(authenticated){	
				// create session var and redirect
				session.setAttribute( "authed", UserManager.getLocalAddress() );
				session.setAttribute( "email", userEmail );// only used for welcoming the user
  				response.sendRedirect(welcomePage);
		}
		else{
%>
				<div class="alert alert-danger" role="alert">
					<strong>Oh snap!</strong> The email and/or password which you entered does not match our records!
				</div>	
<%	
		}
	}
%>
					<div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<input class="input100" type="text" name="email" placeholder="Email" value=<% out.print(userEmail == null ? "" : userEmail); %> >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<input class="input100" type="password" name="password" placeholder="Password" value=<% out.print(userPassword == null ? "" : userPassword); %> >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Login
						</button>
					</div>

				
					<div class="text-center p-t-136">
						<a class="txt2" href="signup.jsp">
							Create Your Account
							<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

<jsp:include page="jspSegments/signInFooter.jsp"/>