import 'package:flutter/material.dart';

class loginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clip = new Path();

    clip.moveTo(0, 70);
    clip.lineTo(0, size.height - 70);
    clip.quadraticBezierTo(0, size.height, 70, size.height);
    clip.lineTo(size.width - 70, size.height);
    clip.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 70);

    clip.lineTo(size.width, size.height * 0.3 + 50);
    clip.quadraticBezierTo(
        size.width, size.height * 0.3, size.width - 50, size.height * 0.3 - 50);
    clip.lineTo(70, 0);
    clip.quadraticBezierTo(0, 0, 0, 70);
    clip.close();
    return clip;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SignupClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clip = new Path();
    clip.moveTo(size.width, 70);
    clip.lineTo(size.width, size.height - 70);
    clip.quadraticBezierTo(
        size.width, size.height, size.width - 70, size.height);

    clip.lineTo(70, size.height);
    clip.quadraticBezierTo(0, size.height, 0, size.height - 70);

    clip.lineTo(0, size.height * 0.3 + 50);
    clip.quadraticBezierTo(0, size.height * 0.3, 50, size.height * 0.3 - 50);
    clip.lineTo(size.width - 70, 0);

    clip.quadraticBezierTo(size.width, 0, size.width, 70);

    clip.close();
    return clip;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class loginShadowPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path clip = new Path();

    clip.moveTo(0, 70);
    clip.lineTo(0, size.height - 70);
    clip.quadraticBezierTo(0, size.height, 70, size.height);

    clip.lineTo(size.width - 70, size.height);
    clip.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 70);

    clip.lineTo(size.width, size.height * 0.3 + 50);
    clip.quadraticBezierTo(
        size.width, size.height * 0.3, size.width - 50, size.height * 0.3 - 50);

    clip.lineTo(70, 0);
    clip.quadraticBezierTo(0, 0, 0, 70);
    clip.close();

    canvas.drawShadow(clip, Color(0xFF4BB8F4), 5, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class signupShadowPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path clip = new Path();
    clip.moveTo(size.width, 70);
    clip.lineTo(size.width, size.height - 70);
    clip.quadraticBezierTo(
        size.width, size.height, size.width - 70, size.height);

    clip.lineTo(70, size.height);
    clip.quadraticBezierTo(0, size.height, 0, size.height - 70);

    clip.lineTo(0, size.height * 0.3 + 50);
    clip.quadraticBezierTo(0, size.height * 0.3, 50, size.height * 0.3 - 50);
    clip.lineTo(size.width - 70, 0);

    clip.quadraticBezierTo(size.width, 0, size.width, 70);

    clip.close();

    canvas.drawShadow(clip, Color(0xFF4BB8F4), 5, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
