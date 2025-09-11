import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';

import '../../viewModel/services/getIt_services.dart';
import '../../viewModel/services/navigation_services.dart';


void showCommonDialog({
  required String message,
  bool dismissible = false,
  Color backgroundColor = Colors.white,
}) {
  Dialogs.materialDialog(
    barrierDismissible: dismissible,
    color: backgroundColor,
    context: getIt.get<NavigationServices>().navigationStateKey.currentState!.context,
    customView: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Cross button row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(
                    getIt.get<NavigationServices>().navigationStateKey.currentContext!,
                  ).pop();
                },
                child: const Icon(Icons.close, size: 22, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Message text
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
