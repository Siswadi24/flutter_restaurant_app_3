import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:restaurant_app_3/provider/navigator_provider.dart';
import 'package:restaurant_app_3/style/icons.dart';
import 'package:restaurant_app_3/ui/restaurant_favorite_page.dart';
import 'package:restaurant_app_3/ui/restaurant_setting_pages.dart';
import 'package:restaurant_app_3/widgets/profile_page.dart';
import 'package:restaurant_app_3/widgets/homePage.dart';

class MainScreenCustom extends StatefulWidget {
  const MainScreenCustom({super.key});

  @override
  State<MainScreenCustom> createState() => _MainScreenCustomState();
}

class _MainScreenCustomState extends State<MainScreenCustom> {
  late ChooseNavigation navigationProvider;

  List<Widget> pilihPage = [
    const HomePage(),
    const RestaurantFavoritePage(),
    const RestaurantSettingPages(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      navigationProvider.changeIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    navigationProvider = Provider.of<ChooseNavigation>(context);
    return Scaffold(
      body: SafeArea(
        child: pilihPage[navigationProvider.chooseIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    ChooseMenus(
                      icon: home,
                      index: 0,
                      indexactived: navigationProvider.chooseIndex,
                      onPress: () {
                        _onItemTapped(0);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ChooseMenus(
                          icon: love,
                          index: 1,
                          indexactived: navigationProvider.chooseIndex,
                          onPress: () {
                            _onItemTapped(1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ChooseMenus(
                          icon: setting,
                          index: 2,
                          indexactived: navigationProvider.chooseIndex,
                          onPress: () {
                            _onItemTapped(2);
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // );
}

class ChooseMenus extends StatelessWidget {
  final int index, indexactived;
  final String icon;
  final void Function() onPress;

  const ChooseMenus(
      {super.key,
      required this.icon,
      required this.index,
      required this.indexactived,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      minWidth: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            icon,
            color: index == indexactived ? Colors.red : Colors.green,
          ),
        ],
      ),
    );
  }
}



// return Scaffold(
//       body: SafeArea(
//         child: PilihPage[navigationProvider.chooseIndex],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Fluttertoast.showToast(
//             msg: 'This is Center Short Toast',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             // timeInSecForIosWeb: 1,
//             // backgroundColor: Colors.red,
//             // textColor: Colors.white,
//             // fontSize: 16.0,
//           );
//         },
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         backgroundColor: Colors.red,
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 10,
//         child: SizedBox(
//           height: 50,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     ChooseMenus(
//                       icon: Image.asset(
//                         "assets/icons/home.svg",
//                       ),
//                       index: 0,
//                       indexac: navigationProvider.chooseIndex,
//                       onTap: () {
//                         _onItemTapped(0);
//                       },
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     ChooseMenus(
//                         icon: Image.asset('assets/icons/love.svg'),
//                         index: 1,
//                         indexac: navigationProvider.chooseIndex,
//                         onTap: () {
//                           _onItemTapped(1);
//                         }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),