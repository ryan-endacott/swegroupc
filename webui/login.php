<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
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
		<form class="form-signin" action='index.php' method='POST'>
        <div id="loginForm" class="container">
			<h2 class="form-signin-heading">Please sign in or Register!</h2>
			<input type="text" name="username" class="form-control" placeholder="Username" required autofocus>
			<input type="password" name="password" class="form-control" placeholder="Password" required>
			<button id="submitButton" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
			<br><a href='registration.php'>Click Here</a> to register.</br>
		</div>
		</form>
	</div>


</body>
</html>