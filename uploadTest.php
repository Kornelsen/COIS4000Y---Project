<!DOCTYPE html>
<html>
<head>
    <title> Transcript Uplaod </title>
    <link rel="shortcut icon" type="image/x-icon" href="img/4000logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
            window.location="/ReportTest.html";
        }
        else {
           document.getElementById('result').innerHTML = '<span class="errmsg">Error during transcript uplaod<\/span>';
        }
        //document.getElementById('loading').style.visibility = 'hidden';
        var x = getCookie('courses');
        complete = JSON.parse(x);
        return true;
    }

</script>
<body>

 <nav class="navbar navbar-toggleable-md navbar-light bg-faded">
  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <a class="navbar-brand" href="#"><img src="img/logosmall.png"></a> 

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
  </div>
</nav>

<div class="conatiner upload-box bg-light">
    <form action="upload.php" method="post" enctype="multipart/form-data" target="uploadTarget" onsubmit="startUpload();">
    Select pdf to upload: <br>
    <label class="btn btn-default btn-file">
    <input type="file" name="fileToUpload" id="fileToUpload">
    </label>
    <br> <br>
    <input class="btn btn-primary" type="submit" value="Upload PDF" name="submit" id="submitbtn">
    </form>
    <iframe id="uploadTarget" name="uploadTarget" src="#" style="width:0;height:0;border:0px solid #fff;">
    </iframe>
</div>

<div class="container progress-box">
    <p id="uploadProcess"><img id="loading" src="img/loader.gif" alt="loading animation" /></p>
     <p id="result"> </p>
</div>


</body>

</html>
