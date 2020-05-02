import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tengesa/utils/strings.dart';

class WavyHeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        color: Colors.blue.shade900,
        height: 260,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.appName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Lobster"),
              ),
              SizedBox(height: 30),
              Icon(
                Icons.beach_access,
                color: Colors.redAccent,
                size: 30,
              )
            ],
          ),
        ),
      ),
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
