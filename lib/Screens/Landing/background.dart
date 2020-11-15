import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: -10,
            child: Image.asset("lib/Screens/assets/main_top.png",
                width: size.width * 1),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("lib/Screens/assets/main_topright.png",
                width: size.width * 0.9),
          ),
          Positioned(
            bottom: 100,
            top: 0,
            left: 10,
            child: Image.asset(
              "lib/Screens/assets/logo.gif",
              width: size.width * 1,
              height: size.height * 0.8,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "lib/Screens/assets/main_bottom.png",
              width: size.width * 1,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
