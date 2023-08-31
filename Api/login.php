<?php

include ("dbconnection.php");
$conn= dbconnection();


// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}

// Nhận dữ liệu từ yêu cầu POST
$email = $_POST['email'];
$password = $_POST['password'];

// Thực hiện truy vấn kiểm tra thông tin đăng nhập
$sql = "SELECT * FROM `user` WHERE uemail = '$email' AND upassword='$password'";
$result = $conn->query($sql);

// Kiểm tra kết quả của truy vấn
if ($result->num_rows > 0) {
    // Tìm thấy người dùng có thông tin đăng nhập hợp lệ
    $response['Success'] = true;
    $response['Message'] = "Đăng nhập thành công!";


     // Truy vấn để lấy uid từ cơ sở dữ liệu
     $row = $result->fetch_assoc();
     $response['uid'] = $row['uid'];
} else {
    // Không tìm thấy người dùng có thông tin đăng nhập hợp lệ
    $response['Success'] = false;
    $response['Message'] = "Đăng nhập thất bại!";
}

// Trả về kết quả dưới dạng JSON
echo json_encode($response);

// Đóng kết nối đến cơ sở dữ liệu
$conn->close();
?>
