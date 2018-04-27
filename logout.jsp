<%
	String signinPage = "signin.jsp";
	if(session.getAttribute("authed") != null){
			session.removeAttribute("authed");
	}
	response.sendRedirect(signinPage);
%>