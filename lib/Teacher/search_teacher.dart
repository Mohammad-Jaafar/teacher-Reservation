import 'package:hire_itc/Teacher/teacher_information.dart';
import 'package:hire_itc/model/Teacher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_admob/firebase_admob.dart';


class TeacherSearch extends StatefulWidget {
  TeacherSearch({this.teacher});
  List<Teacher> teacher;

  @override
  State createState() => new TeacherSearchState(teacher:teacher);
}

class TeacherSearchState extends State<TeacherSearch> {
  TeacherSearchState({this.teacher});
  List<Teacher> teacher;
  var isLoading = false;
  var isLoading2 = false;
  initState() {

    super.initState();
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 3),()=>

        setState(() {
          isLoading = false;
        })
    );




  }



  @override
  Widget build(BuildContext context) {

//    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7088950138718928~5889247318").then((response){
//      myInterstitial..load()..show();
//
//    });

   // RewardedVideoAd.instance.load(adUnitId: ,targetingInfo: );



    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('ابحث عن مدرسك',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: 'Mirza2'),),
          backgroundColor: Colors.blueGrey[700],

          centerTitle:true ,
        ),


        body: Center(

          child: isLoading
              ? Center(
            child: SizedBox(child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey[800]),),width: 25.0,height: 25.0,),
          )
              : ListView.builder(
              itemCount: teacher.length,
              padding: EdgeInsets.only(top: 12.0,bottom: 13.0),
              itemBuilder: (context , position){
                return Column(
                  children: <Widget>[
                    Card(
                      child: Row (
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                                contentPadding: EdgeInsets.all(10.0),

                                title: Text(
                                  '${teacher[position].fullname} ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                      fontFamily: 'Mirza',
                                  ),
                                ),

                                subtitle:  Text(
                                  '${teacher[position].details}',
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
                                       NetworkImage("${teacher[position].teacherImage}"),
                                      backgroundColor: Colors.transparent,
                                    ),


                                  ],
                                ),
                                onTap:  () {}
                            ),),

                           new Column(

                             children: <Widget>[

                          new SizedBox(

                              child:MaterialButton(
                                  shape: new RoundedRectangleBorder(
                                 borderRadius: new BorderRadius.circular(30.0)),
                                  color: Colors.blueGrey[600],
                                  splashColor: Colors.orange[500],
                                  textColor: Colors.orange[500],
                                  child: Row(
                                    children: <Widget>[
                                      Text(" احجز هنا  ",style: TextStyle(color: Colors.white,fontSize: 15.0,fontFamily: 'Mirza'),),


                                      new Icon(FontAwesomeIcons.solidArrowAltCircleRight),
                                    ],
                                  ),
                                  onPressed: (){
                                    _navigateToTeacherInformation(context, teacher[position] );
                                  }
                              )),

                               Text(' مدرس ${teacher[position].subject}  ',style: TextStyle(color: Colors.orange[800],fontFamily: "mirza",fontSize: 15,),)
                             ],
                           ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          ),
        ),





        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: (){},

          tooltip: 'ابحث عن مدرسك',
          backgroundColor: Colors.orange[500],
          child:
          Icon(FontAwesomeIcons.search,color: Colors.blueGrey[700],),
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

  void _navigateToTeacherInformation(BuildContext context,Teacher teacher)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TeacherInformation(teacher)),
    );

  }


}
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);



//BannerAd myBanner = BannerAd(
//  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//  // https://developers.google.com/admob/android/test-ads
//  // https://developers.google.com/admob/ios/test-ads
//  adUnitId: "ca-app-pub-3940256099942544/1033173712",
//  size: AdSize.smartBanner,
//  targetingInfo: targetingInfo,
//  listener: (MobileAdEvent event) {
//    print("BannerAd event is $event");
//  },
//);


InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-7088950138718928/7023678668",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);













