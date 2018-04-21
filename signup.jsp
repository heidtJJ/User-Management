<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="UserManager.UserManager"%>

<%
	String welcomePage = "welcome.jsp";

	// Check if user is already authenticated.
	if(session.getAttribute("authed") != null){
		// Check to see if host has changed.
		if( session.getAttribute("authed").equals( UserManager.getLocalAddress() ) ){
  			response.sendRedirect(welcomePage);// redirect the user to signed in page
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
			e.printStackTrace();
		}
		
	}	
%>	

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Sign Up</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
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
					<div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<input class="input100" type="text" name="email" placeholder="Email">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<input class="input100" type="password" name="password" placeholder="Password">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>
					
					<div id="password-retry" class="wrap-input100 validate-input"  data-validate="Password-Retry is required">
						<input class="input100" type="password" name="passwordRepeat" placeholder="Re-enter Password">
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
	
	

	
<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/tilt/tilt.jquery.min.js"></script>
	<script type="text/javascript">
		$('.js-tilt').tilt({
			scale: 1.1
		})
		
		function isOkPass(p){
			var anUpperCase = /[A-Z]/;			
			var aLowerCase = /[a-z]/; 
			var aNumber = /[0-9]/;
			var aSpecial = /[!|@|#|$|%|^|&|*|(|)|-|_]/;
			var obj = {};
			obj.result = true;
	
			if(p.length < 8){
				obj.result=false;
				obj.error="The password is not long enough!"
				return obj;
			}

			var numUpper = 0;
			var numLower = 0;
			var numNums = 0;
			var numSpecials = 0;
			for(var i=0; i<p.length; i++){
				if(anUpperCase.test(p[i]))      
					numUpper++;
				else if(aLowerCase.test(p[i]))
					numLower++;
				else if(aNumber.test(p[i]))	
					numNums++;
				else if(aSpecial.test(p[i]))	
					numSpecials++;
			}
	
			if(numUpper < 1 || numLower < 1 || numNums < 1 || numSpecials <1){
				obj.result=false;
				obj.error="Password must contain at least 1 uppercase character, lowercase character, number, AND special character!";
				return obj;
			}
			return obj;
		}
		
		
		$(".login100-form").submit(function( event ) {
  			var password = $('[name="password"]').val();
  			var passwordRepeat = $('[name="passwordRepeat"]').val();
			var errorMessage = "";  			
  			
  			// Error Checking
  			if(password != passwordRepeat){
				errorMessage += "The passwords which you entered are different!<br>";
  			}
  			
  			if(errorMessage == "" && password != ""){
  				var goodPass = isOkPass(password);
  				if(goodPass.result == false){
					 errorMessage += errorMessage + goodPass.error + "<br>";	
  				}
			}

			// Handle Errors
			if(errorMessage == ""){
				$('.alert').hide();
  			}
  			else{
  				event.preventDefault();
  				$('.alert').show();
  				errorMessage = "<strong>Oh snap!</strong> " + errorMessage;
				$('.alert').html(errorMessage);  			
  			}
		});		
		
	</script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>