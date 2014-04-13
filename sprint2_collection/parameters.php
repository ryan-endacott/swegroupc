<?php
    $dbconn = pg_connect("host='localhost' dbname='dbname' user='user' password='password' port='port'") OR DIE ('Could not connect: ' . pg_last_error());
    $query = "SELECT file_contents
                FROM swe.submission
                WHERE id = " . $section_id;
    $result = pg_query($dbconn, $query);
    while($row = pg_fetch_array($result, null, PGSQL_ASSOC))
	{
        $escapeBytea = $row['file_contents'];
        $fileContents = pg_unescape_bytea($escapeBytea); 
        file_put_contents($fileName, $fileContents); 
	}
?>