<?php
// File for web service for LDAP Authentification


// Get API key so only our web server can access this endpoint.
// SWEGROUPC_API_KEY
include("../../secure/database.php");

if(!isset($_GET['username']) || !isset($_GET['password']) || !isset($_GET['api_key'])) {
  exit(json_encode(array("success" => false, "error" => "Incorrect parameters supplied.")));
}

if($_GET['api_key'] != SWEGROUPC_API_KEY) {
  exit(json_encode(array("success" => false, "error" => "Invalid API key.")));
}

if($response = authenticateToUMLDAP($_GET['username'], $_GET['password'])) {
  exit(json_encode(array(
    "success" => true,
    "error" => "Invalid API key.",
    "response" => $response)));
}
else {
  exit(json_encode(array("success" => false, "error" => "Invalid username or password.")));
}



/*
   Adapted from um_ldap and muauth

*/



/* ******************************************************************

 Params:
   $query_result - The LDAP search result
 Returns:
   An array of valid emails for the user....
****************************************************************** */

function get_email($query_result) {

    $possible_emails = array();
    $valid_emails = array();

    if (!empty($query_result[0]["mail"][0])) {

        $valid_emails[] = $query_result[0]["mail"][0];

    }

    if (is_array($query_result[0]["proxyaddresses"])) {

        foreach ($query_result[0]["proxyaddresses"] as $key=>$val) {

            if (is_numeric($key)) {

                $email = strtolower($val);

                if (substr($email, 0, 5) == "smtp:") {

                    $possible_emails[] = substr($email, 5);

                }
                else {
                    $possible_emails[] = $email;
                }
            }
        }
    }

    foreach ($possible_emails as $key=>$val) {

        if (is_valid_email($val) && !(in_array($val, $valid_emails))) {
            $valid_emails[] = $val;
        }
    }

    return $valid_emails;

}


/* ******************************************************************

 Params:
   $email - an purported email address
 Returns:
   True or False, as you would expect based on the function name
****************************************************************** */
function is_valid_email($email) {

    // eregi() is depricated > PHP 5.1
    // Ben B.

    return (!filter_var(trim($email), FILTER_VALIDATE_EMAIL));
}


/* ******************************************************************

 Params:
   $accountName - The SSO / Pawprint
   $credential - The password
   $ldapServer - LDAP Server, defaults to 'ldap.missouri.edu'
   $ldapPort - LDAP Port, defaults to 3268
   &$errorMsg - Output parameter to catch an error message
 Returns:
   FALSE on Error, else an array with with information.
****************************************************************** */
function authenticateToUMLDAP($accountName,$credential,
                              $ldapServer = 'ldap.missouri.edu',
                              $ldapPort = 3268, &$errorMsg = "",
                              $requireSecure = true){

    $error           = array();
    $query_result    = array();
    $attributes      = array("samaccountname", "proxyAddresses", "mail", "displayName");
    $formatted_result = array();

    $connection = ldap_connect($ldapServer, $ldapPort);

    if (! $connection ) {
   $errorMsg = "Failed to connect to $ldapServer:$ldapPort";
   return false;
    }

    if ( ! ldap_set_option($connection, LDAP_OPT_PROTOCOL_VERSION, 3) ){
   $errorMsg = "Failed to Set Protocol version 3";
   return false;
    }

    if ( ! ldap_set_option($connection, LDAP_OPT_REFERRALS, 0) ) {
   $errorMsg = "Failed to connect disable referrals from server";
   return false;
    }


    if ( ! ldap_start_tls($connection) && $requireSecure) {
   $errorMsg = "Unable to get a TLS connection, are you using the correct port?";
   return false;
    }

    // Try one until we connect
    $valid_domains = array("tig.mizzou.edu", "col.missouri.edu", "umsystem.umsystem.edu");
    foreach ($valid_domains as $domain){
        if ($bind_status = ldap_bind($connection,$accountName."@".$domain,$credential))
            break;
    }

    // A break above leaves $bind_status = true;

    if ($bind_status) {

        $ldapresults = ldap_search($connection, 'dc=edu', "(samaccountname=$accountName)", $attributes);

        if (!$ldapresults) {
      $errorMsg = "Failed to look up after bind";
      return false;
        }
        else {
      // THIS VALUE IS CHECK BELOW
            $result_count = ldap_count_entries($connection, $ldapresults);

            $query_result = ldap_get_entries($connection, $ldapresults);
            ldap_close($connection);
        }
    }
    /* LDAP Bind failed */
    else {

        ldap_close($connection);

   $errorMsg = "Failed to bind to ($connection) as: $username";
   return false;
    }


    if ($result_count == 0) {
        $formatted_result['result'] = '0';
        $formatted_result['message'] = 'Invalid Username or Password';
    }
    else {
        $formatted_result['result'] = $result_count;
        $formatted_result['user']['fullname'] = $query_result[0]["displayname"][0];
        $formatted_result['user']['username'] = $query_result[0]["samaccountname"][0];
        $formatted_result['user']['emails']   = get_email($query_result);
    }

    return $formatted_result;
}


?>

