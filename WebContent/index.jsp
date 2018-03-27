<%@ page import="java.sql.ResultSet" %>
<%@ include file="DBSetup.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login</title>
<link href="css/bootstrap.min.css" media="screen" rel="stylesheet" type="text/css" />
<link href="css/jquery-ui.css" media="screen" rel="stylesheet" type="text/css" />
<link href="css/style.css" media="screen" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<jsp:useBean id="user" class="bean.User" scope="page"/>
<jsp:setProperty name="user" property="*"/>
<%
	if (db.getActiveUser() != null && db.getActiveUser().length() > 0) {
		db.resetActiveUser();
	}
  String message = "";
  if (request.getParameter("login")!=null){
    try {
      ResultSet rs = db.getUser(user.getId(),user.getPass());
      while (rs.next()){
        String type = rs.getString(5);
        if (type.equals("Doctor")){
          response.sendRedirect("questionpage.jsp");
        }
        if (type.equals("Analyst")){
          response.sendRedirect("analystpage.jsp");
        }
        message = "Unexpected Error";
      }
    }catch (Exception e){
      message = "<b>Invalid Login. Please check your username and password</b>" ;
    }
  }
%>
<body>
<div id="main">
  <form id="loginForm" method="post">
    <img src="images/logo.png" width="200px">
    <h2>Login</h2>

    <div id="loginText">
      Please enter your provided login:<br/>
    </div>

    <label for="id"><b>ID:</b></label><br/>
    <input type="text" id="id" name="id" placeholder="Enter ID" required/><br/>

    <label for="pass"><b>Password:</b></label><br/>
    <input type="password" id="pass" name="pass" placeholder="Enter Password" required/><br/>

    <div id="centerButton">
      <input type="submit" name="login" value="Login" />
    </div>
  </form>
  <p>
    <%=message%>
  </p>
</div>
</body>
</html>
