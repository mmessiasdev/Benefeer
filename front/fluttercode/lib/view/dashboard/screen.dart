import 'package:Benefeer/service/local/auth.dart';
import 'package:Benefeer/view/plan/initialplansscreen.dart';
import 'package:Benefeer/view/search/searchscreen.dart';
import 'package:Benefeer/view/tutorial/tutorial.dart';
import 'package:Benefeer/view/wallet/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:Benefeer/view/home/homepage.dart';
import 'package:get/get.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/controller/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var token;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken();

    setState(() {
      token = strToken.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
          child: GetBuilder<DashboardController>(
        builder: (controller) => token == "null"
            ? TutorialScreen()
            : Scaffold(
                backgroundColor: lightColor,
                body: SafeArea(
                  child: IndexedStack(
                    index: controller.tabIndex,
                    children: [
                      HomePage(),
                      PlanScreen(),
                      SearchScreen(),
                      WalletScreen(),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                  ),
                  child: SnakeNavigationBar.color(
                    snakeShape: SnakeShape.rectangle,
                    backgroundColor: PrimaryColor,
                    unselectedItemColor: lightColor,
                    showUnselectedLabels: true,
                    selectedItemColor: SecudaryColor,
                    snakeViewColor: PrimaryColor,
                    currentIndex: controller.tabIndex,
                    onTap: (val) {
                      controller.updateIndex(val);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                        Icons.home_filled,
                        size: 30,
                      )),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.diamond,
                          size: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.wallet,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      )),
    );
  }
}
