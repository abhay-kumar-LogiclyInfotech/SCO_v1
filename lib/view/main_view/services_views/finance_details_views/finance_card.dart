import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:sco_v1/utils/utils.dart';

class FinanceCard extends StatefulWidget {
  final Color color;
  final List<Widget> content;
  final dynamic langProvider; // Replace `dynamic` with actual type if known
  final bool isLastTerm;

  const FinanceCard({
    Key? key,
    required this.color,
    required this.content,
    required this.langProvider,
    this.isLastTerm = false,
  }) : super(key: key);

  @override
  _FinanceCardState createState() => _FinanceCardState();
}

class _FinanceCardState extends State<FinanceCard> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: widget.isLastTerm
            ? const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )
            : null,
        border: Border.all(color: Colors.transparent),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: kCardPadding,
          right: kCardPadding,
          top: kCardPadding,
        ),
        child: Column(
          children: widget.content,
        ),
      ),
    );
  }
}
