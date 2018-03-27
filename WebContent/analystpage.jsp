<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.util.*"%>
<%@ page import ="bean.*" %>
<%@ include file="DBSetup.jsp"%>
<html>

<%
String name = "";

	if (db.getActiveUser() == null || db.getActiveUser().length() == 0) {
		response.sendRedirect("index.jsp");
	}else{
		name = db.getUserName();
	}
	List<Question> questions = db.getQuestions();
	
%>

<head>
    <meta charset="UTF-8">
    <title>Data Analyst Hub</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body>
<div id="topMenu">
    <img id="logo" src="images/logo.png" height="45px">
    <ul id="nav">
    	<li> Welcome <%= name %></li>
        <li><a href="index.jsp">Logout</a></li>
    </ul>
</div>

   <div id="container-analyst">
    <table>
    <h2>Results</h2>
    <tr>

    <th> Question number</th>
    <th>System a </th>
    <th>System b</th>
    </tr>
    <%
    for(Question q : questions) { %>
    	<tr>
    	<td><%=q.getId()+1 %></td>
    	<td><%=q.getSystema() %></td>
    	<td><%=q.getSystemb() %></td>
    	</tr>
    <% }%>
	 
    </table>
    </div>
</body>
</html>
