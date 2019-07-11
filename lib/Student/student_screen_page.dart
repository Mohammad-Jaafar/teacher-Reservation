import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_itc/home/choose_account.dart';
import 'package:hire_itc/model/Student.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';




class StudentScreen extends StatefulWidget {
  const StudentScreen({this.student});
  final Student student;

  @override
  State createState() => new StudentScreenState();
}

class StudentScreenState extends State<StudentScreen> {


  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value){
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => ChooseAccount()));

    })
        .catchError((e) =>
        debugPrint(e.toString()));

  }

  Future<List> fetchAds () async {



    final response = await http.get("http://192.168.101.58:8080/slim/public/api.php/api/news",headers: {'Content-Type': 'application/json'});

    List data = [];

    if (response.statusCode == 200) {

      data = json.decode(response.body);
    }
    return data;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('الرئيسية', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.orange[500]),),
          backgroundColor: Colors.blueGrey[700],

          centerTitle: true,

        ),

        backgroundColor: Colors.white,
        body:  WillPopScope(
    //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
    onWillPop: () async {
    Future.value(false); //return a `Future` with false value so this route cant be popped or closed.
    },

    child:
    FutureBuilder(
        future: fetchAds(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('Try again'),);
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Check internet connection'));
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        title: new Text(snapshot.data[index]['title']+'\n'+snapshot.data[index]['date'],style: TextStyle(fontWeight: FontWeight.bold),),

                        leading:
                        GestureDetector(
                          onTap: () {
                            nav();
                          },


                          child: Text("افتح الملف ",style: TextStyle(color: Colors.orange[500],fontWeight: FontWeight.bold),),

                        ),


//                        subtitle: hasString("${snapshot.data[index]['file']}")
//
//                        ?BoxDecoration(
//                          image: DecorationImage(
//                            image: AssetImage('assets/images/pdf.png'),
//                            fit: BoxFit.fill,
//                          ),
//                        )

                        subtitle: CachedNetworkImage(
                          imageUrl: "${snapshot.data[index]['file']}",
                          fit: BoxFit.fitWidth,
                          width: 180.0,
                        ),

                        trailing: Text('${snapshot.data[index]['id']} views',

                          style: TextStyle(
                            color: Colors.orange[500],
                            fontSize: 10.0,
                          ),),

                        onTap:  () {}
                    );
                  });
          } // unreachable
        }
    ),



        ),


        drawer: new Theme(

            data:Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.blueGrey[700]),

            child:  new Drawer(

              child: new ListView(
                children: <Widget>[
//            header
                  new UserAccountsDrawerHeader(
                    accountName: Text(widget.student.fullName,style: TextStyle(color: Colors.white,fontFamily: "mirza2",fontSize: 26.0),),
                    accountEmail: Text(widget.student.email,style: TextStyle(color: Colors.white,fontFamily: "mirza2",fontSize: 18.0),),
                    currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(
                        radius: 28.0,
                        backgroundImage:
                        NetworkImage("${widget.student.studentImage}"),
                        backgroundColor: Colors.transparent,
                      ),

                    ),
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cover.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

//            body

                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('الرئيسية',style: TextStyle(color: Colors.orange[500]),),
                      leading: Icon(Icons.home,color: Colors.orange[500],),
                    ),
                  ),

                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('تسجيل حضور',style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.person,color: Colors.orange[500],),
                    ),
                  ),

                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('الطلاب المشتركين',style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.shopping_basket,color: Colors.orange[500],),
                    ),
                  ),

                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('الجدول',style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.dashboard,color: Colors.orange[500],),
                    ),
                  ),

                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('الاشعارات',style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.favorite,color: Colors.orange[500],),
                    ),
                  ),

                  Divider(),

                  InkWell(
                    onTap: (){
                      _signOut(context);
                    },
                    child: ListTile(
                      title: Text('تسجيل الخروج',style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.cancel, color: Colors.blueGrey[300],),
                    ),
                  ),

                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text(' طلب مساعدة',style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.help, color: Colors.blueGrey[300]),
                    ),
                  ),
                ],
              ),
            )),





        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},

          tooltip: 'تسجيل الدخول',
          backgroundColor: Colors.orange[500],
          child:
          Icon(FontAwesomeIcons.pencilAlt, color: Colors.blueGrey[700],),
          elevation: 2.0,
        ),

        bottomNavigationBar: new Theme(

          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blueGrey[700]),
          child: new BottomNavigationBar (

            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[700],),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[700],),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[700],),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[700],),),
              ),

            ],
            onTap: null,
          ),
        )
    );
  }



  nav(){
    Navigator.of(context).pushNamed('/widget2');
  }


}









//
//    Firestore.instance.collection("students").where("id",isEqualTo: 1)
//        .snapshots().listen(
//            (data) {
//          if (data.documents[0]['id']) {
//
//            return buildStudent(context);
//          }
//          else {
//            return Center(child: CircularProgressIndicator(),);
//          }
//        }
//    );
//





























/*
void showDialogSingleButton(BuildContext context, String title, String message, String buttonLabel) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(buttonLabel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
 */