<%@ page import="db.DB" %>
<%! public final String DBName = "db";%>

<%
    DB db = (DB)(application.getAttribute(DBName));
    if (db==null){
        db = new DB();
        application.setAttribute(DBName, db);
    }
%>