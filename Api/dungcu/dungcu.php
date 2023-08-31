<?php 
include ("dbconnection.php");
$con= dbconnection();



if(isset($_POST["idPhieudungcu"]))
{
    $idPhieudungcu=$_POST["idPhieudungcu"];
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



$queryadd="INSERT INTO `chitiet_phieudungcu`( `idPhieudungcu`,`Thoigiannhapphieu`, `Tensp`, `Tondaungay`,`Soluongsudung`,`Conlaicuoingay`) VALUES ('$idPhieudungcu','$thoigiannhapphieu','$tensp','$tondaungay','$soluongsudung','$conlaicuoingay')";
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