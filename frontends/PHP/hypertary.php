<?php

// print(php_uname());
// print(php_logo_guid(	));

?>
<?
function rColor() {
	$rCArray = array("red", "blue", "green", "purple", "orange", "brown", "pink");
	echo $rCArray[rand(0,count($rCArray))];
}
?>
<pre><font color=<? rColor() ?>>
888    888                                    888
888    888                                    888
888    888                                    888
8888888888 888  888 88888b.   .d88b.  888d888 888888  8888b.  888d888 888  888
888    888 888  888 888 "88b d8P  Y8b 888P"   888        "88b 888P"   888  888
888    888 888  888 888  888 88888888 888     888    .d888888 888     888  888
888    888 Y88b 888 888 d88P Y8b.     888     Y88b.  888  888 888     Y88b 888
888    888  "Y88888 88888P"   "Y8888  888      "Y888 "Y888888 888      "Y88888
                888 888                                                    888
           Y8b d88P 888                                               Y8b d88P
            "Y88P"  888                                                "Y88P"
</font></pre>

<?
function pVariables() {
	?><pre>
	##########################################################################################
	## Variables #### Variables #### Variables #### Variables #### Variables #### Variables ##
	##########################################################################################
	</pre>
	<?
	//pVariables=true;
	if (isset($pVariables)){

		print("\$pheen_host=" . $pheen_host . "<br>");
		print("\$pheen_port=" . $pheen_port . "<br>");
		print("\$cjdns_path=" . $cjdns_path . "<br>");

	}

}

$pheen_host="localhost";
$pheen_port="8080";
$cjdns_path="/root/cjdns/";




function hype_list() {
	function pListservices() {
		?><pre>
	###############################################################################################
	## List Services #### List Services #### List Services #### List Services #### List Services ##
	###############################################################################################
		</pre><?
	}
	pListservices();

	global $pheen_port;
	global $pheen_host;

	$curl = curl_init();

	curl_setopt_array($curl, array(
		CURLOPT_RETURNTRANSFER 	=> 1,
		CURLOPT_PORT 		=> $pheen_port,
		CURLOPT_URL 		=> "http://". $pheen_host ."/services/"	,

	));

	$output = curl_exec($curl);
	$output = json_decode($output);

	// print("<b>Hypesite: " . $output->{'http://igel.bit'} . "</b> <br>");

	// var_dump($output);
	foreach ($output as $key => $value) {
		// $key = http://site.com
		print("key is $key <br>");
		// print("value is " . print_r($value) . "<br>");
		foreach ($value as $k => $v)
			print_r("k=" . $k . " | v=" . $v . "\n" );
	}

	// print_r($output);
	curl_close($curl);


}
function hype_add_form() {

	function pAddtohypertary() {
		?><pre>
	#############################################################################################
	## Add to Hypertary Services #### Add to Hypertary Services #### Add to Hypertary Services ##
	#############################################################################################
		</pre><?
	}
	pAddtohypertary();
	?>
	<form method="post">
	<table>
	<tr><td> Hypertary URL: 	</td><td><input type="text"   name="ht_surl_tbox"></td></tr>
	<tr><td> Hypertary Name: 	</td><td><input type="text"   name="ht_name_tbox"></td></tr>
	<tr><td> Hypertary Description: </td><td><input type="text"   name="ht_desc_tbox"></td></tr>
	<tr><td></td><td> <!--Submit--> <input type="submit" 	      name="ht-add_submit" value="Submit"></td></tr>
	</table>
	</form>


	<?
}
function hype_add_form_submit($array) {

	?><pre>
	##########################################################################################
	## Adding New Service ## Adding New Service ## Adding New Service ## Adding New Service ##
	##########################################################################################
	</pre><?

	print(json_encode($array));
	return(0);

	global $pheen_port;
	global $pheen_host;

	$curl = curl_init();

	$nsa=array( 	"url" 		=> "http://igel.bit",
			"name" 		=> "Igel Site",
			"description" 	=> "Neet Site",
	);


	curl_setopt_array($curl, array(
		CURLOPT_RETURNTRANSFER 	=> 1,
		CURLOPT_PORT 		=> $pheen_port,
		CURLOPT_URL 		=> "http://". $pheen_host ."/services/new",
		CURLOPT_POSTFIELDS 	=> json_encode($nsa),
		CURLOPT_POST 		=> true,
	));

	$output = curl_exec($curl);
	print_r($output);
	curl_close($curl);
}
function hype_testserv(){
	?>
	<pre>
	###############################################################################################
	## Test Services #### Test Services #### Test Services #### Test Services #### Test Services ##
	###############################################################################################
	</pre>
	<?
}
function hype_testserv_orig (){

	global $pheen_port;
	global $pheen_host;

	print "#################\n";
	print "# Test Services #\n";
	print "#################\n";

	$curl = curl_init();

	curl_setopt_array($curl, array(
		// CURLOPT_INTERFACE 	=> 'fca5:bfa9:2fee:faa9:c29b:76a0:24d8:c001',
		CURLOPT_RETURNTRANSFER 	=> 1,
		CURLOPT_PORT 		=> $pheen_port,
		CURLOPT_URL 		=> "http://". $pheen_host ."/services5/",
	));
	$output = curl_exec($curl);
	print_r($output);
	curl_close($curl);
}

