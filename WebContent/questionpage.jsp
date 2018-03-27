<%@ include file="DBSetup.jsp"%>
<html>
<%
	String name = "";
	if (db.getActiveUser() == null || db.getActiveUser().length() == 0) {
		response.sendRedirect("index.jsp");
	}else{
		name = db.getUserName();
	}
	int question = 0;
	String choice = request.getParameter("sys");
	try {
        question = db.getLastQuestion();
		if (choice != null) {
			if ("sys1".equals(choice)){
	            db.chooseSystem1(question);
	            db.nextQuestion();
	        }
	        if ("sys2".equals(choice)){
	            db.chooseSystem2(question);
	            db.nextQuestion();
	        }
	        question = db.getLastQuestion();
		}
    }catch (Exception e){

    }
%>
<script>
    var lastQuestion = <%=question%>;
    console.log("lastq jsp: " + lastQuestion)
</script>
<head>
    <meta charset="UTF-8">
    <title>Question</title>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
    <link href="css/bootstrap.min.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="css/jquery-ui.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="css/style.css" media="screen" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
    <script src="js/panzoom.js" type="text/javascript"></script>
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/viewer.js" type="text/javascript"></script>
    <script src="js/app.js" type="text/javascript"></script>
    <script src="js/xtk.js" type="text/javascript"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/rainbow.js" type="text/javascript"></script>
    <script src="js/sylvester.js" type="text/javascript"></script>
    <script src="js/amplify.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/example.json"></script>
</head>
<body>
<div id="topMenu">
	<input type="hidden" id="lastQuestion" value="<%=question%>"/>
    <img id="logo" src="images/logo.png" height="45px">
    <ul id="nav">
    	<li> Welcome <%= name %></li>
        <li><a href="index.jsp">Logout</a></li>
    </ul>
</div>
<div id="main">
    <div class='container'>
        <h1>Start where you left off:</h1>
        <div class='row'>
            <div class='col-md-10 col-md-offset-1'>
                <div class='view' id='view_sagittal'>
                        <canvas height='220' id='sag_canvas' width='264'></canvas>
                        <!--<div class='slider nav-slider-horizontal' id='nav-xaxis'></div>-->
                    </div>
                    
                    <div class='view' id='view_coronal'>
                        <canvas height='220' id='cor_canvas' width='220'></canvas>
                        <!--<div class='slider nav-slider-vertical' id='nav-yaxis'></div>-->
                    </div>
                    <div class='view' id='view_axial'>
                        <canvas height='264' id='axial_canvas' width='220'></canvas>
                        <!--<div class='slider nav-slider-vertical' id='nav-zaxis'></div>-->
                    </div>
                <div id="data_panel">
                        <div class="data_display_row">
                            <div class="data_label">Coordinates:</div>
                            <div id="data_current_coords"></div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</div>
<div id="answers">
    <form id="answerForm" method="post">
        <div id="answer1">
            <h2>First Method words: </h2>
            <ol id="method1">
            </ol>
            <br/><br/>
            <input type="radio" name="sys" value="sys1"><b>Pick Method 1</b>
        </div>
        <div id="answer2">
            <h2>Second Method words:</h2>
            <ol id="method2">
            </ol>
            <br/><br/>
            <input type="radio" name="sys" value="sys2"><b>Pick Method 2</b>
            <button type="submit" class="btn btn-primary" id="btn" disabled="disabled">Next Question</button>
        </div>
    </form>
</div>

</body>
</html>
