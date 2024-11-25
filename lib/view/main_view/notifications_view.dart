import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';


class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(titleAsString: "Notifications",inNotifications: true,),
    );
  }
}

