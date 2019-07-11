import 'package:flutter/material.dart';
import 'package:hire_itc/startups/logo_timer.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';






void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      routes: {
        '/widget': (_) => new WebviewScaffold(
          url: "http://192.168.101.58:8080/slim/frontend/index.php",
          appBar: new AppBar(
            title: const Text('Widget Webview'),
          ),
          withZoom: false,
          withLocalStorage: true,
        ),
        '/widget2': (_) => new WebviewScaffold(
          url: "http://192.168.101.58:8080/slim/public/api.php/test/file/photo_2019-01-27_22-22-27.jpg",
          appBar: new AppBar(
            title: const Text('Widget Webview'),
          ),
          withZoom: false,
          withLocalStorage: true,
        ),


      },
        home: LogoTimer(),


      );

  }
}

















