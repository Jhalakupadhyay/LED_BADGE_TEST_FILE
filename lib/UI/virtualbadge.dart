import 'package:badgemagic/UI/cell.dart';
import 'package:flutter/material.dart';

class VirtualBadge extends StatefulWidget {
  const VirtualBadge({
    super.key,
  });

  @override
  State<VirtualBadge> createState() => _VirtualBadgeState();
}

class _VirtualBadgeState extends State<VirtualBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.127,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 44,
        ),
        itemCount: 11 * 44,
        itemBuilder: (context, index) {
          return Container(
            width: 12,
            height: 12,
            child: Cell(
              index: index,
            ),
          );
        },
      ),
    );
  }
}
