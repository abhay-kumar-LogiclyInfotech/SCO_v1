

import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imagePath;
  final bool isNetwork ;

  const FullScreenImagePage({
    super.key,
    required this.imagePath,
     this.isNetwork = true,
  });

  @override
  Widget build(BuildContext context) {
    final image = isNetwork
        ? Image.network(imagePath)
        : Image.asset(imagePath);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: image,
        ),
      ),
    );
  }
}
