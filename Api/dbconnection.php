<?php

function dbconnection(){
    $server = "localhost";
    $username= "id21127401_buffquat13";
    $password= "Thang30112002@";
    $dbname="id21127401_buffquat13";
    $con = mysqli_connect($server, $username, $password, $dbname);
    return $con;
}

?>
