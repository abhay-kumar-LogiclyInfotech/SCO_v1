import 'package:flutter/material.dart';

class CustomConfirmationWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final String headline;
  final String message;

  const CustomConfirmationWidget({
    super.key,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.icon,
    required this.headline,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          //*------Icon start-----*/
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon,size: 30,color: Colors.white,)),
          ),
          //*------Icon End-----*/

          //*-------Confirmation Message-----*
          const SizedBox(height: 10,),

          Text(
            headline,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
