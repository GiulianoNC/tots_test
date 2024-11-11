import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Primer vector (arriba)
          Positioned(
            top: -42, 
            left: 209, 
            child: Image.asset(
              'assets/img/Vectortop.png', 
              width: 300.19,
              height: 305.46,
              fit: BoxFit.contain,
            ),
          ),
          // Segundo vector (en el medio)
          Positioned(
            top: 250, 
            child: Image.asset(
              'assets/img/Vectormid.png', 
              fit: BoxFit.contain,
            ),
          ),
          // Tercer vector (abajo)
          Positioned(
            bottom: -30, 
            right: 0, 
            child: Image.asset(
              'assets/img/Vectorbot.png', 
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
