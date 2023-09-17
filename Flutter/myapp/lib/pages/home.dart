import 'dart:convert';

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

import 'package:http/http.dart' as http;
import 'googleCalendarEvent.dart';
import 'userProfile.dart';

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

        getGoogleApiId(credentials.user.sub);
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

    return access_token;

    var response2 = await http.get(
      Uri.parse(
          "https://dev-is1igt546vy76y0i.us.auth0.com/api/v2/users/$userId"),
      headers: {"authorization": "Bearer $access_token"},
    );

    var profile = jsonDecode(response2.body);

    var profileParsed = Root.fromJson(profile);

    var oauthtoken = profileParsed.identities![0]!.accesstoken!;

    var response3 = await http.get(Uri.parse(
        "https://www.googleapis.com/calendar/v3/calendars/primary/events?access_token=$oauthtoken&2023-09-17T07:07:28-00:00&timeMax=2023-09-18T07:07:28-00:00&singlEvents=true"));

    dynamic calendar = jsonDecode(response3.body);
    List<GoogleCalendarEvent> events = <GoogleCalendarEvent>[];

    if (calendar['items'] != null) {
      calendar['items']!.forEach((v) {
        if (v['status'] != "cancelled") {
          events.add(GoogleCalendarEvent.fromJson(v));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            _user != null ? Colors.white : Color.fromRGBO(102, 189, 137, 1),
        body: Padding(
          padding: const EdgeInsets.only(
            top: padding,
            bottom: padding,
            left: padding / 2,
            right: padding / 2,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: Row(children: [
              _user != null
                  ? Column(
                      children: [
                        Image.network(_user!.pictureUrl.toString()),
                        Text("Welcome to PlanPilot, ${_user!.name}"),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const MainPage())),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(102, 189, 137, 1)),
                          ),
                          child: const Text('Go to your calendar'),
                        )
                      ],
                    )
                  : const Expanded(child: HeroWidget())
            ])),
            _user != null
                ? ElevatedButton(
                    onPressed: logout,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(102, 189, 137, 1)),
                    ),
                    child: const Text('Logout'),
                  )
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const MainPage())),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(102, 189, 137, 1)),
                        ),
                        child: const Text('Go to your calendar'),
                      )
                    ],
                  )
          ]),
        ));
  }
}
