import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/mainPage.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/calendar/optimizer.dart';
import 'authPages/authpage.dart';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './authPages/constants.dart';
import './authPages/hero.dart';
import './authPages/user.dart';

class Home extends StatefulWidget {
  final Auth0? auth0;
  const Home({this.auth0, final Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  UserProfile? _user;

  late Auth0 auth0;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();
    auth0 = widget.auth0 ??
        Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web =
        Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    if (kIsWeb) {
      auth0Web.onLoad().then((final credentials) => setState(() {
            _user = credentials?.user;
          }));
    }
  }

  Future<void> login() async {
    try {
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      }

      var credentials = await auth0.webAuthentication().login();

      setState(() {
        _user = credentials.user;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0
            .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
            .logout();
        setState(() {
          _user = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
      // bottomNavigationBar: BottomNavigationBar(items:
      //   [BottomNavigationBarItem(icon: Icon(Icons.star), label: "Hi there"),
      //   BottomNavigationBarItem(icon: ImageIcon(AssetImage('/assets/logo-alone.png')), label: "Bye")],
      //   currentIndex: 0,
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   onTap: (value) {
      //     print("Tapped");
      //   },
      //   ),
    ); //Scaffold(body: MainPage(), bottomNavigationBar: AppBar(),);
  }
}
