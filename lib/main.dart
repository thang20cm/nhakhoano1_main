import 'dart:convert';
import 'package:flutter/services.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';




void main() async{
  

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => DangNhap(),
      '/home': (context) {
      final userId = ModalRoute.of(context)?.settings.arguments as String?;
      return HomeUser(userId: userId ?? ''); // Truyền userId vào trang HomeUser
    },
       '/doanh thu công việc': (context) => doanhthucongviec(userId: ModalRoute.of(context)!.settings.arguments as String,title: ModalRoute.of(context)!.settings.arguments as String ),
  '/máy móc': (context) => maymoc(userId: ModalRoute.of(context)!.settings.arguments as String),
  '/dụng cụ': (context) => dungcu(userId: ModalRoute.of(context)!.settings.arguments as String),
  '/vật liệu': (context) => vatlieu(userId: ModalRoute.of(context)!.settings.arguments as String,title: ModalRoute.of(context)!.settings.arguments as String ),
      '/themmaymoc': (context) => themmaymoc(idPhieumaymoc: ModalRoute.of(context)!.settings.arguments as String),
      '/themdoanhthu': (context) => themdoanhthu(idPhieudoanhthu: ModalRoute.of(context)!.settings.arguments as String),
      '/themdungcu': (context) => themdungcu(idPhieudungcu: ModalRoute.of(context)!.settings.arguments as String),
       '/themvatlieu': (context) => themvatlieu(idPhieuvatlieu: ModalRoute.of(context)!.settings.arguments as String),  // Đăng ký giao diện menu 4
  

    '/công việc':(context) => congviec(userId: ModalRoute.of(context)!.settings.arguments as String),
    '/chọn phiếu': (context) => chonphieu(userId: ModalRoute.of(context)!.settings.arguments as String,title: ModalRoute.of(context)!.settings.arguments as String ),
    '/chọn phiếu lâm sàn': (context) => chonphieulamsan(userId: ModalRoute.of(context)!.settings.arguments as String,title: ModalRoute.of(context)!.settings.arguments as String ),
    },
  ));
}

class congviec extends StatelessWidget {
  final String userId;

  congviec({required this.userId});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromRGBO(88, 203, 108, 1),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              Container(
                margin: EdgeInsets.only(top: 120),
                child: Text(
                  'CHỌN CÔNG VIỆC CỦA BẠN',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'SFUFUTURABOOK'),
                  textAlign: TextAlign.center,
                ),
              ),
              CongViecItem(title: 'LÂM SÀN', userId: userId),
              CongViecItem(title: 'LAB THIẾT KẾ RĂNG', userId: userId),
              CongViecItem(title: 'CÔNG NGHỆ', userId: userId),
            ],
          ),
          Positioned(
            top: 20, // Khoảng cách từ phía trên
            left: 16, // Khoảng cách từ phía trái
            child: Container(
             
              child: IconButton(
                 icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white, // Đổi màu biểu tượng ở đây
                  ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CongViecItem extends StatelessWidget {
  final String title;
  final String userId;

  CongViecItem({required this.title, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          // Điều hướng đến trang tương ứng khi mục được chọn
          switch (title) {
            case 'LÂM SÀN':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chonphieulamsan(userId: userId,title:title),
                ),
              );
              break;
            case 'LAB THIẾT KẾ RĂNG':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chonphieu(userId: userId,title:title),
                ),
              );
              break;
            case 'CÔNG NGHỆ':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chonphieu(userId: userId,title:title),
                ),
              );
              break;
            default:
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(46, 173, 67, 1),fontFamily: 'SFUFUTURABOOK',),
          ),
        ),
      ),
    );
  }
}



class chonphieu extends StatelessWidget {
  final String userId;
  final String title;

  chonphieu({ required this.userId, required this.title });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(88, 203, 108, 1),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(top: 150),
            
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'CHỌN PHIẾU',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'SFUFUTURABOOK',
                  ),
                ),
              ),
              ChonPhieuItem(title: 'PHIẾU DOANH THU', userId: userId),
              ChonPhieuItem(title: 'PHIẾU VẬT LIỆU', userId: userId),
            ],
          ),
          Positioned(
            top: 20, // Khoảng cách từ phía trên
            left: 16, // Khoảng cách từ phía trái
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white, // Đổi màu biểu tượng ở đây
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Hiển thị giá trị của biến title chính giữa theo chiều dọc và bên trên chữ "CHỌN PHIẾU"
          Positioned(
            top: 90, // Điều chỉnh vị trí hiển thị title theo chiều dọc
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title, // Hiển thị giá trị của biến title
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'SFUFUTURABOOK',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class ChonPhieuItem extends StatelessWidget {
  final String title;
  final String userId;

  ChonPhieuItem({required this.title, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          // Điều hướng đến trang tương ứng khi mục được chọn
          switch (title) {
            case 'PHIẾU DOANH THU':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => doanhthucongviec(userId: userId,title: title),
                ),
              );
              break;
            case 'PHIẾU VẬT LIỆU':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => vatlieu(userId: userId,title: title,),
                ),
              );
              break;
            default:
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(46, 173, 67, 1),fontFamily: 'SFUFUTURABOOK',),
          ),
        ),
      ),
    );
  }
}



class chonphieulamsan extends StatelessWidget {
  final String userId;
  final String title;

  chonphieulamsan({ required this.userId, required this.title });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(88, 203, 108, 1),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(top: 150),
            
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'CHỌN PHIẾU',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'SFUFUTURABOOK',
                  ),
                ),
              ),
              ChonPhieuItemLamSan(title: 'PHIẾU DOANH THU', userId: userId),
              ChonPhieuItemLamSan(title: 'PHIẾU VẬT LIỆU', userId: userId),
            ],
          ),
          Positioned(
            top: 20, // Khoảng cách từ phía trên
            left: 16, // Khoảng cách từ phía trái
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white, // Đổi màu biểu tượng ở đây
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Hiển thị giá trị của biến title chính giữa theo chiều dọc và bên trên chữ "CHỌN PHIẾU"
          Positioned(
            top: 90, // Điều chỉnh vị trí hiển thị title theo chiều dọc
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title, // Hiển thị giá trị của biến title
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'SFUFUTURABOOK',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChonPhieuItemLamSan extends StatelessWidget {
  final String title;
  final String userId;

  ChonPhieuItemLamSan({required this.title, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          // Điều hướng đến trang tương ứng khi mục được chọn
          switch (title) {
            case 'PHIẾU DOANH THU':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => doanhthucongvieclamsan(userId: userId,title: title),
                ),
              );
              break;
            case 'PHIẾU VẬT LIỆU':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => vatlieulamsan(userId: userId,title: title,),
                ),
              );
              break;
            default:
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(46, 173, 67, 1),fontFamily: 'SFUFUTURABOOK',),
          ),
        ),
      ),
    );
  }
}

class vatlieulamsan extends StatefulWidget {
  final String userId;
  final String title;

  vatlieulamsan({required this.userId, required this.title});
  @override
  _VatLieuLamSanScreenState createState() => _VatLieuLamSanScreenState();

}

class _VatLieuLamSanScreenState extends State<vatlieulamsan> {

  TextEditingController ngaynhapphieu = TextEditingController();
  List<String> danhSachSudungVatLieu = [];

    String trichXuatThang(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }

  String trichXuatNam(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }

