import 'package:control_de_calidad/Ventanas/ccm.dart';
import 'package:control_de_calidad/Ventanas/coloracap.dart';
import 'package:control_de_calidad/Ventanas/home_screen.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_ctrl_MP.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_ctrl_pesos.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_procesos.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_temperaturas.dart';
import 'package:control_de_calidad/Ventanas/preformas_i5.dart';
import 'package:control_de_calidad/Ventanas/tapas6.dart';
import 'package:control_de_calidad/Ventanas/yutzumi.dart';
import 'package:control_de_calidad/widgets/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';


class ScreenSoplado extends StatefulWidget {
  const ScreenSoplado({super.key});

  @override
  State<ScreenSoplado> createState() => _ScreenSopladoState();
}

class _ScreenSopladoState extends State<ScreenSoplado> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [      
      ScreenListDatosMPIPS(),    
   
      ScreenListDatosPESOSIPS(),
      ScreenListDatosPROCEIPS(),
      ScreenListDatosTEMPIPS(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(SettingsModel settingsModel) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.insert_chart),
        title: ("DATOS INICIALES"),
        activeColorPrimary:
            settingsModel.isDarkMode ? Colors.green : Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.category),
        title: ("MP Y ADITIVOS"),
        activeColorPrimary:
            settingsModel.isDarkMode ? Colors.amber : Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bug_report),
        title: ("DEFECTOS"),
        activeColorPrimary:
            settingsModel.isDarkMode ? Colors.purple : Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.monitor_weight_outlined),
        title: ("PESOS"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.build),
        title: ("PROCESO"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.thermostat),
        title: ("TEMPERATURA"),
        activeColorPrimary:
            settingsModel.isDarkMode ? Colors.orange : Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final settingsModel = Provider.of<SettingsModel>(context);
    return MultiProvider(
        providers: [
          
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: settingsModel.isDarkMode
                ? Colors.black
                : const Color.fromARGB(255, 255, 255, 255),
            title: Text(
              "Soplado",
              style: TextStyle(
                  color: settingsModel.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: settingsModel.isDarkMode ? Colors.white : Colors.black,
            ),
            flexibleSpace: const Image(
              image: AssetImage('images/BannerPREFIPS.png'),
              height: 100,
              fit: BoxFit.cover,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage()),
                  );
                },
              ),
            ],
          ),
          drawer: SafeArea(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.abc,
                      size: 80,
                      weight: 80,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Inicio'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenSoplado()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Preformas IPS-400'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenPreformasI5()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Preformas I5'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenCCM()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('CCM'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenColoracap()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Coloracap'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenYutzumi()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Yutzumi'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenTapas6()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Tapas 6'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenSoplado()),
                      );
                    },
                    leading: const Icon(Icons.sports_handball),
                    title: const Text('Soplado'),
                  ),
                  const Spacer(),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: const Text('Desarrollado por "  "'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(settingsModel),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: true,
            backgroundColor:
                settingsModel.isDarkMode ? Colors.black : Colors.white,
            isVisible: true,
            navBarStyle: NavBarStyle.style9,
          ),
        ));
  }
}
