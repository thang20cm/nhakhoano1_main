<?php

include("dbconnection.php");
$conn = dbconnection();

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}

// Thực hiện truy vấn lấy dữ liệu máy móc từ bảng "maymoc"
$sql = "SELECT * FROM `chitietphieumaymoc`";
$result = $conn->query($sql);

// Khởi tạo một mảng để chứa kết quả
$data = array();

// Kiểm tra kết quả truy vấn
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Thêm thông tin máy móc vào mảng
        $data[] = $row;
    }
}

// Trả về kết quả dưới dạng JSON
header('Content-Type: application/json');
echo json_encode($data);

// Đóng kết nối đến cơ sở dữ liệu
$conn->close();
?>
