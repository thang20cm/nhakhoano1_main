<?php 
include ("dbconnection.php");
$con= dbconnection();



if(isset($_POST["idPhieuvatlieu"]))
{
    $idPhieuvatlieu=$_POST["idPhieuvatlieu"];
}
else return;
if(isset($_POST["thoigiannhapphieu"]))
{
    $thoigiannhapphieu=$_POST["thoigiannhapphieu"];
}
else return;
if(isset($_POST["tensp"]))
{
    $tensp=$_POST["tensp"];
}
else return;
if(isset($_POST["tondaungay"]))
{
    $tondaungay=$_POST["tondaungay"];
}
else return;
if(isset($_POST["khachhangmaso"]))
{
    $khachhangmaso=$_POST["khachhangmaso"];
}
else return;
if(isset($_POST["soluongsudung"]))
{
    $soluongsudung=$_POST["soluongsudung"];
}
else return;
if(isset($_POST["conlaicuoingay"]))
{
    $conlaicuoingay=$_POST["conlaicuoingay"];
}
else return;



$queryadd="INSERT INTO `chitiet_phieuvatlieu`( `idPhieuvatlieu`,`Thoigiannhapphieu`, `Tensp`, `Tondaungay`,`KhachangMaso`,`Soluongsudung`,`Conlaicuoingay`) VALUES ('$idPhieuvatlieu','$thoigiannhapphieu','$tensp','$tondaungay','$khachhangmaso','$soluongsudung','$conlaicuoingay')";
$exe = mysqli_query($con,$queryadd);

$arr=[];
if($exe){
    $arr["Success"]="true";
}
else{
    $arr["Success"]="false";
}
print(json_encode ($arr));
?>