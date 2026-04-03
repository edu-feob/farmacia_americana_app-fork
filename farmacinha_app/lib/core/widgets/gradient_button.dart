import 'package:flutter/material.dart';

import '../palette/pallete.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(330, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
            
        child: const Text(
          'Entrar',
          style: TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w600,
            
          ),
        ),
      ),
    );
  }
}