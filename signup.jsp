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
	boolean userExists = false;
	
	String userEmail = request.getParameter("email");
	String userPassword = request.getParameter("password");
	String userPassRepeat = request.getParameter("passwordRepeat");

	if(userEmail != null && userPassword != null && userPassRepeat != null){
	
		formSubmitted = true;
		try {
			userExists = UserManager.existsInTable(userEmail);	
		} catch (Exception e) {
			out.println(e);	
			out.println("Cannot connect to database.");	
			e.printStackTrace();
		}
		
	}	
%>	

<jsp:include page="jspSegments/signUpHeader.jsp"/>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="images/img-01.png" alt="IMG">
				</div>

				<form class="login100-form validate-form" method="POST">
					
					<span class="login100-form-title">
						Create Your Account
					</span>
<%
	if(!formSubmitted){
%>					
					<div class="alert alert-danger" role="alert" style="display:none">
						<strong>Oh snap!</strong> Change a few things up and try submitting again.
					</div>									
<%
	}
	else{	
		if(userExists){	
%>
				<div class="alert alert-danger" role="alert">
					<strong>Oh snap!</strong> This email is already taken!
				</div>	
<%	
		}
		else{
			boolean success = UserManager.insertIntoTable(userEmail, userPassword);		
		
			if(success){
				// create session var and redirect
				session.setAttribute( "authed", UserManager.getLocalAddress() );
				session.setAttribute( "email", userEmail );// only used for welcoming the user
  				response.sendRedirect(welcomePage);
  			}
  			else{
%>
				<div class="alert alert-danger" role="alert">
					<strong>Oh snap!</strong> Could not insert you into our database!
				</div>	
<%	
  			}

		}
	}
%>
					<div class="wrap-input100 validate-input" data-validate="Valid email is required: ex@abc.xyz">
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
					
					<div id="password-retry" class="wrap-input100 validate-input" data-validate="Password-Retry is required">
						<input class="input100" type="password" name="passwordRepeat" placeholder="Re-enter Password" value=<% out.print(userPassRepeat == null ? "" : userPassRepeat); %> >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Sign Up
						</button>
					</div>

				
					<div class="text-center p-t-136">
						<a class="txt2" href="signin.jsp">
							Login to Your Account
							<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	
<jsp:include page="jspSegments/signUpFooter.jsp"/>