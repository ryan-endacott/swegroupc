<?php
if (($_SERVER['HTTPS']) != 'on')
	{
		$abc = 'https://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		header("location: $abc");
	}	
?>

<?php
	/*
	session_start();
	if (isset($_SESSION['pawprint'])==false)
	{
		header("location: index.php");
	}
	else
	{
	*/
?>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Collect Assignments</title>
<style>
</style>
</head>
<body>

<form method="POST" action="  ">


<!--
For this part, the UI will first check what course does that 
TA has, and then, list all courses as the first select option 
-->
<select name="courses">
	<option value="" >Select Course</option>
	<?php  
	/*
	$query = 'SELECT course_id FROM swe.ta_course WHERE pawprint = $1';
	$stmt = pg_prepare($conn, "course", $query);
	$result_course = pg_execute($conn, "course", array($_SESSION['pawprint']));
	while (($line = pg_fetch_array($result_course, null, PGSQL_ASSOC)))
	foreach ($line as $course) 
	{
	?>
		<option value=" <?php  echo $course ?> " > <?php  echo $course ?> </option>
	<?php
	}
	*/
	?>
</select>

<!--
Then the TA could section which section needs to be collect
based on the course.
-->
<select name="section">
	<option value="" >Select Section</option>
	<?php  
	/*
	$query = 'SELECT section_id FROM swe.ta_section WHERE pawprint = $1';
	$stmt = pg_prepare($conn, "section", $query);
	$result_course = pg_execute($conn, "section", array($_SESSION['pawprint']));
	while (($line = pg_fetch_array($result_course, null, PGSQL_ASSOC)))
	foreach ($line as $section) 
	{
	?>
		<option value=" <?php  echo $section ?> " > <?php  echo $section ?> </option>
	<?php
	}
	*/
	?>
</select>

<!--collect-->
	<input type="submit" name="Collect" value="collect" />
</form>


</body>
</html>

<?php  
//} 
 ?>