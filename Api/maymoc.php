<?php 
include ("dbconnection.php");
$con= dbconnection();

if(isset($_POST["tenmaymoc"]))
{
    $tenmaymoc=$_POST["tenmaymoc"];
}
else return;
if(isset($_POST["tinhtrang"]))
{
    $tinhtrang=$_POST["tinhtrang"];
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

if(isset($_POST["tinhtrangcuoingay"]))
{
    $tinhtrangcuoingay=$_POST["tinhtrangcuoingay"];
}
else return;
if(isset($_POST["ngaynhapphieu"]))
{
    $ngaynhapphieu=$_POST["ngaynhapphieu"];
}
else return;
if(isset($_POST["idPhieumaymoc"]))
{
    $idPhieumaymoc=$_POST["idPhieumaymoc"];
}
else return;

$queryadd="INSERT INTO `sudungmaymoc`( `tenMayMoc`, `tinhTrang`, `tonDaungay`,`khachHangMaSo`,`soluongSudung`,`conlaiCuoiNgay`,`tinhtrangCuoiNgay`,`ngayNhapPhieu`,`idPhieumaymoc`) VALUES ('$tenmaymoc','$tinhtrang','$tondaungay','$khachhangmaso','$soluongsudung','$conlaicuoingay','$tinhtrangcuoingay','$ngaynhapphieu','$idPhieumaymoc')";
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