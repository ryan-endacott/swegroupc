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


<?php

/* creates a compressed zip file */
function create_zip($files = array(),$destination = '',$overwrite = false) 
{
	//if the zip file already exists and overwrite is false, return false
	if(file_exists($destination) && !$overwrite) 
	{ 
		return false; 
	}
	//vars
	$valid_files = array();
	//if files were passed in...
	if(is_array($files)) 
	{
		//cycle through each file
		foreach($files as $file) 
		{
			//make sure the file exists
			if(file_exists($file)) 
			{
				$valid_files[] = $file;
			}
		}
	}
	//if we have needed files
	if(count($valid_files)) 
	{
		//create the archive
		$zip = new ZipArchive();
		$zipname = 'download.zip';
		
		//if($zip->open($destination,$overwrite ? ZIPARCHIVE::OVERWRITE : ZIPARCHIVE::CREATE) !== true) 
		//{
		//	return false;
		//}
		//add the files
		
		$zip->open($zipname, ZipArchive::CREATE);
		foreach($valid_files as $file) 
		{
			$zip->addFile($file,$file);
		}
		
		//try
		//echo 'The zip archive contains ',$zip->numFiles,' files with a status of ',$zip->status;
		
		//close the zip
		$zip->close();
		
		//stream it
		header('Content-Type: application/zip');
		header('Content-disposition: attachment; filename=filename.zip');
		header('Content-Length: ' . filesize($zipfilename));
		readfile($zipname);
		//check to make sure the file exists
		return file_exists($destination);
	}
	else
	{
		return false;
	}
}
?>