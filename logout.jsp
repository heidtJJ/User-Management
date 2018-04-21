<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String signinPage = "signin.jsp";
	if(session.getAttribute("authed") != null){
			session.removeAttribute("authed");
	}
	response.sendRedirect(signinPage);
%>