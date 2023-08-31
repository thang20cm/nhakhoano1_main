<?php 
include ("dbconnection.php");
$con= dbconnection();

if(isset($_POST["name"]))
{
    $name=$_POST["name"];
}
else return;
if(isset($_POST["email"]))
{
    $email=$_POST["email"];
}
else return;
if(isset($_POST["password"]))
{
    $password=$_POST["password"];
}
else return;

$query="INSERT INTO `user`( `uname`, `uemail`, `upassword`) VALUES ('$name','$email','$password')";
$exe = mysqli_query($con,$query);

$arr=[];
if($exe){
    $arr["Success"]="true";
}
else{
    $arr["Success"]="false";
}
print(json_encode ($arr));
?>