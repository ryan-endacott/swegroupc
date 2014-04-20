<?php
    if (($_SERVER['HTTPS']) != 'on')
	{
		$xxx = 'https://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		header("location: $xxx");
	}	
	//session_cache_limiter('private, must-revalidate');
	session_start();


?>



<?php
	$course_id=$_POST(course_id);
	$section_id=$_POST(section_id);
	$assignment_id=$_POST(asignment_id);
	$conn=pg_connect("host='localhost' dbname='dbname' user='user' password='password' port='port'") OR DIE ('Could not connect: ' . pg_last_error());
	array[]={$course_id,$section_id,$assignmet_id};
	$query="SELECT file_contents FROM swe.submission WHERE course_id=$1,section_id=$2,assignment_id=$3";
	pg_prepare($conn,'query',$query) OR DIE(pg_last_error());
	$result=pg_execute($conn,'query',array) OR DIE(pg_last_error());
    $fieldnum=pg_num_fields($result);
	$i=0;
	while ($line = pg_fetch_array($result, null)) {
		$filecontents[$i]=row['file_contents'];
		$i++;
	}
	
?>