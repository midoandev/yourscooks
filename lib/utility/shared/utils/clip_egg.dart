import 'package:flutter/widgets.dart';

class CustomClipperShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2); // titik awal pada kiri tengah
    path.lineTo(0, 52); // garis ke atas (radius atas)
    path.quadraticBezierTo(0, 0, 52, 0); // kurva ke kanan atas (radius atas)
    path.lineTo(size.width - 52, 0); // garis ke kanan (radius atas)
    path.quadraticBezierTo(
        size.width, 20, size.width, 52); // kurva ke kanan bawah (radius bawah)
    path.lineTo(size.width, size.height - 52); // garis ke bawah (radius bawah)
    path.quadraticBezierTo(
        size.width, size.height, size.width - 52, size.height); // kurva ke kiri bawah (radius bawah)
    path.lineTo(52, size.height); // garis ke kiri (radius bawah)
    path.quadraticBezierTo(0, size.height, 0, size.height - 52); // kurva ke kiri atas (radius atas)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
