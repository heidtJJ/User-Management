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
