<!DOCTYPE html>
<html>
<head>
	<title></title>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
		<!-- Latest compiled and minified JavaScript -->
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<style>
	div.form-group{
	width: 300px;
	height: 200px;
	text-align: center;
	background-color: rgba(255, 255, 255, 0.8);
	border-radius: 25px;
	margin: auto;
	}
	</style>
</head>
<body>
<form id="uploadthing" role="form">
	<div class="form-group">
		<label for="exampleInputFile">File input</label>
		<input type="file" id="exampleInputFile" multiple>
		<p class="help-block">Submit your assignment here!</p>
		<button type="submit" class="btn btn-default">Submit</button>
	</div>  
</form>  
</body>
</html>