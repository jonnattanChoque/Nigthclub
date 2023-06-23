import 'package:admin_dashboard/ui/shared/cards/white_card.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Dashboard', style: CustomLabels.h1),
          const SizedBox(height: 30),
          const WhiteCard(
            title: 'Sales status',
            child: Text('my text')
          )
        ],
      )
    );
  }
}