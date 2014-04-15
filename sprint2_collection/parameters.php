<?php
    $dbconn = pg_connect("host='localhost' dbname='dbname' user='user' password='password' port='port'") OR DIE ('Could not connect: ' . pg_last_error());
    $query = 'SELECT file_contents
                FROM swe.submission
                WHERE id = $1';
	$stmt = pg_prepare($conn, "parameters", $query);
	$result = pg_execute($conn, "parameters", array($section_id));
	
    while($row = pg_fetch_array($result, null, PGSQL_ASSOC))
	{
        $escapeBytea = $row['file_contents'];
        $fileContents = pg_unescape_bytea($escapeBytea); 
        file_put_contents($fileName, $fileContents); 
	}
?>