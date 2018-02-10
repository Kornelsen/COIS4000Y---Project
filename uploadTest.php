<!DOCTYPE html>
<html>
<head>
    <title> Transcript Uplaod </title>
    <link rel="shortcut icon" type="image/x-icon" href="img/4000logo.png" />

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>

<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>

<script> 
    function startUpload() {
        document.getElementById('uploadProcess').style.visibility='visible';
        return true;
    }

    function stopUpload(success){
        var result = '';
        if (success == 1){
            document.getElementById('result').innerHTML = '<span class="msg">Transcript upload successful<\/span>';
            document.getElementById("loading").src="img/success.png";
        }
        else {
           document.getElementById('result').innerHTML = '<span class="errmsg">Error during transcript uplaod<\/span>';
        }
        //document.getElementById('loading').style.visibility = 'hidden';
        var x = getCookie('courses');
        complete = JSON.parse(x);
        return true;
    }

    function getCookie(name){
        var re = new RegExp(name + "=([^;]+)");
        var value = re.exec(document.cookie);
        return (value != null) ? unescape(value[1]) : null;
    }
</script>
<body>

<div class="starter-template">
    <img src="img/4000logo.png" width="72" height="72" alt="logo">
    <h1>Transcript Upload Test</h1>
    <form action="upload.php" method="post" enctype="multipart/form-data" class="bg-light" target="uploadTarget" onsubmit="startUpload();">
    Select pdf to upload:
    <input type="file" name="fileToUpload" id="fileToUpload"> <br> <br>
    <input type="submit" value="Upload PDF" name="submit">
    </form>
    <iframe id="uploadTarget" name="uploadTarget" src="#" style="width:0;height:0;border:0px solid #fff;">
    </iframe>
</div>


<div class="col-centered">
    <p id="uploadProcess"><img id="loading" src="img/loader.gif" alt="loading animation" /></p>
    <p id="result"> </p>
</div>


</body>

</html>
