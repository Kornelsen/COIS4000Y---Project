<?php
$target_dir = "uploads/";
$tstamp = round(microtime(true));
$newfilename = $tstamp . '.pdf';
$target_file = $target_dir . $newfilename;
$result = 1;
$jobject = "";

if (isset($_POST["submit"])) {
    $check = mime_content_type($_FILES["fileToUpload"]["tmp_name"]);

    if ($check == "application/pdf") {
    	$result = 1;
    }
    else {
    	$result = 0;
    }
    if (file_exists($target_file)) {
    	echo "Sorry, file already exists.\n";
    	$result = 0;
	}
	if ($_FILES["fileToUpload"]["size"] > 90000) {
    	echo "File is too large.\n";
    	$result = 0;
	}

	if ($result == 0) {
    	echo "Sorry, your file was not uploaded.\n";
	} else {
    	if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        	exec("/usr/bin/perl /var/www/html/TranscriptScan.pl $newfilename",$output);
        	foreach ($output as $value) {
                $jobject = $jobject . $value;
        	}
    	} else {
        	echo "File upload failed.\n";
    	}
	}
}
sleep(1);
?>

<script language="javascript" type="text/javascript">
    var result = "<?php echo $up_status; ?>";

    if (result == "success") {
        var c = <?php echo $jobject ?>;
        var d = JSON.stringify(c);
        localStorage.setItem("courses",d);
    }
    window.top.window.stopUpload(<?php echo $result; ?>);
    </script>  
