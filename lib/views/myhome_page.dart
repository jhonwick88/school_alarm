import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_alarm/constants/theme_data.dart';
import 'package:school_alarm/data.dart';
import 'package:school_alarm/enums.dart';
import 'package:school_alarm/models/menu_info.dart';
import 'package:school_alarm/views/alarm_page.dart';
import 'package:school_alarm/views/clock_page.dart';
import 'package:school_alarm/views/page_satu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.pageBackgroundColor,
        body: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenu) => buildMenuButton(currentMenu))
                  .toList(),
            ),
            VerticalDivider(color: CustomColor.dividerColor, width: 1),
            Expanded(child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else
                  return PageSatu();
              },
            ))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget buildMenuButton(MenuInfo menuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              backgroundColor: menuInfo.menuType == value.menuType
                  ? CustomColor.menuBackgroundColor
                  : Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadiusGeo(menuInfo),
              )),
          onPressed: () {
            var mymenu = Provider.of<MenuInfo>(context, listen: false);
            mymenu.updateMenu(menuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                menuInfo.imageSource!,
                scale: 2.0,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                menuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir',
                    color: CustomColor.primaryTextColor,
                    fontSize: 10),
              )
            ],
          ),
        );
      },
    );
  }

  BorderRadiusGeometry borderRadiusGeo(MenuInfo menuInfo) {
    if (menuInfo.menuType == MenuType.clock)
      return BorderRadius.only(topRight: Radius.circular(32));
    else if (menuInfo.menuType == MenuType.stopwatch)
      return BorderRadius.only(bottomRight: Radius.circular(32));
    else
      return BorderRadius.zero;
  }
}
