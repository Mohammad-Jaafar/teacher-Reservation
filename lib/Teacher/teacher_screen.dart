import 'package:hire_itc/Student/student_information.dart';
import 'package:hire_itc/home/choose_account.dart';
import 'package:hire_itc/model/Student.dart';
import 'package:hire_itc/model/Teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TeacherScreen extends StatefulWidget {
   TeacherScreen({this.teacher,this.student});

  final Teacher teacher;
   List<Student> student;
  @override
  State createState() => new TeacherScreenState(student: student);
}

class TeacherScreenState extends State<TeacherScreen> {
  List<Student> student;
  TeacherScreenState({this.student});

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value){
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => ChooseAccount()));

    })
        .catchError((e) =>
        debugPrint(e.toString()));

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('الرئيسية',textAlign: TextAlign.center,style: TextStyle(color: Colors.orange[500]),),
          backgroundColor: Colors.blueGrey[700],

          centerTitle:true ,
        ),

        backgroundColor: Colors.white,
        body:WillPopScope(
    //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
    onWillPop: () async {
    Future.value(false); //return a `Future` with false value so this route cant be popped or closed.
    },
    child:new Center(

      child:   ListView.builder(
    itemCount: student.length,
    padding: EdgeInsets.only(top: 12.0,bottom: 13.0),
    itemBuilder: (context , position){

      if(student[position].TeacherName == widget.teacher.fullname) {
        return Column(
          children: <Widget>[
            Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                        contentPadding: EdgeInsets.all(10.0),

                        title: Text(
                          '${student[position].fullName} ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mirza',
                          ),
                        ),

                        subtitle: Text(
                          '${student[position].schoolName} / ${student[position].department2} / ${student[position].department}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        leading: Column(
                          children: <Widget>[
                            CircleAvatar(

                              radius: 28.0,
                              backgroundImage:
                              NetworkImage("${student[position].studentImage}"),
                              backgroundColor: Colors.transparent,
                            ),


                          ],
                        ),
                        onTap: () {}
                    ),),

                  new Column(

                    children: <Widget>[

                      new SizedBox(

                          child: MaterialButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      30.0)),
                              color: Colors.blueGrey[600],
                              splashColor: Colors.orange[500],
                              textColor: Colors.orange[500],
                              child: Row(
                                children: <Widget>[
                                  Text(" اعرض المزيد  ", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontFamily: 'Mirza'),),


                                  new Icon(FontAwesomeIcons
                                      .solidArrowAltCircleRight),
                                ],
                              ),
                              onPressed: () {

                                _navigateToStudentInformation(context,student[position]);

                              }
                          )),

                      Text('${student[position].gender}  ',
                        style: TextStyle(color: Colors.orange[800],
                          fontFamily: "mirza",
                          fontSize: 15,),)
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }
      else{
        return null;
      }

    }


    )
    )

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
                accountName: Text('${widget.teacher.fullname}',style: TextStyle(color: Colors.white,fontFamily: "mirza2",fontSize: 26.0),),
                accountEmail: Text('${widget.teacher.email}',style: TextStyle(color: Colors.white,fontFamily: "mirza2",fontSize: 18.0),),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    radius: 28.0,
                    backgroundImage:
                    NetworkImage("${widget.teacher.teacherImage}"),
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
                  title: Text('معلومات حسابي',style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.person,color: Colors.orange[500],),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('طلابي',style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.shopping_basket,color: Colors.orange[500],),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('الغيابات',style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.dashboard,color: Colors.orange[500],),
                ),
              ),

              InkWell(
                onTap: (){

                  nav();

                },
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
          onPressed: (){




          },

          tooltip: 'تسجيل الدخول',
          backgroundColor: Colors.orange[500],
          child:
          Icon(FontAwesomeIcons.pencilAlt,color: Colors.blueGrey[700],),
          elevation: 2.0,
        ),

        bottomNavigationBar : new Theme(

          data:Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blueGrey[700]),
          child:new BottomNavigationBar (

            items:  <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down,color:Colors.blueGrey[700] ,),
                title: Text('',style: TextStyle(color:Colors.blueGrey[700] , ),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down,color:Colors.blueGrey[700] ,),
                title:  Text('',style: TextStyle(color:Colors.blueGrey[700] , ),),
              ),

            ],
            onTap: null,
          ),
        )
    );



  }

  void _navigateToStudentInformation(BuildContext context,Student student)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => StudentInformation(student)),
    );

  }
  nav(){
    Navigator.of(context).pushNamed('/widget');
  }




}





















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