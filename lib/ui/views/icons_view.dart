import 'package:admin_dashboard/ui/shared/cards/white_card.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class IconsView extends StatelessWidget {
  const IconsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Icons', style: CustomLabels.h1),
          const SizedBox(height: 30),
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
              ),
              WhiteCard(
                title: 'access_alarm_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.access_alarm_outlined),
                ),
              ),
              WhiteCard(
                title: 'access_time_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.access_time_outlined),
                ),
              ),
              WhiteCard(
                title: 'all_inbox_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.all_inbox_outlined),
                ),
              ),
              WhiteCard(
                title: 'desktop_mac_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.desktop_mac_outlined),
                ),
              ),
              WhiteCard(
                title: 'keyboard_tab_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.keyboard_tab_outlined),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}