  @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
    getphieuvatlieu();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();
    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    ngaynhapphieu.text = "${now.day}/${now.month}/${now.year}";
    
  }

 Future<void> themphieuvatlieu() async {
    if(ngaynhapphieu.text!=""){
      try{
        String uri = "http://buffquat13.000webhostapp.com/themphieuvatlieu_lamsan.php";
        var res=await http.post(Uri.parse(uri),body: {
          "ngaynhapphieu":ngaynhapphieu.text,
          "uid":widget.userId,
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
          print("Them phieu may moc thanh cong!");
          ngaynhapphieu.text="";

          // Lấy danh sách mới nhất sau khi thêm thành công
          await getphieuvatlieu();
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
        }
        else{
          print("Error!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
  }

  Future<void> getphieuvatlieu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_phieuvatlieu_lamsan.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
         List<String> danhSachVatLieu = data
          .where((item) => item['uid'] == widget.userId) // Lọc theo uid
          .map((item) => "${item['Ngaynhapphieu']} - ${item['idPhieuvatlieu']}")
          .toList();
        setState(() {
          this.danhSachSudungVatLieu = danhSachVatLieu;
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: $e");
    }
  }

  Future<void> xoaPhieuVatLieu(String idPhieuvatlieu) async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/xoaphieuvatlieu_lamsan.php";
      var res = await http.post(Uri.parse(uri), body: {
        "idPhieuvatlieu": idPhieuvatlieu,
      });
      var response = jsonDecode(res.body);
      if (response["Success"] == "true") {
        print("Xóa phiếu vật liệu thành công!");
        await getphieuvatlieu();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xóa thành công!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print("Lỗi khi xóa phiếu doanh thu!");
      }
    } catch (e) {
      print(e);
    }
  }

   List<String> filterPhieuTheoThang(String thang, String nam) {
    return danhSachSudungVatLieu.where((phieu) {
      final parts = phieu.split(' - ');
      final ngayNhapPhieu = parts[0];
      final thangPhieu = trichXuatThang(ngayNhapPhieu);
      final namPhieu = trichXuatNam(ngayNhapPhieu);
      return thangPhieu == thang && namPhieu == nam;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12, // Số tab tương ứng với 12 năm
      child: Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(11, 180, 34, 1),
        title: Text(widget.title),
         bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: List<Widget>.generate(12, (int index) {
              final year = DateTime.now().year - index;
              return Tab(
                text: "Năm $year",
              );
            }),
          ),
      ),
      body: TabBarView(
          children: List<Widget>.generate(12, (int index) {
            final year = DateTime.now().year - index;
            return ListView.builder(
              
              itemCount: 12, // Số tháng trong năm
              itemBuilder: (context, index) {
                final month = index + 1;
                final phiieusThangNam = filterPhieuTheoThang(month.toString(), year.toString());
                if (phiieusThangNam.isEmpty) {
                  return SizedBox.shrink(); // Không hiển thị nếu không có phiếu trong tháng/năm
                }
                return Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Tháng $month',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           fontFamily: 'SFUFUTURABOOK',
                           color: Color.fromRGBO(226, 18, 18, 1)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                   child:GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(                    
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: phiieusThangNam.length,
                      itemBuilder: (context, index) {
                        final parts = phiieusThangNam[index].split(' - ');
                        final ngayNhapPhieu = parts[0];
                        final idPhieuvatlieu = parts[1];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => chitietphieuvatlieulamsan(
                          ngayPhieu: ngayNhapPhieu,
                          idPhieuvatlieu: idPhieuvatlieu,
                        ),
                      ),
                    );
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Xóa Phiếu Doanh Thu"),
                                  content: Text("Bạn có chắc muốn xóa phiếu này?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Hủy"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await xoaPhieuVatLieu(idPhieuvatlieu);
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Xóa"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          
                            child:Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(11, 180, 34, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ngayNhapPhieu,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SFUFUTURABOOK'
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  
                        );
                      },
                    ),
                ),
                  ],
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(11, 180, 34, 1),
          onPressed: () async {
            themphieuvatlieu();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thêm thành công!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class VatLieuLamSanData {
  String Thoigiannhapphieu;
  String Tensanpham;
  String Tondaungay;
  String Khachhangmaso;
  String Soluongsudung;
 String Conlaicuoingay;
 String idChitietphieuvatlieu;
 String idphieuvatlieuu;

  VatLieuLamSanData({
    required this.Thoigiannhapphieu,
    required this.Tensanpham,
    required this.Tondaungay,
    required this.Khachhangmaso,
    required this.Soluongsudung,
    required this.Conlaicuoingay,
    required this.idChitietphieuvatlieu,
    required this.idphieuvatlieuu,
  });
}

class chitietphieuvatlieulamsan extends StatefulWidget {
  final String ngayPhieu;
  final String idPhieuvatlieu;


  chitietphieuvatlieulamsan({required this.ngayPhieu,required this.idPhieuvatlieu});

  @override
  _chitietphieuvatlieulamsanState createState() => _chitietphieuvatlieulamsanState();
}

class _chitietphieuvatlieulamsanState extends State<chitietphieuvatlieulamsan> {

  List<VatLieuLamSanData> danhSachVatLieu = [];

  @override
  void initState(){
    super.initState();
    fetchDataSudungVatLieu();
  }

  Future<void> fetchDataSudungVatLieu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_vatlieu_lamsan.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<VatLieuLamSanData> vatLieuList = data.map((item) => VatLieuLamSanData(
              idChitietphieuvatlieu: item['idVatlieu'],
              idphieuvatlieuu: item['idPhieuvatlieu'],
              Thoigiannhapphieu: item['Thoigiannhapphieu'],
              Tensanpham: item['Tensp'],
              Tondaungay: item['Tondaungay'],
              Khachhangmaso: item['KhachangMaso'],
              Soluongsudung: item['Soluongsudung'],
              Conlaicuoingay: item['Conlaicuoingay'], 
            )).toList();

        setState(() {
          danhSachVatLieu = vatLieuList.where((vatlieu) => vatlieu.idphieuvatlieuu == widget.idPhieuvatlieu).toList();
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng sudungvatlieu: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng sudungvatlieu: $e");
    }
  }

@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double columnWidthPercentage = screenWidth * 0.1428; // Ví dụ: mỗi cột chiếm 25% màn hình

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Phiếu vật liệu: ${widget.ngayPhieu}',
        style: TextStyle(fontSize: 19),
      ),
    ),
    body:SingleChildScrollView(
    child: Container(
      width: double.infinity, // Đảm bảo container rộng bằng màn hình
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều ngang
          children: [
            Table(
              border: TableBorder.all(), // Đường viền cho bảng
              columnWidths: {
                0: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 0
                1: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 1
                2: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 2
                3: FixedColumnWidth(columnWidthPercentage),
                4: FixedColumnWidth(columnWidthPercentage), 
                5: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 3
                6: FixedColumnWidth(columnWidthPercentage), 
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Màu nền
                        child: Text(
                          'Thời gian',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                       // Màu nền
                        child: Text(
                          'Tên sản phẩm',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                       // Màu nền
                        child: Text(
                          'Tồn đầu ngày',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                     TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                     // Màu nền
                        child: Text(
                          'Khách hàng - Mã số',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                     TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Màu nền
                        child: Text(
                          'Số lượng sử dụng',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                       TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Màu nền
                        child: Text(
                          'Còn lại cuối ngày',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                      TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Màu nền
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                // Thêm các hàng dữ liệu tương tự như dưới đây
                for (var item in danhSachVatLieu)
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Thoigiannhapphieu),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Tensanpham),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Tondaungay),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Khachhangmaso),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Soluongsudung),
                        ),
                      ),
                        TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Conlaicuoingay),
                        ),
                      ),
                       TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: IconButton(
                                icon: Icon(Icons.edit), // Sử dụng biểu tượng chỉnh sửa
                                onPressed: () {
                                  _showEditDialog(context, item);
                                },
                              ),
                            ),
                          ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        bool success = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => themvatlieu(
              idPhieuvatlieu: widget.idPhieuvatlieu,
            ),
          ),
        );
        if (success == true) {
          fetchDataSudungVatLieu();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating, // Hiển thị phía trên
              backgroundColor: Colors.green, // Thay đổi màu nền
            ),
          );
        }
      },
      child: Icon(Icons.add),
    ),
  );
  
}
Future<void> _showEditDialog(BuildContext context, VatLieuLamSanData vatlieu) async {
  TextEditingController _thoiGianController = TextEditingController(text: vatlieu.Thoigiannhapphieu);
  TextEditingController _tenSPController = TextEditingController(text: vatlieu.Tensanpham);
  TextEditingController _tonDauNgayController = TextEditingController(text: vatlieu.Tondaungay);
  TextEditingController _KHMSController = TextEditingController(text: vatlieu.Khachhangmaso);
  TextEditingController _soLuongSDController = TextEditingController(text: vatlieu.Soluongsudung);
  TextEditingController _conLaiController = TextEditingController(text: vatlieu.Conlaicuoingay);


  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chỉnh sửa phiếu doanh thu'),
        content: SingleChildScrollView( // Bao bọc nội dung trong SingleChildScrollView
          child: Column(
            children: [
              TextFormField(
                controller: _thoiGianController,
                decoration: InputDecoration(labelText: 'Thời gian nhập phiếu'),
                enabled: false,
              ),
              TextFormField(
                controller: _tenSPController,
                decoration: InputDecoration(labelText: 'Tên sản phẩm'),
              ),
              TextFormField(
                controller: _tonDauNgayController,
                decoration: InputDecoration(labelText: 'Tồn đầu ngày'),
              ),
              TextFormField(
                controller: _KHMSController,
                decoration: InputDecoration(labelText: 'Khách hàng - Mã số'),
              ),
               TextFormField(
                controller: _soLuongSDController,
                keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
                decoration: InputDecoration(labelText: 'Số lượng sử dụng'),
              ),
              TextFormField(
                controller: _conLaiController,
                decoration: InputDecoration(labelText: 'Còn lại cuối ngày'),
              ),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Lấy giá trị mới từ các trường nhập liệu
              String thoiGianMoi = _thoiGianController.text;
              String tenSPMoi = _tenSPController.text;
              String tonDauNgayMoi = _tonDauNgayController.text;
              String KHMSMoi = _KHMSController.text;
              String soLuongSDMoi = _soLuongSDController.text;
              String conlaiMoi = _conLaiController.text;
            

              // Tạo dữ liệu JSON để gửi lên API
              Map<String, String> data = {
                'idChitietphieuvatlieu': vatlieu.idChitietphieuvatlieu,
                'thoiGian': thoiGianMoi,
                'tenSP': tenSPMoi,
                'tondaungay': tonDauNgayMoi,
                'KHMS': KHMSMoi,
                'soLuong': soLuongSDMoi,
                'conlai': conlaiMoi,
              };

              // Gửi yêu cầu POST đến API
              String apiUrl = "http://buffquat13.000webhostapp.com/edit_vatlieu_lamsan.php";
              var response = await http.post(Uri.parse(apiUrl), body: data);

              if (response.statusCode == 200) {
                // Xử lý phản hồi từ API nếu cần
                print("Cập nhật thành công");
                // Đóng hộp thoại chỉnh sửa
                Navigator.of(context).pop();
                // Cập nhật lại danh sách chi tiết phiếu doanh thu
                fetchDataSudungVatLieu();
              } else {
                print("Lỗi khi cập nhật dữ liệu: ${response.statusCode}");
              }
            },
            child: Text('Lưu'),
          ),
        ],
      );
    },
  );
}
}





class doanhthucongvieclamsan extends StatefulWidget {
  final String userId;
  final String title;

  doanhthucongvieclamsan({required this.userId, required this.title});

  @override
  _DoanhThuCongViecLamSanState createState() => _DoanhThuCongViecLamSanState();
}

class _DoanhThuCongViecLamSanState extends State<doanhthucongvieclamsan> {
  TextEditingController ngayNhapPhieu = TextEditingController();
  List<String> danhSachSuDungDoanhThu = [];

  String trichXuatThang(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }

  String trichXuatNam(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    setNgayNhapPhieu();
    getPhieuDoanhThu();
  }

  void setNgayNhapPhieu() {
    DateTime now = DateTime.now();
    ngayNhapPhieu.text = "${now.day}/${now.month}/${now.year}";
  }

