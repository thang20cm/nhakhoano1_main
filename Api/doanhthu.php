<?php 
include ("dbconnection.php");
$con= dbconnection();

if(isset($_POST["idPhieudoanhthu"]))
{
    $idPhieudoanhthu=$_POST["idPhieudoanhthu"];
}
else return;
if(isset($_POST["thoigiannhanviec"]))
{
    $thoigiannhanviec=$_POST["thoigiannhanviec"];
}
else return;
if(isset($_POST["khachhangmaso"]))
{
    $khachhangmaso=$_POST["khachhangmaso"];
}
else return;
if(isset($_POST["noidung"]))
{
    $noidung=$_POST["noidung"];
}
else return;
if(isset($_POST["tensanpham"]))
{
    $tensanpham=$_POST["tensanpham"];
}
else return;

if(isset($_POST["soluong"]))
{
    $soluong=$_POST["soluong"];
}
else return;


$queryadd="INSERT INTO `chitietphieudoanhthu`( `idPhieudoanhthu`,`Thoigiannhanviec`, `KhachangMaso`, `Noidung`,`Tensanpham`,`Soluong`) VALUES ('$idPhieudoanhthu','$thoigiannhanviec','$khachhangmaso','$noidung','$tensanpham','$soluong')";
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