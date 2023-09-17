import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/mainPage.dart';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/authPages/constants.dart';
import '../utils/authPages/hero.dart';

import 'package:http/http.dart' as http;
import '../utils/globals.dart';

import '../api/gcal/GoogleCalendar.dart';

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
        userId = credentials.user.sub;

        getGoogleApiId(userId!);
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

  Future<String> getGoogleApiId(String userId) async {
    var response = await http.post(
        Uri.parse("https://dev-is1igt546vy76y0i.us.auth0.com/oauth/token"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "client_id": "nEdTXXPUTq7N7XmhnbFlk8wtAajIEsl1",
          "client_secret":
              "T6486qdbfTW7mx3UbmRjNRDah13RLbS8GnBi4GS0imHN4XFjMTuS0QClDsMl0u55",
          "audience": "https://dev-is1igt546vy76y0i.us.auth0.com/api/v2/",
          "grant_type": "client_credentials"
        }));

    var res = jsonDecode(response.body);
    var access_token = res["access_token"];

    GoogleCalendar.getListEvents(DateTime.parse("2023-09-15"),
        DateTime.parse("2023-09-19"), access_token);

    return access_token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            _user != null ? Colors.white : Color.fromRGBO(102, 189, 137, 1),
        body: Padding(
          padding: const EdgeInsets.only(
            top: padding,
            bottom: padding / 2,
            left: padding / 2,
            right: padding / 2,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: _user != null
                        ? Center(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.network(
                                        _user!.pictureUrl.toString())),
                                SizedBox(
                                  height: 50,
                                ),
                                Text("Welcome to PlanPilot, ${_user!.name}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontFamily: CupertinoIcons.iconFont)),
                                SizedBox(
                                  height: 100,
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const MainPage())),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(102, 189, 137, 1)),
                                  ),
                                  child: const Text('Go to your calendar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                ElevatedButton(
                                  onPressed: logout,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(102, 189, 137, 1)),
                                  ),
                                  child: const Text('Logout',
                                      style: TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const HeroWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: login,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: const Text('Login'),
                                  ),
                                ],
                              )
                            ],
                          ))),
              ]),
        ));
  }
}
