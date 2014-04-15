<!DOCTYPE html>
<html>
<head>
	<title>Logout</title>
		<!-- Latest compiled and minified CSS -->
		<!--<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">-->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<!--<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>-->
		<script src="https://code.jquery.com/jquery.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>

	<style>
	div .container .registration{
		width: 350px;
		height: 250px;
		position:absolute;
		top:25%;
		left:50%;
		margin-top:-100px;  
		margin-left:-150px;
		/*background-color: rgba(255, 0, 0, .8);*/
		border-radius: 30px;
	}
	
	div.registration{
		width:50%;
		margin: 0 auto;
	}
	
	div#loginForm{
	width: 300px;
	height: 200px;
	text-align: center;
	background-color: rgba(255, 255, 255, 0.8);
	border-radius: 25px;
	}
		
	button#submitButton{
		background-color: rgb(75, 75, 75);
	}
		
	.bold{
		text-align: center;
		font-weight: bold;		
		text-decoration: underline;	
	}
		
	div.modal-header{
		text-align: center;
	}
		
	li{
		cursor: pointer;
	}
	</style>
</head>
<body>
	<div class="container">
		<form class="form-logout" action='logout.php' method='POST'>
        <div id="loginForm" class="container">
			<h2 class="form-signin-heading">Are you sure you want to log out?</h2>
			<input name="logout" class="form-control" type="submit"/>
		</div>
		</form>
	</div>


</body>
</html>