  Future<void> themPhieuDoanhThu() async {
    if (ngayNhapPhieu.text != "") {
      try {
        String uri = "http://buffquat13.000webhostapp.com/themphieudoanhthulamsan.php";
        var res = await http.post(Uri.parse(uri), body: {
          "ngaynhapphieu": ngayNhapPhieu.text,
          "uid": widget.userId,
        });
        var response = jsonDecode(res.body);
        if (response["Success"] == "true") {
          print("Thêm phiếu doanh thu thành công!");
          ngayNhapPhieu.text = "";

          // Lấy danh sách mới nhất sau khi thêm thành công
          await getPhieuDoanhThu();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print("Lỗi khi thêm phiếu doanh thu!");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Vui lòng điền vào ô trống");
    }
  }

  Future<void> getPhieuDoanhThu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_phieudoanhthulamsan.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<String> danhSachDoanhThu = data
            .where((item) => item['uid'] == widget.userId)
            .map((item) => "${item['ngayNhapPhieu']} - ${item['idPhieudoanhthu']}")
            .toList();
        setState(() {
          this.danhSachSuDungDoanhThu = danhSachDoanhThu;
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng phieudoanhthu: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng phieudoanhthu: $e");
    }
  }

  Future<void> xoaPhieuDoanhThu(String idPhieudoanhthu) async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/xoaphieudoanhthulamsan.php";
      var res = await http.post(Uri.parse(uri), body: {
        "idPhieudoanhthu": idPhieudoanhthu,
      });
      var response = jsonDecode(res.body);
      if (response["Success"] == "true") {
        print("Xóa phiếu doanh thu thành công!");
        await getPhieuDoanhThu();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xóa thành công!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print("Lỗi khi xóa phiếu doanh thu!");
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> filterPhieuTheoThang(String thang, String nam) {
    return danhSachSuDungDoanhThu.where((phieu) {
      final parts = phieu.split(' - ');
      final ngayNhapPhieu = parts[0];
      final thangPhieu = trichXuatThang(ngayNhapPhieu);
      final namPhieu = trichXuatNam(ngayNhapPhieu);
      return thangPhieu == thang && namPhieu == nam;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12, // Số tab tương ứng với 12 năm
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Color.fromRGBO(11, 180, 34, 1),
          title: Text(widget.title),
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: List<Widget>.generate(12, (int index) {
              final year = DateTime.now().year - index;
              return Tab(
                text: "Năm $year",
              );
            }),
          ),
        ),
        body: TabBarView(
          children: List<Widget>.generate(12, (int index) {
            final year = DateTime.now().year - index;
            return ListView.builder(
              
              itemCount: 12, // Số tháng trong năm
              itemBuilder: (context, index) {
                final month = index + 1;
                final phiieusThangNam = filterPhieuTheoThang(month.toString(), year.toString());
                if (phiieusThangNam.isEmpty) {
                  return SizedBox.shrink(); // Không hiển thị nếu không có phiếu trong tháng/năm
                }
                return Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Tháng $month',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           fontFamily: 'SFUFUTURABOOK',
                           color: Color.fromRGBO(226, 18, 18, 1)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                   child:GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(                    
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: phiieusThangNam.length,
                      itemBuilder: (context, index) {
                        final parts = phiieusThangNam[index].split(' - ');
                        final ngayNhapPhieu = parts[0];
                        final idPhieudoanhthu = parts[1];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => chitietphieudoanhthulamsan(
                          ngayPhieu: ngayNhapPhieu,
                          idPhieudoanhthu: idPhieudoanhthu,
                        ),
                      ),
                    );
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Xóa Phiếu Doanh Thu"),
                                  content: Text("Bạn có chắc muốn xóa phiếu này?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Hủy"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await xoaPhieuDoanhThu(idPhieudoanhthu);
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Xóa"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          
                            child:Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(11, 180, 34, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ngayNhapPhieu,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SFUFUTURABOOK'
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  
                        );
                      },
                    ),
                ),
                  ],
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(11, 180, 34, 1),
          onPressed: () async {
            themPhieuDoanhThu();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thêm thành công!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


class DoanhThuDataLamSan {
  String Thoigiannhanviec;
  String Khachhangmaso;
  String Noidung;
  String Namesanpham;
  String Soluong;
  String Giao;
  String Ve;
  String idChitietphieudoanhthu;
  String idphieudoanhthuu;

  DoanhThuDataLamSan({
    required this.Thoigiannhanviec,
    required this.Khachhangmaso,
    required this.Noidung,
    required this.Namesanpham,
    required this.Soluong,
    required this.Giao,
    required this.Ve,
    required this.idChitietphieudoanhthu,
    required this.idphieudoanhthuu,
  });
}

class chitietphieudoanhthulamsan extends StatefulWidget {
  final String ngayPhieu;
  final String idPhieudoanhthu;

  chitietphieudoanhthulamsan({required this.ngayPhieu, required this.idPhieudoanhthu});

  @override
  _chitietphieudoanhthulamsanState createState() => _chitietphieudoanhthulamsanState();
}

class _chitietphieudoanhthulamsanState extends State<chitietphieudoanhthulamsan> {
  List<DoanhThuDataLamSan> danhSachDoanhThuLamSan = [];

  @override
  void initState() {
    super.initState();
    fetchDataSudungDoanhThu();
  }

  Future<void> fetchDataSudungDoanhThu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_doanhthulamsan.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DoanhThuDataLamSan> doanhThuLamSanList = data.map((item) => DoanhThuDataLamSan(
              idChitietphieudoanhthu: item['idChitietphieudoanhthu'],
              idphieudoanhthuu: item['idPhieudoanhthu'],
              Thoigiannhanviec: item['Thoigiannhanviec'],
              Khachhangmaso: item['KhachangMaso'],
              Noidung: item['Noidung'],
              Namesanpham: item['Tensanpham'],
              Soluong: item['Soluong'],
              Giao: item['Giao'],
              Ve: item['Ve'],
            )).toList();

        setState(() {
          danhSachDoanhThuLamSan = doanhThuLamSanList.where((doanhThu) => doanhThu.idphieudoanhthuu == widget.idPhieudoanhthu).toList();
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double columnWidthPercentage = screenWidth * 0.125;
   
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phiếu doanh thu: ${widget.ngayPhieu}',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FixedColumnWidth(columnWidthPercentage),
                    1: FixedColumnWidth(columnWidthPercentage),
                    2: FixedColumnWidth(columnWidthPercentage),
                    3: FixedColumnWidth(columnWidthPercentage),
                    4: FixedColumnWidth(columnWidthPercentage),
                    5: FixedColumnWidth(columnWidthPercentage),
                    6: FixedColumnWidth(columnWidthPercentage),
                    7: FixedColumnWidth(columnWidthPercentage),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Thời gian nhận việc',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Khách hàng - Mã số',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Nội dung',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Tên sản phẩm',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Số lượng',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Giao',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Về',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Thao tác',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var item in danhSachDoanhThuLamSan)
                      TableRow(
                        children: [
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Thoigiannhanviec),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Khachhangmaso),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Noidung),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Namesanpham),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Soluong),
                            ),
                          ),
                             TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Giao),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Ve),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: IconButton(
                                icon: Icon(Icons.edit), // Sử dụng biểu tượng chỉnh sửa
                                onPressed: () {
                                  _showEditDialog(context, item);
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool success = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => themdoanhthulamsan(
                idPhieudoanhthu: widget.idPhieudoanhthu,
              ),
            ),
          );
          if (success == true) {
            fetchDataSudungDoanhThu();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thêm thành công!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

Future<void> _showEditDialog(BuildContext context, DoanhThuDataLamSan doanhThu) async {
  TextEditingController _thoiGianController = TextEditingController(text: doanhThu.Thoigiannhanviec);
  TextEditingController _khachHangController = TextEditingController(text: doanhThu.Khachhangmaso);
  TextEditingController _noiDungController = TextEditingController(text: doanhThu.Noidung);
  TextEditingController _tenSanPhamController = TextEditingController(text: doanhThu.Namesanpham);
  TextEditingController _soLuongController = TextEditingController(text: doanhThu.Soluong);
  TextEditingController _giaoController = TextEditingController(text: doanhThu.Giao);
  TextEditingController _veController = TextEditingController(text: doanhThu.Ve);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chỉnh sửa phiếu doanh thu'),
        content: SingleChildScrollView( // Bao bọc nội dung trong SingleChildScrollView
          child: Column(
            children: [
              TextFormField(
                controller: _thoiGianController,
                decoration: InputDecoration(labelText: 'Thời gian nhận việc'),
                enabled: false,
              ),
              TextFormField(
                controller: _khachHangController,
                decoration: InputDecoration(labelText: 'Khách hàng - Mã số'),
              ),
              TextFormField(
                controller: _noiDungController,
                decoration: InputDecoration(labelText: 'Nội dung'),
              ),
              TextFormField(
                controller: _tenSanPhamController,
                decoration: InputDecoration(labelText: 'Tên sản phẩm'),
              ),
              TextFormField(
                controller: _soLuongController,
                decoration: InputDecoration(labelText: 'Số lượng'),
              ),
               TextFormField(
                controller: _giaoController,
                decoration: InputDecoration(labelText: 'Giao'),
              ),
              TextFormField(
                controller: _veController,
                decoration: InputDecoration(labelText: 'Về'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Lấy giá trị mới từ các trường nhập liệu
              String thoiGianMoi = _thoiGianController.text;
              String khachHangMoi = _khachHangController.text;
              String noiDungMoi = _noiDungController.text;
              String tenSanPhamMoi = _tenSanPhamController.text;
              String soLuongMoi = _soLuongController.text;
              String giao = _giaoController.text;
              String ve = _veController.text;

              // Tạo dữ liệu JSON để gửi lên API
              Map<String, String> data = {
                'idChitietphieudoanhthu': doanhThu.idChitietphieudoanhthu,
                'thoiGian': thoiGianMoi,
                'khachHang': khachHangMoi,
                'noiDung': noiDungMoi,
                'tenSanPham': tenSanPhamMoi,
                'soLuong': soLuongMoi,
                'giao': giao,
                've': ve,
              };

              // Gửi yêu cầu POST đến API
              String apiUrl = "http://buffquat13.000webhostapp.com/edit_doanhthu_lamsan.php";
              var response = await http.post(Uri.parse(apiUrl), body: data);

              if (response.statusCode == 200) {
                // Xử lý phản hồi từ API nếu cần
                print("Cập nhật thành công");
                // Đóng hộp thoại chỉnh sửa
                Navigator.of(context).pop();
                // Cập nhật lại danh sách chi tiết phiếu doanh thu
                fetchDataSudungDoanhThu();
              } else {
                print("Lỗi khi cập nhật dữ liệu: ${response.statusCode}");
              }
            },
            child: Text('Lưu'),
          ),
        ],
      );
    },
  );
}
}



class themdoanhthulamsan extends StatefulWidget {
  final String idPhieudoanhthu;
  themdoanhthulamsan({required this.idPhieudoanhthu});

  @override
  _ThemDoanhThuLamSanScreenState createState() => _ThemDoanhThuLamSanScreenState();
}

class _ThemDoanhThuLamSanScreenState extends State<themdoanhthulamsan> {
  TextEditingController khachHangController = TextEditingController();
  TextEditingController maSoController = TextEditingController();
  TextEditingController noidung = TextEditingController();
  TextEditingController tensanpham = TextEditingController();
  TextEditingController soluong = TextEditingController();
  TextEditingController thoigiannhanviec = TextEditingController();
  TextEditingController giao = TextEditingController();
  TextEditingController ve = TextEditingController();

  List<dynamic> congDoanLamSanList = [];
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://buffquat13.000webhostapp.com/congdoanlamsan.php'));

    if (response.statusCode == 200) {
      setState(() {
        congDoanLamSanList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  

  bool _isRed = false;
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
      _isRed = !_isRed;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

     bool _isRed1 = false;
  double _scale1 = 1.0;

  void _onTapDown1(TapDownDetails details) {
    setState(() {
      _scale1 = 0.95;
    });
  }

  void _onTapUp1(TapUpDetails details) {
    setState(() {
      _scale1 = 1.0;
      _isRed1 = !_isRed1;
    });
  }

  void _onTapCancel1() {
    setState(() {
      _scale1 = 1.0;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    setNgayNhapPhieu();

  }

  void setNgayNhapPhieu() {
    DateTime now = DateTime.now();
    thoigiannhanviec.text = "${now.hour}:${now.minute}";
  }

  Future<void> insertRecordDoanhThuLamSan(String idPhieudoanhthu) async {
  
      try {
        String combinedKhachHangMaSo = "";
        if (combinedKhachHangMaSoTemp.isNotEmpty) {
          combinedKhachHangMaSo =
              "$combinedKhachHangMaSoTemp-${khachHangController.text}-${maSoController.text}";
        } else {
          combinedKhachHangMaSo =
              "${khachHangController.text}-${maSoController.text}";
        }

        String uri = "http://buffquat13.000webhostapp.com/doanhthulamsan.php";

        var res = await http.post(Uri.parse(uri), body: {
          "idPhieudoanhthu": idPhieudoanhthu,
          "thoigiannhanviec": thoigiannhanviec.text,
          "khachhangmaso": combinedKhachHangMaSo,
          "noidung": getSelectedOptionsContent(),
          "tensanpham": tensanpham.text,
          "soluong": soluong.text,
          "giao": giao.text,
          "ve": ve.text,
        });

        var response = jsonDecode(res.body);

        if (response["Success"] == "true") {
          print("Thêm doanh thu thành công!");
          khachHangController.text = "";
          maSoController.text = "";
          noidung.text = "";
          tensanpham.text = "";
          soluong.text = "";
          giao.text = "";
          ve.text = "";

          Navigator.pop(context, true);
        } else {
          print("Error!");
        }
      } catch (e) {
        print(e);
      }
  }

  String combinedKhachHangMaSoTemp = "";
  String combinedKhachHangMaSoTemp1 = "";
  String getSelectedOptionsContent() {
  if (selectedOptions.isNotEmpty) {
    return selectedOptions.join(", ");
  } else {
    return "";
  }
}
  List<String> selectedOptions = []; // Biến cho cái mới

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'LÂM SÀN',
                style: TextStyle(
                  fontFamily: 'SFUFUTURABOOK',
                  color: Color.fromARGB(255, 81, 196, 85),
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
           SizedBox(height: 20),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        setState(() {
          combinedKhachHangMaSoTemp1 = "BS Nhật";
          combinedKhachHangMaSoTemp = "";
        });
      },
      child: Column(
        
        children: [
          Transform.scale(
            scale: _scale1,
            child: Container(
               margin: EdgeInsets.only(top: 30),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: combinedKhachHangMaSoTemp1 == "BS Nhật"
                    ? Color.fromARGB(255, 81, 196, 85)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                border:Border.all(
                   color: combinedKhachHangMaSoTemp1 == "BS Nhật"
                    ? Color.fromARGB(255, 81, 196, 85) // Màu border tùy chỉnh khi điều kiện đúng
                    : Color.fromARGB(255, 81, 196, 85), // Màu border tùy chỉnh khi điều kiện sai
                  width: 1,
                ) 
              ),
              alignment: Alignment.center,
              child: Text(
                combinedKhachHangMaSoTemp1,
                style: TextStyle(
                  color: combinedKhachHangMaSoTemp1 == "BS Nhật"
                      ? Color.fromARGB(255, 81, 196, 85)
                      : Color.fromARGB(255, 81, 196, 85),
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Khoảng cách giữa văn bản và Container
          Text(
            'Hàng BS Nhật', // Văn bản dưới chân
            style: TextStyle(
              color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 12,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.w600
            ),
            
          ),
        ],
      ),
    ),
    GestureDetector(
      onTapDown: _onTapDown1,
      onTapUp: _onTapUp1,
      onTapCancel: _onTapCancel1,
      onTap: () {
        setState(() {
          combinedKhachHangMaSoTemp = "NO.1";
          combinedKhachHangMaSoTemp1 = "";
        });
      },
      child: Column(
        children: [
          Transform.scale(
            scale: _scale,
            child: Container(
                 margin: EdgeInsets.only(top: 30),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: combinedKhachHangMaSoTemp == "NO.1"
                    ? Color.fromARGB(255, 81, 196, 85)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                 border:Border.all(
                   color: combinedKhachHangMaSoTemp1 == "NO.1"
                    ? Color.fromARGB(255, 81, 196, 85) // Màu border tùy chỉnh khi điều kiện đúng
                    : Color.fromARGB(255, 81, 196, 85), // Màu border tùy chỉnh khi điều kiện sai
                  width: 1,
                ) 
              ),
              alignment: Alignment.center,
              child: Text(
                combinedKhachHangMaSoTemp,
                style: TextStyle(
                  color: combinedKhachHangMaSoTemp == "NO.1"
                      ? Color.fromARGB(255, 81, 196, 85)
                      : Color.fromARGB(255, 81, 196, 85),
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Khoảng cách giữa văn bản và Container
          Text(
            'Hàng NO.1', // Văn bản dưới chân
            style: TextStyle(
            color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 12,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  ],
),

            SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: khachHangController,
              decoration: InputDecoration(
                labelText: 'Khách hàng',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
            

            SizedBox(height: 10),
           TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: maSoController,
              keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
              decoration: InputDecoration(
                labelText: 'Mã số',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
Wrap(
  alignment: WrapAlignment.center,
  spacing: 8.0, // Khoảng cách giữa các mục
  runSpacing: 8.0, // Khoảng cách giữa các dòng
  children: congDoanLamSanList.map((congDoan) {
    final tenCongDoan = congDoan['tencongdoan'];
    final isSelected = selectedOptions.contains(tenCongDoan);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove(tenCongDoan);
          } else {
            selectedOptions.add(tenCongDoan);
          }
        });
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Transform.scale(
                scale: isSelected ? _scale : _scale1,
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color.fromARGB(255, 81, 196, 85)
                        : Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color.fromARGB(255, 81, 196, 85),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tenCongDoan,
                    style: TextStyle(
                      color: isSelected
                          ? Color.fromARGB(255, 81, 196, 85)
                          : Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(bottom: 2, right: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: Color.fromARGB(255, 81, 196, 85),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            tenCongDoan,
            style: TextStyle(
              color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 9,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }).toList(),
),

        SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: tensanpham,
              decoration: InputDecoration(
                labelText: 'Tên sản phẩm',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
                      SizedBox(height: 20),
          TextFormField(
            style: TextStyle(
              color: Color.fromARGB(255, 81, 196, 85), // Màu văn bản khi nhập vào
            ),
            controller: soluong,
            keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
            inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
            decoration: InputDecoration(
              labelText: 'Số lượng',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85),
                fontFamily: 'SFUFUTURABOOK',
                fontWeight: FontWeight.w600,
              ),
              suffix: Text('-'),
              // fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
              filled: true,
              fillColor: Colors.white, // Bật chế độ đổ màu nền
              border: OutlineInputBorder(
                // Sử dụng OutlineInputBorder để tạo border radius
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide.none, // Ẩn dòng line ở dưới
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
              ),
            ),
          ),

             SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: giao,
              decoration: InputDecoration(
                labelText: 'Giao',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
             SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: ve,
              decoration: InputDecoration(
                labelText: 'Về',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    insertRecordDoanhThuLamSan(widget.idPhieudoanhthu);
                  },
                  child: Text("Thêm"),
                ),
                ElevatedButton(
           
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("Hủy")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}









class doanhthucongviec extends StatefulWidget {
  final String userId;
  final String title;

  doanhthucongviec({required this.userId, required this.title});

  @override
  _DoanhThuCongViecState createState() => _DoanhThuCongViecState();
}

class _DoanhThuCongViecState extends State<doanhthucongviec> {
  TextEditingController ngayNhapPhieu = TextEditingController();
  List<String> danhSachSuDungDoanhThu = [];

  String trichXuatThang(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }

  String trichXuatNam(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    setNgayNhapPhieu();
    getPhieuDoanhThu();
  }

  void setNgayNhapPhieu() {
    DateTime now = DateTime.now();
    ngayNhapPhieu.text = "${now.day}/${now.month}/${now.year}";
  }

  Future<void> themPhieuDoanhThu() async {
    if (ngayNhapPhieu.text != "") {
      try {
        String uri = "http://buffquat13.000webhostapp.com/themphieudoanhthu.php";
        var res = await http.post(Uri.parse(uri), body: {
          "ngaynhapphieu": ngayNhapPhieu.text,
          "uid": widget.userId,
        });
        var response = jsonDecode(res.body);
        if (response["Success"] == "true") {
          print("Thêm phiếu doanh thu thành công!");
          ngayNhapPhieu.text = "";

          // Lấy danh sách mới nhất sau khi thêm thành công
          await getPhieuDoanhThu();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print("Lỗi khi thêm phiếu doanh thu!");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Vui lòng điền vào ô trống");
    }
  }

  Future<void> getPhieuDoanhThu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_phieudoanhthu.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<String> danhSachDoanhThu = data
            .where((item) => item['uid'] == widget.userId)
            .map((item) => "${item['ngayNhapPhieu']} - ${item['idPhieudoanhthu']}")
            .toList();
        setState(() {
          this.danhSachSuDungDoanhThu = danhSachDoanhThu;
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng phieudoanhthu: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng phieudoanhthu: $e");
    }
  }

  Future<void> xoaPhieuDoanhThu(String idPhieudoanhthu) async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/xoaphieudoanhthu.php";
      var res = await http.post(Uri.parse(uri), body: {
        "idPhieudoanhthu": idPhieudoanhthu,
      });
      var response = jsonDecode(res.body);
      if (response["Success"] == "true") {
        print("Xóa phiếu doanh thu thành công!");
        await getPhieuDoanhThu();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xóa thành công!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print("Lỗi khi xóa phiếu doanh thu!");
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> filterPhieuTheoThang(String thang, String nam) {
    return danhSachSuDungDoanhThu.where((phieu) {
      final parts = phieu.split(' - ');
      final ngayNhapPhieu = parts[0];
      final thangPhieu = trichXuatThang(ngayNhapPhieu);
      final namPhieu = trichXuatNam(ngayNhapPhieu);
      return thangPhieu == thang && namPhieu == nam;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12, // Số tab tương ứng với 12 năm
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Color.fromRGBO(11, 180, 34, 1),
          title: Text(widget.title),
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: List<Widget>.generate(12, (int index) {
              final year = DateTime.now().year - index;
              return Tab(
                text: "Năm $year",
              );
            }),
          ),
        ),
        body: TabBarView(
          children: List<Widget>.generate(12, (int index) {
            final year = DateTime.now().year - index;
            return ListView.builder(
              
              itemCount: 12, // Số tháng trong năm
              itemBuilder: (context, index) {
                final month = index + 1;
                final phiieusThangNam = filterPhieuTheoThang(month.toString(), year.toString());
                if (phiieusThangNam.isEmpty) {
                  return SizedBox.shrink(); // Không hiển thị nếu không có phiếu trong tháng/năm
                }
                return Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Tháng $month',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           fontFamily: 'SFUFUTURABOOK',
                           color: Color.fromRGBO(226, 18, 18, 1)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                   child:GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(                    
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: phiieusThangNam.length,
                      itemBuilder: (context, index) {
                        final parts = phiieusThangNam[index].split(' - ');
                        final ngayNhapPhieu = parts[0];
                        final idPhieudoanhthu = parts[1];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => chitietphieudoanhthu(
                          ngayPhieu: ngayNhapPhieu,
                          idPhieudoanhthu: idPhieudoanhthu,
                        ),
                      ),
                    );
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Xóa Phiếu Doanh Thu"),
                                  content: Text("Bạn có chắc muốn xóa phiếu này?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Hủy"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await xoaPhieuDoanhThu(idPhieudoanhthu);
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Xóa"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          
                            child:Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(11, 180, 34, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ngayNhapPhieu,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SFUFUTURABOOK'
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  
                        );
                      },
                    ),
                ),
                  ],
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(11, 180, 34, 1),
          onPressed: () async {
            themPhieuDoanhThu();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thêm thành công!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


class DoanhThuData {
  String Thoigiannhanviec;
  String Khachhangmaso;
  String Noidung;

  String Giao;
  String Ve;
  String idChitietphieudoanhthu;
  String idphieudoanhthuu;

  DoanhThuData({
    required this.Thoigiannhanviec,
    required this.Khachhangmaso,
    required this.Noidung,
 
    required this.Giao,
    required this.Ve,
    required this.idChitietphieudoanhthu,
    required this.idphieudoanhthuu,
  });
}

class chitietphieudoanhthu extends StatefulWidget {
  final String ngayPhieu;
  final String idPhieudoanhthu;

  chitietphieudoanhthu({required this.ngayPhieu, required this.idPhieudoanhthu});

  @override
  _chitietphieudoanhthuState createState() => _chitietphieudoanhthuState();
}

class _chitietphieudoanhthuState extends State<chitietphieudoanhthu> {
  List<DoanhThuData> danhSachDoanhThu = [];

  @override
  void initState() {
    super.initState();
    fetchDataSudungDoanhThu();
  }

  Future<void> fetchDataSudungDoanhThu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_doanhthu.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DoanhThuData> doanhThuList = data.map((item) => DoanhThuData(
              idChitietphieudoanhthu:item['idChitietphieudoanhthu'],
              idphieudoanhthuu: item['idPhieudoanhthu'],
              Thoigiannhanviec: item['Thoigiannhanviec'],
              Khachhangmaso: item['KhachangMaso'],
              Noidung: item['Noidung'],
              Giao: item['Giao'],
              Ve: item['Ve'],
            )).toList();

        setState(() {
          danhSachDoanhThu = doanhThuList.where((doanhThu) => doanhThu.idphieudoanhthuu == widget.idPhieudoanhthu).toList();
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double columnWidthPercentage1 = screenWidth * 0.15;
    double columnWidthPercentage2 = screenWidth * 0.2;
    double columnWidthPercentage3 = screenWidth * 0.5;
    double columnWidthPercentage4 = screenWidth * 0.15;

    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phiếu doanh thu: ${widget.ngayPhieu}',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FixedColumnWidth(columnWidthPercentage1),
                    1: FixedColumnWidth(columnWidthPercentage2),
                    2: FixedColumnWidth(columnWidthPercentage3),
                    3: FixedColumnWidth(columnWidthPercentage4),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Thời gian',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Khách hàng - Mã số',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Nội dung',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Thao tác',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var item in danhSachDoanhThu)
                      TableRow(
                        children: [
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Thoigiannhanviec),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Khachhangmaso),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(item.Noidung),
                            ),
                          ),
                         
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: IconButton(
                                icon: Icon(Icons.edit), // Sử dụng biểu tượng chỉnh sửa
                                onPressed: () {
                                  _showEditDialog(context, item);
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool success = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => themdoanhthu(
                idPhieudoanhthu: widget.idPhieudoanhthu,
              ),
            ),
          );
          if (success == true) {
            fetchDataSudungDoanhThu();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thêm thành công!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

Future<void> _showEditDialog(BuildContext context, DoanhThuData doanhThu) async {
  TextEditingController _thoiGianController = TextEditingController(text: doanhThu.Thoigiannhanviec);
  TextEditingController _khachHangController = TextEditingController(text: doanhThu.Khachhangmaso);
  TextEditingController _noiDungController = TextEditingController(text: doanhThu.Noidung);
 
  TextEditingController _giaoController = TextEditingController(text: doanhThu.Giao);
  TextEditingController _veController = TextEditingController(text: doanhThu.Ve);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chỉnh sửa phiếu doanh thu'),
        content: SingleChildScrollView( // Bao bọc nội dung trong SingleChildScrollView
          child: Column(
            children: [
              TextFormField(
                controller: _thoiGianController,
                decoration: InputDecoration(labelText: 'Thời gian nhận việc'),
                enabled: false,
              ),
              TextFormField(
                controller: _khachHangController,
                decoration: InputDecoration(labelText: 'Khách hàng - Mã số'),
              ),
              TextFormField(
                controller: _noiDungController,
                decoration: InputDecoration(labelText: 'Nội dung'),
              ),
             
               TextFormField(
                controller: _giaoController,
                decoration: InputDecoration(labelText: 'Giao'),
              ),
              TextFormField(
                controller: _veController,
                decoration: InputDecoration(labelText: 'Về'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Lấy giá trị mới từ các trường nhập liệu
              String thoiGianMoi = _thoiGianController.text;
              String khachHangMoi = _khachHangController.text;
              String noiDungMoi = _noiDungController.text;
              String giao = _giaoController.text;
              String ve = _veController.text;

              // Tạo dữ liệu JSON để gửi lên API
              Map<String, String> data = {
                'idChitietphieudoanhthu': doanhThu.idChitietphieudoanhthu,
                'thoiGian': thoiGianMoi,
                'khachHang': khachHangMoi,
                'noiDung': noiDungMoi,
                'giao': giao,
                've': ve,
              };

              // Gửi yêu cầu POST đến API
              String apiUrl = "http://buffquat13.000webhostapp.com/edit_doanhthu.php";
              var response = await http.post(Uri.parse(apiUrl), body: data);

              if (response.statusCode == 200) {
                // Xử lý phản hồi từ API nếu cần
                print("Cập nhật thành công");
                // Đóng hộp thoại chỉnh sửa
                Navigator.of(context).pop();
                // Cập nhật lại danh sách chi tiết phiếu doanh thu
                fetchDataSudungDoanhThu();
              } else {
                print("Lỗi khi cập nhật dữ liệu: ${response.statusCode}");
              }
            },
            child: Text('Lưu'),
          ),
        ],
      );
    },
  );
}
}



class themdoanhthu extends StatefulWidget {
  final String idPhieudoanhthu;
  themdoanhthu({required this.idPhieudoanhthu});

  @override
  _ThemDoanhThuScreenState createState() => _ThemDoanhThuScreenState();
}

class _ThemDoanhThuScreenState extends State<themdoanhthu> {
  TextEditingController khachHangController = TextEditingController();
  TextEditingController maSoController = TextEditingController();
  TextEditingController noidung = TextEditingController();
  TextEditingController tensanpham = TextEditingController();
  TextEditingController soluong = TextEditingController();
  TextEditingController thoigiannhanviec = TextEditingController();
  TextEditingController giao = TextEditingController();
  TextEditingController ve = TextEditingController();




  


  List<dynamic> congDoanList = [];
  List<Map<String, dynamic>> controllerAndSelectedList = [];
  
Map<String, TextEditingController> noidungndControllers = {};

  

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://buffquat13.000webhostapp.com/congdoanlab.php'));

    if (response.statusCode == 200) {
      setState(() {
        congDoanList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  

  bool _isRed = false;
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
      _isRed = !_isRed;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

     bool _isRed1 = false;
  double _scale1 = 1.0;

  void _onTapDown1(TapDownDetails details) {
    setState(() {
      _scale1 = 0.95;
    });
  }

  void _onTapUp1(TapUpDetails details) {
    setState(() {
      _scale1 = 1.0;
      _isRed1 = !_isRed1;
    });
  }

  void _onTapCancel1() {
    setState(() {
      _scale1 = 1.0;
    });
  }

  bool _isRed2 = false;
  double _scale2 = 1.0;

  void _onTapDown2(TapDownDetails details) {
    setState(() {
      _scale2 = 0.95;
    });
  }

  void _onTapUp2(TapUpDetails details) {
    setState(() {
      _scale2 = 1.0;
      _isRed2 = !_isRed2;
    });
  }

  void _onTapCancel2() {
    setState(() {
      _scale2 = 1.0;
    });
  }


  @override
  void initState() {
    super.initState();
    fetchData();
    setNgayNhapPhieu();

  }

  void setNgayNhapPhieu() {
    DateTime now = DateTime.now();
    thoigiannhanviec.text = "${now.hour}:${now.minute}";
  }
  

  Future<void> insertRecordDoanhThu(String idPhieudoanhthu) async {
  try {
    String combinedKhachHangMaSo = "";
    if (combinedKhachHangMaSoTemp.isNotEmpty) {
      combinedKhachHangMaSo =
          "$combinedKhachHangMaSoTemp-${khachHangController.text}-${maSoController.text}";
    } else {
      combinedKhachHangMaSo =
          "${khachHangController.text}-${maSoController.text}";
    }

    String uri = "http://buffquat13.000webhostapp.com/doanhthu.php";
   // String soluongValue = soluong.text.isNotEmpty ? soluong.text : "";

    // Lấy danh sách các lựa chọn đã chọn thành chuỗi
    String selectedOptionsContent = getSelectedOptionsContent();

    var res = await http.post(Uri.parse(uri), body: {
      "idPhieudoanhthu": idPhieudoanhthu,
      "thoigiannhanviec": thoigiannhanviec.text,
      "khachhangmaso": combinedKhachHangMaSo,
      "noidung": selectedOptionsContent, // Gửi danh sách các lựa chọn đã chọn
      "giao": giao.text,
      "ve": ve.text,
    });

    var response = jsonDecode(res.body);

    if (response["Success"] == "true") {
      print("Thêm doanh thu thành công!");
      khachHangController.text = "";
      maSoController.text = "";
      noidung.text = "";
      giao.text = "";
      ve.text = "";

      Navigator.pop(context, true);
    } else {
      print("Error!");
    }
  } catch (e) {
    print(e);
  }
}



  String combinedKhachHangMaSoTemp = "";
  String combinedKhachHangMaSoTemp1 = "";

String getSelectedOptionsContent() {
  List<String> selectedContents = [];

  selectedOptions.forEach((selectedOption) {
    String tenCongDoan = selectedOption.split("(")[0];
    TextEditingController? noidungController = noidungndControllers[tenCongDoan];

    if (noidungController != null) {
      String noidungValue = noidungController.text;
      selectedContents.add("$tenCongDoan($noidungValue)");
    }
  });

  if (selectedContents.isNotEmpty) {
    return selectedContents.join(", ");
  } else {
    return "";
  }
}


  List<String> selectedOptions = []; // Biến cho cái mới

  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'LAB THIẾT KẾ RĂNG',
                style: TextStyle(
                  fontFamily: 'SFUFUTURABOOK',
                  color: Color.fromARGB(255, 81, 196, 85),
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
           SizedBox(height: 20),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        setState(() {
          combinedKhachHangMaSoTemp1 = "BS Nhật";
          combinedKhachHangMaSoTemp = "";
        });
      },
      child: Column(
        
        children: [
          Transform.scale(
            scale: _scale1,
            child: Container(
               margin: EdgeInsets.only(top: 30),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: combinedKhachHangMaSoTemp1 == "BS Nhật"
                    ? Color.fromARGB(255, 81, 196, 85)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                border:Border.all(
                   color: combinedKhachHangMaSoTemp1 == "BS Nhật"
                    ? Color.fromARGB(255, 81, 196, 85) // Màu border tùy chỉnh khi điều kiện đúng
                    : Color.fromARGB(255, 81, 196, 85), // Màu border tùy chỉnh khi điều kiện sai
                  width: 1,
                ) 
              ),
              alignment: Alignment.center,
              child: Text(
                combinedKhachHangMaSoTemp1,
                style: TextStyle(
                  color: combinedKhachHangMaSoTemp1 == "BS Nhật"
                      ? Color.fromARGB(255, 81, 196, 85)
                      : Color.fromARGB(255, 81, 196, 85),
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Khoảng cách giữa văn bản và Container
          Text(
            'Hàng BS Nhật', // Văn bản dưới chân
            style: TextStyle(
              color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 12,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.w600
            ),
            
          ),
        ],
      ),
    ),
    GestureDetector(
      onTapDown: _onTapDown1,
      onTapUp: _onTapUp1,
      onTapCancel: _onTapCancel1,
      onTap: () {
        setState(() {
          combinedKhachHangMaSoTemp = "NO.1";
          combinedKhachHangMaSoTemp1 = "";
        });
      },
      child: Column(
        children: [
          Transform.scale(
            scale: _scale,
            child: Container(
                 margin: EdgeInsets.only(top: 30),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: combinedKhachHangMaSoTemp == "NO.1"
                    ? Color.fromARGB(255, 81, 196, 85)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                 border:Border.all(
                   color: combinedKhachHangMaSoTemp1 == "NO.1"
                    ? Color.fromARGB(255, 81, 196, 85) // Màu border tùy chỉnh khi điều kiện đúng
                    : Color.fromARGB(255, 81, 196, 85), // Màu border tùy chỉnh khi điều kiện sai
                  width: 1,
                ) 
              ),
              alignment: Alignment.center,
              child: Text(
                combinedKhachHangMaSoTemp,
                style: TextStyle(
                  color: combinedKhachHangMaSoTemp == "NO.1"
                      ? Color.fromARGB(255, 81, 196, 85)
                      : Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Khoảng cách giữa văn bản và Container
          Text(
            'Hàng NO.1', // Văn bản dưới chân
            style: TextStyle(
            color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 12,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    GestureDetector(
      onTapDown: _onTapDown2,
      onTapUp: _onTapUp2,
      onTapCancel: _onTapCancel2,
      onTap: () {
        setState(() {
          combinedKhachHangMaSoTemp = "486";
          combinedKhachHangMaSoTemp1 = "";
        });
      },
      child: Column(
        children: [
          Transform.scale(
            scale: _scale,
            child: Container(
                 margin: EdgeInsets.only(top: 30),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: combinedKhachHangMaSoTemp == "486"
                    ? Color.fromARGB(255, 81, 196, 85)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                 border:Border.all(
                   color: combinedKhachHangMaSoTemp1 == "486"
                    ? Color.fromARGB(255, 81, 196, 85) // Màu border tùy chỉnh khi điều kiện đúng
                    : Color.fromARGB(255, 81, 196, 85), // Màu border tùy chỉnh khi điều kiện sai
                  width: 1,
                ) 
              ),
              alignment: Alignment.center,
              child: Text(
                combinedKhachHangMaSoTemp,
                style: TextStyle(
                  color: combinedKhachHangMaSoTemp == "486"
                      ? Color.fromARGB(255, 81, 196, 85)
                      : Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Khoảng cách giữa văn bản và Container
          Text(
            'Hàng 486', // Văn bản dưới chân
            style: TextStyle(
            color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 12,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  ],
),

            SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: khachHangController,
              decoration: InputDecoration(
                labelText: 'Khách hàng',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
            

            SizedBox(height: 10),
           TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: maSoController,
              keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
              decoration: InputDecoration(
                labelText: 'Mã số',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
Wrap(
  alignment: WrapAlignment.center,
  spacing: 8.0,
  runSpacing: 8.0,
  children: congDoanList.map((congDoan) {
    final TextEditingController noidungnd = TextEditingController();
    final tenCongDoan = congDoan['tencongdoan'];
    final isSelected = selectedOptions.contains("$tenCongDoan(${noidungnd.text})");

    // Thêm noidungnd vào danh sách controllers
    noidungndControllers[tenCongDoan] = noidungnd;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove("$tenCongDoan(${noidungnd.text})");
            noidungndControllers.remove(tenCongDoan);
          } else {
            selectedOptions.add("$tenCongDoan(${noidungnd.text})");
            noidungndControllers[tenCongDoan] = noidungnd;
          }
        });
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Transform.scale(
                scale: isSelected ? _scale : _scale1,
                child: Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color.fromARGB(255, 81, 196, 85)
                        : Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color.fromARGB(255, 81, 196, 85),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: isSelected
                      ? Container(
  width: 60,
 
  child: TextField(
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    controller: noidungnd,
    onChanged: (newValue) {
      // You can remove this onChanged callback if you don't need it.
    },
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(  // Use OutlineInputBorder for a custom border
        borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
        borderSide: BorderSide(  // Customize the border color and width
          color: Color.fromARGB(255, 228, 201, 51),  // Change the border color
          width: 2.0,           // Adjust the border width
        ),
      ),
      focusedBorder: OutlineInputBorder(  // Customize the focused border when the field is active
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 245, 3, 3),  // Change the focused border color
          width: 2.0,          // Adjust the focused border width
        ),
      ), // Add a placeholder text
    ),
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
)

                      : Text(
                          tenCongDoan,
                          style: TextStyle(
                            color: isSelected
                                ? Color.fromARGB(255, 81, 196, 85)
                                : Colors.white,
                            fontSize: 10,
                          ),
                        ),
                ),
              ),
              if (isSelected)
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(bottom: 2, right: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: Color.fromARGB(255, 81, 196, 85),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            tenCongDoan,
            style: TextStyle(
              color: Color.fromARGB(255, 81, 196, 85),
              fontSize: 10,
              fontFamily: 'SFUFUTURABOOK',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }).toList(),
),




       
                          
             SizedBox(height: 20),
  TextFormField(
  readOnly: true,
  controller: giao,
  decoration: InputDecoration(
    labelText: 'Giao',
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 81, 196, 85),
      fontFamily: 'SFUFUTURABOOK',
      fontWeight: FontWeight.w600,
    ),
    suffixIcon: Icon(Icons.access_time),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)),
    ),
  ),
  onTap: () async {
    // Khi người dùng nhấn vào TextFormField, hiển thị lựa chọn giờ phút
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      giao.text = selectedTime.format(context);
    }
  },
),



            SizedBox(height: 20),
  TextFormField(
  readOnly: true,
  controller: ve,
  decoration: InputDecoration(
    labelText: 'Thời gian kết thúc',
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 81, 196, 85),
      fontFamily: 'SFUFUTURABOOK',
      fontWeight: FontWeight.w600,
    ),
    suffixIcon: Icon(Icons.access_time),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)),
    ),
  ),
  onTap: () async {
    // Khi người dùng nhấn vào TextFormField, hiển thị lựa chọn giờ phút
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      ve.text = selectedTime.format(context);
    }
  },
),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                ElevatedButton(
           
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("Hủy")
                ),

                ElevatedButton(
                  onPressed: () {
                    insertRecordDoanhThu(widget.idPhieudoanhthu);
                  },
                  child: Text("Thêm"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


////////////////////////////////////////////////////////// Start Phieu may moc
class maymoc extends StatefulWidget {
  final String userId;

  maymoc({required this.userId});
  @override
  _MayMocScreenState createState() => _MayMocScreenState();

}

class _MayMocScreenState extends State<maymoc> {

  TextEditingController ngaynhapphieu = TextEditingController();
  

  List<String> danhSachSudungMayMoc = [];

  @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
    getphieumaymoc();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();

    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    ngaynhapphieu.text = "${now.day}/${now.month}/${now.year}";
    
  }

 Future<void> themphieumaymoc() async {
    if(ngaynhapphieu.text!=""){
      try{

        String uri = "http://buffquat13.000webhostapp.com/themphieumaymoc.php";

        var res=await http.post(Uri.parse(uri),body: {
          "ngaynhapphieu":ngaynhapphieu.text,
          "uid":widget.userId,
         
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
      
          print("Them phieu may moc thanh cong!");
          ngaynhapphieu.text="";
        }
        else{
          print("Error!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
    getphieumaymoc();
    
  }

  Future<void> getphieumaymoc() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_phieumaymoc.php";
      var response = await http.get(Uri.parse(uri));


      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
         List<String> danhSachMayMoc = data
          .where((item) => item['uid'] == widget.userId) // Lọc theo uid
          .map((item) => "${item['ngayNhapPhieu']} - ${item['idPhieumaymoc']}")
          .toList();
        setState(() {
          this.danhSachSudungMayMoc = danhSachMayMoc;
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách phiếu máy móc'),
      ),
      body: ListView.builder(
  itemCount: danhSachSudungMayMoc.length,
  itemBuilder: (context, index) {
    final parts = danhSachSudungMayMoc[index].split(' - ');
    final ngayNhapPhieu = parts[0];
    final idPhieumaymoc = parts[1];

    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chitietphieumaymoc(
              ngayPhieu: ngayNhapPhieu,
              idPhieumaymoc: idPhieumaymoc,
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(ngayNhapPhieu), // Hiển thị ngày nhập phiếu
        // Các thông tin khác của phiếu máy móc ở đây
      ),
    );
  },
),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          themphieumaymoc();
             ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
        content: Text('Thêm thành công!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Hiển thị phía trên
        backgroundColor: Colors.green, // Thay đổi màu nền
      ),
    );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class MayMocData {
  String tenMayMoc;
  String tinhTrang;
  String ngayNhapPhieu;
 String idChitietPhieumaymoc;

  MayMocData({
    required this.tenMayMoc,
    required this.tinhTrang,
    required this.ngayNhapPhieu,
    required this.idChitietPhieumaymoc,
  });
}

class chitietphieumaymoc extends StatefulWidget {
  final String ngayPhieu;
  final String idPhieumaymoc;


  chitietphieumaymoc({required this.ngayPhieu,required this.idPhieumaymoc});

  @override
  _chitietphieumaymocState createState() => _chitietphieumaymocState();
}

class _chitietphieumaymocState extends State<chitietphieumaymoc> {
  List<MayMocData> danhSachMayMoc = [];

  @override
  void initState() {
    super.initState();
    fetchDataSudungMayMoc();
  }

  Future<void> fetchDataSudungMayMoc() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_maymoc.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<MayMocData> mayMocList = data.map((item) => MayMocData(
              tenMayMoc: item['tenMayMoc'],
              tinhTrang: item['tinhtrangCuoiNgay'],
              ngayNhapPhieu: item['ngayNhapPhieu'],
              idChitietPhieumaymoc: item['idPhieumaymoc'],
            )).toList();

        setState(() {
          danhSachMayMoc = mayMocList.where((mayMoc) => mayMoc.idChitietPhieumaymoc == widget.idPhieumaymoc).toList();
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: $e");
    }
  }

@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double columnWidthPercentage = screenWidth * 0.25; // Ví dụ: mỗi cột chiếm 25% màn hình

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Phiếu máy móc: ${widget.ngayPhieu}',
        style: TextStyle(fontSize: 19),
      ),
    ),
    body: Container(
      width: double.infinity, // Đảm bảo container rộng bằng màn hình
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều ngang
          children: [
            Table(
              border: TableBorder.all(), // Đường viền cho bảng
              columnWidths: {
                0: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 0
                1: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 1
                2: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 2
                3: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 3
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.grey[200], // Màu nền
                        child: Text(
                          'Thời gian',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.grey[200], // Màu nền
                        child: Text(
                          'Tên máy móc',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.grey[200], // Màu nền
                        child: Text(
                          'Tình trạng cuối ngày',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                // Thêm các hàng dữ liệu tương tự như dưới đây
                for (var item in danhSachMayMoc)
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.ngayNhapPhieu),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.tenMayMoc),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.tinhTrang),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
        floatingActionButton: FloatingActionButton(
      onPressed: () async {
        bool success = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => themmaymoc(
              idPhieumaymoc: widget.idPhieumaymoc,
            ),
          ),
        );
        if (success == true) {
          fetchDataSudungMayMoc();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating, // Hiển thị phía trên
              backgroundColor: Colors.green, // Thay đổi màu nền
            ),
          );
        }
      },
      child: Icon(Icons.add),
    ),

    );
  }
}






class themmaymoc extends StatefulWidget {
 
 final String idPhieumaymoc;
  themmaymoc({required this.idPhieumaymoc});
  
  @override
  _ThemMayMocScreenState createState() => _ThemMayMocScreenState();
}


class _ThemMayMocScreenState extends State<themmaymoc>{

  TextEditingController tenmaymoc = TextEditingController();
  TextEditingController tinhtrang = TextEditingController();
  TextEditingController tondaungay = TextEditingController();
    TextEditingController khachhangmaso = TextEditingController();
  TextEditingController soluongsudung = TextEditingController();
  TextEditingController conlaicuoingay = TextEditingController();
   TextEditingController tinhtrangcuoingay = TextEditingController();
   TextEditingController thoigiannhapphieu = TextEditingController();
     
   

 @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();
    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    thoigiannhapphieu.text = "${now.hour}:${now.minute}";
  }
  Future<void> insertrecordmaymoc(String idPhieumaymoc) async {
    if(tenmaymoc.text!="" || tinhtrang.text!= "" || tondaungay.text!=""||khachhangmaso.text!="" || soluongsudung.text!= "" || conlaicuoingay.text!=""||tinhtrangcuoingay.text!=""||thoigiannhapphieu.text!=""){
      try{

        String uri = "http://buffquat13.000webhostapp.com/maymoc.php";

        var res=await http.post(Uri.parse(uri),body: {
          "tenmaymoc":tenmaymoc.text,
          "tinhtrang":tinhtrang.text,
          "tondaungay":tondaungay.text,
          "khachhangmaso":khachhangmaso.text,
          "soluongsudung":soluongsudung.text,
          "conlaicuoingay":conlaicuoingay.text,
          "tinhtrangcuoingay":tinhtrangcuoingay.text,
          "ngaynhapphieu": thoigiannhapphieu.text,
          "idPhieumaymoc": idPhieumaymoc,
          
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
          print("Them may moc thanh cong!");
          tenmaymoc.text="";
          tinhtrang.text="";
          tondaungay.text="";
          khachhangmaso.text="";
          soluongsudung.text="";
          conlaicuoingay.text="";
          tinhtrangcuoingay.text="";

         Navigator.pop(context, true);

        }
        else{
          print("Error!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
  }

 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'Them máy móc: ${widget.idPhieumaymoc}',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: tenmaymoc,
              decoration: InputDecoration(labelText: 'Ten may moc'),
            ),
            TextFormField(
              controller: tinhtrang,
              decoration: InputDecoration(labelText: 'tinh trang dau ngay'),
            ),
            TextFormField(
              controller: tondaungay,
              decoration: InputDecoration(labelText: 'Ton dau ngay'),
            ),
             TextFormField(
              controller: khachhangmaso,
              decoration: InputDecoration(labelText: 'Khach hang ma so'),
            ),
            TextFormField(
              controller: soluongsudung,
              decoration: InputDecoration(labelText: 'So luong su dung'),
            ),
            TextFormField(
              controller: conlaicuoingay,
              decoration: InputDecoration(labelText: 'Con lai cuoi ngay'),
            ),
             TextFormField(
              controller: tinhtrangcuoingay,
              decoration: InputDecoration(labelText: 'Tình trạng cuoi ngay'),
            ),
            // TextFormField(
            //   controller: ngaynhapphieu,
            //   decoration: InputDecoration(labelText: 'Ngay nhap phieu'),
            //   enabled: false,
            // ),
           ElevatedButton(
              onPressed: () {
                insertrecordmaymoc(widget.idPhieumaymoc);
              },
              child: Text("Thêm"),
            ),

          ],
       ),
      ),
    );
  }
}
////////////////////////////////////////////////////////// End Phieu may moc

////////////////////////////////////////// Start Dụng cụ
class dungcu extends StatefulWidget {
  final String userId;

  dungcu({required this.userId});
  @override
  _DungCuScreenState createState() => _DungCuScreenState();

}

class _DungCuScreenState extends State<dungcu> {

  TextEditingController ngaynhapphieu = TextEditingController();
  

  List<String> danhSachSudungDungCu = [];

  @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
    getphieudungcu();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();

    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    ngaynhapphieu.text = "${now.day}/${now.month}/${now.year}";
    
  }

 Future<void> themphieudungcu() async {
    if(ngaynhapphieu.text!=""){
      try{

        String uri = "http://buffquat13.000webhostapp.com/themphieudungcu.php";

        var res=await http.post(Uri.parse(uri),body: {
          "ngaynhapphieu":ngaynhapphieu.text,
          "uid":widget.userId,
         
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
      
          print("Them phieu may moc thanh cong!");
          ngaynhapphieu.text="";
        }
        else{
          print("Error!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
    getphieudungcu();
    
  }

  Future<void> getphieudungcu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_phieudungcu.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
         List<String> danhSachDungCu = data
          .where((item) => item['uid'] == widget.userId) // Lọc theo uid
          .map((item) => "${item['Ngaynhapphieu']} - ${item['idPhieudungcu']}")
          .toList();
        setState(() {
          this.danhSachSudungDungCu = danhSachDungCu;
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách phiếu dụng cụ'),
      ),
      body: ListView.builder(
  itemCount: danhSachSudungDungCu.length,
  itemBuilder: (context, index) {
    final parts = danhSachSudungDungCu[index].split(' - ');
    final ngayNhapPhieu = parts[0];
    final idPhieudungcu = parts[1];
    return InkWell(
      onTap: () async {
       
        // Chuyển hướng tới trang chitietphieumaymoc khi nhấn vào phần tử trong RecyclerView
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:(context) =>
            chitietphieudungcu(ngayPhieu: ngayNhapPhieu,idPhieudungcu:idPhieudungcu,
           ),
          ),
        );
      },
      child: ListTile(
        title: Text(ngayNhapPhieu), // Hiển thị thông tin máy móc (thay bằng thông tin thực tế của bạn)
      ),
    );
  },
),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          themphieudungcu();
             ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
        content: Text('Thêm thành công!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Hiển thị phía trên
        backgroundColor: Colors.green, // Thay đổi màu nền
      ),
    );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class DungCuData {
  String Tensanpham;
  String Tondaungay;
  String Soluongsudung;
 String Conlaicuoingay;
 String idphieudungcuu;

  DungCuData({
    required this.Tensanpham,
    required this.Tondaungay,
    required this.Soluongsudung,
    required this.Conlaicuoingay,
    required this.idphieudungcuu,
  });
}

class chitietphieudungcu extends StatefulWidget {
  final String ngayPhieu;
  final String idPhieudungcu;


  chitietphieudungcu({required this.ngayPhieu,required this.idPhieudungcu});

  @override
  _chitietphieudungcuState createState() => _chitietphieudungcuState();
}

class _chitietphieudungcuState extends State<chitietphieudungcu> {
  List<DungCuData> danhSachDungCu = [];

  @override
  void initState() {
    super.initState();
    fetchDataSudungDungCu();
  }

  Future<void> fetchDataSudungDungCu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_dungcu.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DungCuData> dungCuList = data.map((item) => DungCuData(
              idphieudungcuu: item['idPhieudungcu'],
              Tensanpham: item['Tensp'],
              Tondaungay: item['Tondaungay'],
              Soluongsudung: item['Soluongsudung'],
              Conlaicuoingay: item['Conlaicuoingay'],
             
            )).toList();

        setState(() {
          danhSachDungCu = dungCuList.where((dungcu) => dungcu.idphieudungcuu == widget.idPhieudungcu).toList();
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng sudungmaymoc: $e");
    }
  }


@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double columnWidthPercentage = screenWidth * 0.25; // Ví dụ: mỗi cột chiếm 25% màn hình

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Phiếu doanh thu: ${widget.ngayPhieu}',
        style: TextStyle(fontSize: 19),
      ),
    ),
    body: Container(
      width: double.infinity, // Đảm bảo container rộng bằng màn hình
       // Khoảng cách giữa nội dung và viền
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(), // Đường viền cho bảng
          columnWidths: {
            0: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 0
            1: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 1
            2: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 2
            3: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 3
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    // Màu nền
                    child: Text(
                      'Tên sản phẩm',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    // Màu nền
                    child: Text(
                      'Tồn đầu ngày',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8),
                     // Màu nền
                    child: Text(
                      'Số lượng sử dụng',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8),
                  // Màu nền
                    child: Text(
                      'Còn lại cuối ngày',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            // Thêm các hàng dữ liệu tương tự như dưới đây
            for (var item in danhSachDungCu)
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                      child: Text(item.Tensanpham),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                      child: Text(item.Tondaungay),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                      child: Text(item.Soluongsudung),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                      child: Text(item.Conlaicuoingay),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        bool success = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => themdungcu(
              idPhieudungcu: widget.idPhieudungcu,
            ),
          ),
        );
        if (success == true) {
          fetchDataSudungDungCu();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating, // Hiển thị phía trên
              backgroundColor: Colors.green, // Thay đổi màu nền
            ),
          );
        }
      },
      child: Icon(Icons.add),
    ),
  );
}
}


class themdungcu extends StatefulWidget {
 
 final String idPhieudungcu;
  themdungcu({required this.idPhieudungcu});
  
  @override
  _ThemDungCuScreenState createState() => _ThemDungCuScreenState();
}


class _ThemDungCuScreenState extends State<themdungcu>{

        TextEditingController thoigiannhapphieu = TextEditingController();
        TextEditingController tensanpham = TextEditingController();
        TextEditingController tondaungay = TextEditingController();
        TextEditingController soluongsudung = TextEditingController();
        TextEditingController conlaicuoingay = TextEditingController();
       
   

 @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();
    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    thoigiannhapphieu.text = "${now.hour}:${now.minute}";
  }
  Future<void> insertrecorddungcu(String idPhieudungcu) async {
    if(tensanpham.text!="" || tondaungay.text!= "" || soluongsudung.text!=""||conlaicuoingay.text!=""){
      try{

        String uri = "http://buffquat13.000webhostapp.com/dungcu.php";

        var res=await http.post(Uri.parse(uri),body: {
            "idPhieudungcu": idPhieudungcu,
            "thoigiannhapphieu":thoigiannhapphieu.text,
            "tensp":tensanpham.text,
            "tondaungay":tondaungay.text,
            "soluongsudung":soluongsudung.text,
            "conlaicuoingay":conlaicuoingay.text,
         
          
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
          print("Them doanh thu thanh cong!");
          tensanpham.text="";
          tondaungay.text="";
          soluongsudung.text="";
          conlaicuoingay.text="";

          Navigator.pop(context,true);
        }
        else{
          print("Error!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
  }

 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'Thêm tiến trình dụng cụ: ${widget.idPhieudungcu}',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: tensanpham,
              decoration: InputDecoration(labelText: 'Tên sản phẩm'),
            ),
            TextFormField(
              controller: tondaungay,
              decoration: InputDecoration(labelText: 'Tồn đầu ngày'),
            ),
            TextFormField(
              controller: soluongsudung,
              keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
              decoration: InputDecoration(labelText: 'Số lượng sử dụng'),
            ),
             TextFormField(
              controller: conlaicuoingay,
              decoration: InputDecoration(labelText: 'Còn lại cuối ngày'),
            ),
          
            // TextFormField(
            //   controller: ngaynhapphieu,
            //   decoration: InputDecoration(labelText: 'Ngay nhap phieu'),
            //   enabled: false,
            // ),
           ElevatedButton(
              onPressed: () {
                insertrecorddungcu(widget.idPhieudungcu);
              },
              child: Text("Thêm"),
            ),

          ],
       ),
      ),
    );
  }
}


//////////////////////////////////////////////// End dụng cụ

///////////////////////////////////////////// Start Vật liệu
class vatlieu extends StatefulWidget {
  final String userId;
  final String title;

  vatlieu({required this.userId, required this.title});
  @override
  _VatLieuScreenState createState() => _VatLieuScreenState();

}

class _VatLieuScreenState extends State<vatlieu> {

  TextEditingController ngaynhapphieu = TextEditingController();
  List<String> danhSachSudungVatLieu = [];

    String trichXuatThang(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }

  String trichXuatNam(String ngayNhapPhieu) {
    final parts = ngayNhapPhieu.split('/');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }

  @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
    getphieuvatlieu();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();
    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    ngaynhapphieu.text = "${now.day}/${now.month}/${now.year}";
    
  }

 Future<void> themphieuvatlieu() async {
    if(ngaynhapphieu.text!=""){
      try{
        String uri = "http://buffquat13.000webhostapp.com/themphieuvatlieu.php";
        var res=await http.post(Uri.parse(uri),body: {
          "ngaynhapphieu":ngaynhapphieu.text,
          "uid":widget.userId,
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
          print("Them phieu may moc thanh cong!");
          ngaynhapphieu.text="";

          // Lấy danh sách mới nhất sau khi thêm thành công
          await getphieuvatlieu();
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
        }
        else{
          print("Error!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
  }

  Future<void> getphieuvatlieu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_phieuvatlieu.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
         List<String> danhSachVatLieu = data
          .where((item) => item['uid'] == widget.userId) // Lọc theo uid
          .map((item) => "${item['Ngaynhapphieu']} - ${item['idPhieuvatlieu']}")
          .toList();
        setState(() {
          this.danhSachSudungVatLieu = danhSachVatLieu;
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng phieumaymoc: $e");
    }
  }

  Future<void> xoaPhieuVatLieu(String idPhieuvatlieu) async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/xoaphieuvatlieu.php";
      var res = await http.post(Uri.parse(uri), body: {
        "idPhieuvatlieu": idPhieuvatlieu,
      });
      var response = jsonDecode(res.body);
      if (response["Success"] == "true") {
        print("Xóa phiếu vật liệu thành công!");
        await getphieuvatlieu();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xóa thành công!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print("Lỗi khi xóa phiếu doanh thu!");
      }
    } catch (e) {
      print(e);
    }
  }

   List<String> filterPhieuTheoThang(String thang, String nam) {
    return danhSachSudungVatLieu.where((phieu) {
      final parts = phieu.split(' - ');
      final ngayNhapPhieu = parts[0];
      final thangPhieu = trichXuatThang(ngayNhapPhieu);
      final namPhieu = trichXuatNam(ngayNhapPhieu);
      return thangPhieu == thang && namPhieu == nam;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12, // Số tab tương ứng với 12 năm
      child: Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(11, 180, 34, 1),
        title: Text(widget.title),
         bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: List<Widget>.generate(12, (int index) {
              final year = DateTime.now().year - index;
              return Tab(
                text: "Năm $year",
              );
            }),
          ),
      ),
      body: TabBarView(
          children: List<Widget>.generate(12, (int index) {
            final year = DateTime.now().year - index;
            return ListView.builder(
              
              itemCount: 12, // Số tháng trong năm
              itemBuilder: (context, index) {
                final month = index + 1;
                final phiieusThangNam = filterPhieuTheoThang(month.toString(), year.toString());
                if (phiieusThangNam.isEmpty) {
                  return SizedBox.shrink(); // Không hiển thị nếu không có phiếu trong tháng/năm
                }
                return Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Tháng $month',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           fontFamily: 'SFUFUTURABOOK',
                           color: Color.fromRGBO(226, 18, 18, 1)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                   child:GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(                    
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: phiieusThangNam.length,
                      itemBuilder: (context, index) {
                        final parts = phiieusThangNam[index].split(' - ');
                        final ngayNhapPhieu = parts[0];
                        final idPhieuvatlieu = parts[1];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => chitietphieuvatlieu(
                          ngayPhieu: ngayNhapPhieu,
                          idPhieuvatlieu: idPhieuvatlieu,
                        ),
                      ),
                    );
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Xóa Phiếu Doanh Thu"),
                                  content: Text("Bạn có chắc muốn xóa phiếu này?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Hủy"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await xoaPhieuVatLieu(idPhieuvatlieu);
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Xóa"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          
                            child:Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(11, 180, 34, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ngayNhapPhieu,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SFUFUTURABOOK'
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  
                        );
                      },
                    ),
                ),
                  ],
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(11, 180, 34, 1),
          onPressed: () async {
            themphieuvatlieu();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thêm thành công!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class VatLieuData {
  String Thoigiannhapphieu;
  String Tensanpham;
  String Tondaungay;
  String Khachhangmaso;
  String Soluongsudung;
 String Conlaicuoingay;
 String idChitietphieuvatlieu;
 String idphieuvatlieuu;

  VatLieuData({
    required this.Thoigiannhapphieu,
    required this.Tensanpham,
    required this.Tondaungay,
    required this.Khachhangmaso,
    required this.Soluongsudung,
    required this.Conlaicuoingay,
    required this.idChitietphieuvatlieu,
    required this.idphieuvatlieuu,
  });
}

class chitietphieuvatlieu extends StatefulWidget {
  final String ngayPhieu;
  final String idPhieuvatlieu;


  chitietphieuvatlieu({required this.ngayPhieu,required this.idPhieuvatlieu});

  @override
  _chitietphieuvatlieuState createState() => _chitietphieuvatlieuState();
}

class _chitietphieuvatlieuState extends State<chitietphieuvatlieu> {

  List<VatLieuData> danhSachVatLieu = [];

  @override
  void initState(){
    super.initState();
    fetchDataSudungVatLieu();
  }

  Future<void> fetchDataSudungVatLieu() async {
    try {
      String uri = "http://buffquat13.000webhostapp.com/get_vatlieu.php";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<VatLieuData> vatLieuList = data.map((item) => VatLieuData(
              idChitietphieuvatlieu: item['idVatlieu'],
              idphieuvatlieuu: item['idPhieuvatlieu'],
              Thoigiannhapphieu: item['Thoigiannhapphieu'],
              Tensanpham: item['Tensp'],
              Tondaungay: item['Tondaungay'],
              Khachhangmaso: item['KhachangMaso'],
              Soluongsudung: item['Soluongsudung'],
              Conlaicuoingay: item['Conlaicuoingay'], 
            )).toList();

        setState(() {
          danhSachVatLieu = vatLieuList.where((vatlieu) => vatlieu.idphieuvatlieuu == widget.idPhieuvatlieu).toList();
        });
      } else {
        print("Lỗi khi lấy dữ liệu từ bảng sudungvatlieu: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ bảng sudungvatlieu: $e");
    }
  }

@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double columnWidthPercentage = screenWidth * 0.25; // Ví dụ: mỗi cột chiếm 25% màn hình

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Phiếu vật liệu: ${widget.ngayPhieu}',
        style: TextStyle(fontSize: 19),
      ),
    ),
    body:SingleChildScrollView(
    child: Container(
      width: double.infinity, // Đảm bảo container rộng bằng màn hình
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều ngang
          children: [
            Table(
              border: TableBorder.all(), // Đường viền cho bảng
              columnWidths: {
                0: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 0
                1: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 1
                2: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 2
                3: FixedColumnWidth(columnWidthPercentage),
                4: FixedColumnWidth(columnWidthPercentage), 
                5: FixedColumnWidth(columnWidthPercentage), // Độ rộng cột 3 
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                       // Màu nền
                        child: Text(
                          'Tên sản phẩm',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                       // Màu nền
                        child: Text(
                          'Nhận trong ngày',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                     
                    
                       TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Màu nền
                        child: Text(
                          'Còn lại cuối ngày',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                      TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Màu nền
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                // Thêm các hàng dữ liệu tương tự như dưới đây
                for (var item in danhSachVatLieu)
                  TableRow(
                    children: [
                      
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Tensanpham),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Tondaungay),
                        ),
                      ),
                     
                        TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle, // Căn giữa theo chiều dọc
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding tùy chỉnh
                          child: Text(item.Conlaicuoingay),
                        ),
                      ),
                       TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: IconButton(
                                icon: Icon(Icons.edit), // Sử dụng biểu tượng chỉnh sửa
                                onPressed: () {
                                  _showEditDialog(context, item);
                                },
                              ),
                            ),
                          ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        bool success = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => themvatlieu(
              idPhieuvatlieu: widget.idPhieuvatlieu,
            ),
          ),
        );
        if (success == true) {
          fetchDataSudungVatLieu();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm thành công!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating, // Hiển thị phía trên
              backgroundColor: Colors.green, // Thay đổi màu nền
            ),
          );
        }
      },
      child: Icon(Icons.add),
    ),
  );
  
}
Future<void> _showEditDialog(BuildContext context, VatLieuData vatlieu) async {
  TextEditingController _thoiGianController = TextEditingController(text: vatlieu.Thoigiannhapphieu);
  TextEditingController _tenSPController = TextEditingController(text: vatlieu.Tensanpham);
  TextEditingController _tonDauNgayController = TextEditingController(text: vatlieu.Tondaungay);
  TextEditingController _KHMSController = TextEditingController(text: vatlieu.Khachhangmaso);
  TextEditingController _soLuongSDController = TextEditingController(text: vatlieu.Soluongsudung);
  TextEditingController _conLaiController = TextEditingController(text: vatlieu.Conlaicuoingay);


  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chỉnh sửa phiếu doanh thu'),
        content: SingleChildScrollView( // Bao bọc nội dung trong SingleChildScrollView
          child: Column(
            children: [
              TextFormField(
                controller: _thoiGianController,
                decoration: InputDecoration(labelText: 'Thời gian nhập phiếu'),
                enabled: false,
              ),
              TextFormField(
                controller: _tenSPController,
                decoration: InputDecoration(labelText: 'Tên sản phẩm'),
              ),
              TextFormField(
                controller: _tonDauNgayController,
                decoration: InputDecoration(labelText: 'Nhận trong ngày'),
              ),
              TextFormField(
                controller: _KHMSController,
                decoration: InputDecoration(labelText: 'Khách hàng - Mã số'),
              ),
               TextFormField(
                controller: _soLuongSDController,
                keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
                decoration: InputDecoration(labelText: 'Số lượng sử dụng'),
              ),
              TextFormField(
                controller: _conLaiController,
                decoration: InputDecoration(labelText: 'Còn lại cuối ngày'),
              ),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Lấy giá trị mới từ các trường nhập liệu
              String thoiGianMoi = _thoiGianController.text;
              String tenSPMoi = _tenSPController.text;
              String tonDauNgayMoi = _tonDauNgayController.text;
              String KHMSMoi = _KHMSController.text;
              String soLuongSDMoi = _soLuongSDController.text;
              String conlaiMoi = _conLaiController.text;
            

              // Tạo dữ liệu JSON để gửi lên API
              Map<String, String> data = {
                'idChitietphieuvatlieu': vatlieu.idChitietphieuvatlieu,
                'thoiGian': thoiGianMoi,
                'tenSP': tenSPMoi,
                'tondaungay': tonDauNgayMoi,
                'KHMS': KHMSMoi,
                'soLuong': soLuongSDMoi,
                'conlai': conlaiMoi,
              };

              // Gửi yêu cầu POST đến API
              String apiUrl = "http://buffquat13.000webhostapp.com/edit_vatlieu.php";
              var response = await http.post(Uri.parse(apiUrl), body: data);

              if (response.statusCode == 200) {
                // Xử lý phản hồi từ API nếu cần
                print("Cập nhật thành công");
                // Đóng hộp thoại chỉnh sửa
                Navigator.of(context).pop();
                // Cập nhật lại danh sách chi tiết phiếu doanh thu
                fetchDataSudungVatLieu();
              } else {
                print("Lỗi khi cập nhật dữ liệu: ${response.statusCode}");
              }
            },
            child: Text('Lưu'),
          ),
        ],
      );
    },
  );
}
}






class themvatlieu extends StatefulWidget {
 
 final String idPhieuvatlieu;
  themvatlieu({required this.idPhieuvatlieu});
  
  @override
  _ThemVatLieuScreenState createState() => _ThemVatLieuScreenState();
}


class _ThemVatLieuScreenState extends State<themvatlieu>{

        TextEditingController thoigiannhapphieu = TextEditingController();
        TextEditingController tensanpham = TextEditingController();
        TextEditingController tondaungay = TextEditingController();
        TextEditingController khachhangmaso = TextEditingController();
        TextEditingController soluongsudung = TextEditingController();
        TextEditingController conlaicuoingay = TextEditingController();
       
     
   

 @override
  void initState(){
    super.initState();
    setNgayNhapPhieu();
  }
  void setNgayNhapPhieu(){
     DateTime now = DateTime.now();
    // Gán giá trị ngày tháng năm vào trường ngaynhapphieu
    thoigiannhapphieu.text = "${now.hour}:${now.minute}";
  }
  Future<void> insertrecordvatlieu(String idPhieuvatlieu) async {
    if(tensanpham.text!="" || tondaungay.text!= "" || soluongsudung.text!=""||conlaicuoingay.text!=""||khachhangmaso!=""){
      try{

        String uri = "http://buffquat13.000webhostapp.com/vatlieu.php";

        var res=await http.post(Uri.parse(uri),body: {
            "idPhieuvatlieu": idPhieuvatlieu,
            "thoigiannhapphieu":thoigiannhapphieu.text,
            "tensp":tensanpham.text,
            "tondaungay":tondaungay.text,
            "khachhangmaso":khachhangmaso.text,
            "soluongsudung":soluongsudung.text,
            "conlaicuoingay":conlaicuoingay.text,    
        });
        var response = jsonDecode(res.body);
        if(response["Success"]=="true"){
          print("Them vật liệu thanh cong!");
          tensanpham.text="";
          tondaungay.text="";
          khachhangmaso.text="";
          soluongsudung.text="";
          conlaicuoingay.text="";
      
         Navigator.pop(context, true);
        }
        else{
          print("Lỗi!");
        }
      }
      catch(e){
        print(e);
      }

    }
    else{
      print("Lam on dien vao o trong");
    }
  }

 
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                        SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: tensanpham,
              decoration: InputDecoration(
                labelText: 'Tên sản phẩm',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
                        SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: tondaungay,
              decoration: InputDecoration(
                labelText: 'Nhận trong ngày',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
                         SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: khachhangmaso,
              decoration: InputDecoration(
                labelText: 'Khách hàng - Mã số',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
                        SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: soluongsudung,
              keyboardType: TextInputType.number, // Đặt kiểu bàn phím cho TextInput
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Chỉ cho phép nhập số
              decoration: InputDecoration(
                labelText: 'Số lượng sử dụng',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
                         SizedBox(height: 20),
          TextFormField(
             style: TextStyle(
                color: Color.fromARGB(255, 81, 196, 85) , // Màu văn bản khi nhập vào
              ),
              controller: conlaicuoingay,
              decoration: InputDecoration(
                labelText: 'Còn lại cuối ngày',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 81, 196, 85),
                    fontFamily: 'SFUFUTURABOOK',
                    fontWeight: FontWeight.w600
                  ),
                  
                suffix: Text('-'),
                //fillColor: Color.fromARGB(255, 81, 196, 85), // Màu nền của input
                filled: true,
                 fillColor: Colors.white,  // Bật chế độ đổ màu nền
                 border: OutlineInputBorder( // Sử dụng OutlineInputBorder để tạo border radius
                  borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                  borderSide: BorderSide.none, // Ẩn dòng line ở dưới
                ),
               enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi không focus
              ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi focus
            ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Đặt giá trị border radius
                borderSide: BorderSide(color: Color.fromARGB(255, 81, 196, 85)), // Màu border khi bị disable
    ),
              ),
            ),
          
            // TextFormField(
            //   controller: ngaynhapphieu,
            //   decoration: InputDecoration(labelText: 'Ngay nhap phieu'),
            //   enabled: false,
            // ),
           SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                ElevatedButton(
           
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("Hủy")
                ),
                ElevatedButton(
                  onPressed: () {
                    insertrecordvatlieu(widget.idPhieuvatlieu);
                  },
                  child: Text("Thêm"),
                ),
              ],
            ),

          ],
       ),
      ),
    );
  }
}


///////////////////////////////////////////// End Vật liệu



class DangNhap extends StatefulWidget {
  @override
  _DangNhapState createState() => _DangNhapState();
}

class _DangNhapState extends State<DangNhap> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showError = false;
  bool showProgressBar = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String savedEmail = prefs.getString('email') ?? '';

      setState(() {
        email.text = savedEmail;
      });
    });
  }

  Future<void> login(BuildContext context) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        setState(() {
          showProgressBar = true;
        });

        String uri = "http://buffquat13.000webhostapp.com/login.php";

        var res = await http.post(Uri.parse(uri), body: {
          "email": email.text,
          "password": password.text,
        });

        var response = jsonDecode(res.body);

        setState(() {
          showProgressBar = false;
        });

        if (response["Success"] == true) {
          String userId = response['uid'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', userId);
          await prefs.setString('email', email.text);

          Navigator.pushReplacementNamed(context, '/home', arguments: userId);
        } else {
          setState(() {
            showError = true;
            errorMessage = response["Message"];
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print("Lỗi: $e");
        setState(() {
          showProgressBar = false;
        });
      }
    } else {
      print("Làm ơn điền vào ô trống");
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    
    body: Stack(
      children: [
        // Hình ảnh làm nền
        Image.asset(
          'assets/images/logo.png', // Đường dẫn đến hình ảnh của bạn
          fit: BoxFit.fill, // Kích thước ảnh phù hợp với nền
          width: double.infinity,
          height: 450.0,
        ),
        // Các widget nằm dưới hình ảnh
        Column(
          children: [
            Spacer(), // Để tạo khoảng trống giữa hình ảnh và trường TextFormField
            Container(
  margin: EdgeInsets.only(left: 50, right: 50, top: 250),
  child: TextFormField(
    controller: email,
    decoration: InputDecoration(
      labelText: 'Tài khoản',
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 81, 196, 85),
        fontSize: 19,
        fontFamily: 'SFUFUTURABOOK',
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Image.asset(
          'assets/images/user.png',
          width: 10,
          height: 10,
        ),
      ),
      contentPadding: EdgeInsets.only(bottom: 0), // Điều chỉnh vị trí văn bản
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 86, 207, 90)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 86, 207, 90)),
      ),
    ),
  ),
),
Container(
  margin: EdgeInsets.only(left: 50, right: 50,top:10),
  child: TextFormField(
    controller: password,
    obscureText: true,
    decoration: InputDecoration(
      labelText: 'Mật khẩu',
      labelStyle: TextStyle(
        color: const Color.fromARGB(255, 81, 196, 85),
        fontSize: 19,
        fontFamily: 'SFUFUTURABOOK',
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Image.asset(
          'assets/images/pw.png',
          width: 10,
          height: 10,
        ),
      ),
      contentPadding: EdgeInsets.only(bottom: 0), // Điều chỉnh vị trí văn bản
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 86, 207, 90)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 86, 207, 90)),
      ),
    ),
  ),
),

            Container(
               margin: EdgeInsets.only(left: 50, right: 50, top: 100),
               width: double.infinity,
               height: 50,
               
              child: ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: Text("ĐĂNG NHẬP",
                style: TextStyle(fontSize: 19,fontWeight:FontWeight.bold,fontFamily: 'SFUFUTURABOOK',),),
                style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
           // Điều chỉnh góc bo tròn tại đây
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(99,207,119,1))
    ),
              ),
            ),
            Spacer(), // Để căn giữa theo chiều dọc
          ],
        ),
        // Hiển thị ProgressBar nếu cần
        Visibility(
          visible: showProgressBar,
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Đang xử lý...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}







//Trang Home


class HomeUser extends StatefulWidget {
  final String userId;

  HomeUser({required this.userId});

  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final List<String> menuItems = ['Công việc'];

  bool isWorking = false;
  bool isEndButtonDisabled = true;
  late String Batdaulamviec;
  
    // Trạng thái làm việc

      @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        Batdaulamviec = prefs.getString('startWorkTime') ?? '';
        isWorking = Batdaulamviec.isNotEmpty;
        isEndButtonDisabled = !isWorking;
      });
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromRGBO(88,203,108,1),
   
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ElevatedButton(
                onPressed: isWorking ? null : () {
                  startWorkTime();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã bắt đầu giờ làm việc!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 212, 70, 117),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  minimumSize: Size(0, 50),
                ),
                child: Text("Bắt đầu", style: TextStyle(fontSize: 19,fontFamily: 'SFUFUTURABOOK',fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ElevatedButton(
                onPressed: isEndButtonDisabled ? null : () => showEndConfirmation(),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 212, 70, 117),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  minimumSize: Size(0, 50),
                ),
                child: Text("Kết thúc", style: TextStyle(fontSize: 19,fontFamily: 'SFUFUTURABOOK',fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
  child: Container(
    margin: EdgeInsets.only(top: 20, left: 18, right: 18),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _navigateToMenuScreen(context, index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(30.0), // Chỉnh border-radius ở đây
            ),
            child: Center(
              child: Text(
                menuItems[index],
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(88, 203, 108, 1),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SFUFUTURABOOK',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    ),
  ),
),

      ],
    ),
  );
}







Future<void> startWorkTime() async {
  try {
    DateTime now = DateTime.now();
    Batdaulamviec = "${now.hour}:${now.minute}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('startWorkTime', Batdaulamviec);

    setState(() {
      isWorking = true;
      isEndButtonDisabled = false;
    });

    print("Bắt đầu làm việc: $Batdaulamviec");
  } catch (e) {
    print(e);
  }
}


  Future<void> endWorkTime() async {
    try {
      DateTime now = DateTime.now();
      String KetThuclamviec = "${now.hour}:${now.minute}";
      String Ngaylamviec = "${now.day}/${now.month}/${now.year}";
      String Trangthai = "Chưa duyệt";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('startWorkTime');

      setState(() {
        isWorking = false;
        isEndButtonDisabled = true;
      });

      String uri = "http://buffquat13.000webhostapp.com/themngaylamviec.php";
      var res = await http.post(Uri.parse(uri), body: {
        "ngaylamviec": Ngaylamviec,
        "thoigianbatdau": Batdaulamviec,
        "thoigianketthuc": KetThuclamviec,
        "trangthai":Trangthai,
        "uid": widget.userId,
      });

      var response = jsonDecode(res.body);
      if (response["Success"] == "true") {
        print("Thêm thời gian kết thúc làm việc thành công!");
      } else {
        print("Lỗi khi thêm thời gian kết thúc làm việc!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> showEndConfirmation() async {
    bool shouldEndWork = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận kết thúc làm việc'),
          content: Text('Bạn có chắc muốn kết thúc làm việc?'),
          actions: <Widget>[
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () {
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
          content: Text('Đã kết thúc giờ làm việc!'),
          duration: Duration(seconds: 2),
         backgroundColor: Colors.purpleAccent, // Màu tím nhạt

        ),
      );
              },
            ),
          ],
        );
      },
    );

    if (shouldEndWork) {
      endWorkTime();
    }
  }

  void _navigateToMenuScreen(BuildContext context, int index) {
    String menuName = menuItems[index];
    Navigator.pushNamed(context, '/${menuName.toLowerCase()}', arguments: widget.userId);
  }
}
