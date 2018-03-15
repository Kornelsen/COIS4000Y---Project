<?php
$target_dir = "uploads/";
$tstamp = round(microtime(true));
$newfilename = $tstamp . '.pdf';
$target_file = $target_dir . $newfilename;
$result = 1;
$jobject = "tmp";
$error = "none";

if (isset($_POST["submit"])) {
    $check = mime_content_type($_FILES["fileToUpload"]["tmp_name"]);

    if ($check == "application/pdf") {
    	$result = 1;
        if (file_exists($target_file)) {
            $error = "Sorry, file already exists.\n";
            $result = 0;
        }
        else if ($_FILES["fileToUpload"]["size"] > 90000) {
            $error = "File is too large.\n";
            $result = 0;
        }

        if ($result == 1) {
            if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
                exec("/usr/bin/perl /var/www/html/TranscriptScan.pl $newfilename",$output);
                $jobject = "";
                foreach ($output as $value) {
                    $jobject = $jobject . $value;
                }
                unlink($target_file);
            } 
        }
    }
    else {
        $result = 0;
        $error = "Invalid filetype, PDFs only";
    }
}
sleep(1);
?>

<script language="javascript" type="text/javascript">
    var result = "<?php echo $result; ?>";
    var error = ("<?php echo $error; ?>");

    if (result == 1) {
        var c = <?php echo $jobject ?>;
        var d = JSON.stringify(c);
        localStorage.setItem("courses",d);
    }
    window.top.window.stopUpload(result, error);
</script>  