?>

<?
// manual posts
if ($_POST) {
	// debug output $_POST values
	$postDebug=true;
	if ($postDebug == true) {
		?><pre>##################################################################</pre><?
		print("<h3>POSTED VARIABLES </h3>");
		foreach ($_POST as $key => $value)
			print($key . "=" . $value . "<br>");
		?><pre>##################################################################</pre><?
	}

	// cycle thru $_POST
	if (preg_match('/_submit$/', $key)) {
		list($htswitch, $htidk) = preg_split('(_)', $key, 2);
		$htswitch = (!isset($htswitch)) ? 'default' : $htswitch;

		// match _submit buttons
		switch ($htswitch) {
			case 'ht-add':

				// accepted values
				$htAddArray=array('ht_surl_tbox' => "",
						  'ht_name_tbox' => "",
						  'ht_desc_tbox' => "",
						);

				// intercept any null values for our accepted array
				foreach ($htAddArray as $key => $value){
					$htAddArray[$key] = ( (isset($_POST[$key])) ) ? $_POST[$key] : false ;

					// print error on manual posting nil value
					if ($htAddArray[$key] == false) {
						print("<b>Post Failed on: " . $htAddArray[$key] . "Missing/Null attempt.. </b><br>");
						break;
					}
				}

				// debug output
				$htDebug=false;
				if ($htDebug == true) {
					?> <br> <?
					foreach ($htAddArray as $key => $value)
						print("<b>HTADDARRAY: KEY = $key VALUE = $value </b><br>");
					?> <br> <?
				}

				// validate the posted fields
				$addError=array();
				// Hypertary URL:
				if(!filter_var($htAddArray['ht_surl_tbox'], FILTER_VALIDATE_URL))
					array_push($addError, "Hypertary URL: " . $htAddArray['ht_surl_tbox'] . " is not valid <br>");
				// Hypertary Name: 64 characters or less
				if (strlen(($htAddArray['ht_name_tbox'])) > 64)
					array_push($addError, "Hypertary Name: " . substr($htAddArray['ht_name_tbox'],0,64)
						. "... is over 64 characters <br>");

				// Hypertary Description: 512 characters or less
				if (strlen(($htAddArray['ht_desc_tbox'])) > 512)
					array_push($addError,"Hypertary Name: " . substr($htAddArray['ht_desc_tbox'],0,512)
						. "... is over 512 characters <br>");

				// break if errors reported
				if (count($addError)) {
					print("<b>" . count($addError) . " Errors found when adding: </b><br>");
					foreach ($addError as $key => $value)
						print("<font color=red>" . $value . "</font><br>");
					break;
				}


				// hand the array off to hypertary backend function
								// $htAddArray


				// {"http:\/\/cjdns.ca\/peers.txt":{
				// 	"name":"Peering requirements for cjdns peering.",
				// 	"description":"Clarification of peering requirements for cjdns and the hyperboria testnet.
				// 	Please read this entire document and check out the links within PRIOR to asking for a peer."
				// 	}
				// }


				hype_add_form_submit(array(
							$htAddArray['ht_surl_tbox'] => array(
								"name" => $htAddArray['ht_name_tbox'],
								"description" => $htAddArray['ht_desc_tbox'],
								)
							)
				);

				break;

			default:
				print("# hit the Hypertary Default Case ...");
				break;
		}
	}

}

?>

<html><body>

<? /* List of Services */ ?>
<? hype_list(); ?>


<? /* Add a service */ ?>
<? hype_add_form(); ?>


<? /* Test Services Function */ ?>
<? hype_testserv(); ?>

</body>
</html>