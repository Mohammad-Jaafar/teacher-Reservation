import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/walkthrough.dart';
import 'package:flutter_walkthrough/flutter_walkthrough.dart';
import 'package:hire_itc/home/choose_account.dart';
import 'package:hire_itc/home/direct_to_login.dart';


class MyWalkthrough extends StatelessWidget {

  final  List<Walkthrough> list=[
    new Walkthrough(
      title:"تذكر دوماُ ما أنت بارع فيه وتمسك به",
      content: "إذا كنت تستطيع تخيل صورة ما، يمكنك أن تجعلها واقعاً، وإذا كنت تستطيع أن تحلم يمكِنُك تحقيق حلمك",
      imageIcon: Icons.computer,
      imagecolor: Colors.amber[500],

    ),
    new Walkthrough(
      title: "لن يستطيع أحد أن يحتكر النجاح لنفسه، فالنجاح ملك من يدفع ثمنه",
      content: "إبتعد عن الأشخاص الذين يحاولون التقليل من شأن طموحاتك، فصِغار الشأن دائماً ما يفعلون ذلك ً",
      imageIcon: Icons.all_inclusive,
      imagecolor:Colors.amber[500],

    ),
    new Walkthrough(
      title: "صاحب الأشخاص الذين يمكن أن يجعلوك أفضل",
      content: "المنافسة الحقيقية دائماً ما تكون بين ما تقوم بعمله وما أنت قادر على عمله، إنك تقيس نفسك مع نفسك وليس مع أي شخص آخر",
      imageIcon: Icons.thumb_up,
      imagecolor:Colors.amber[500],

    ),

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body:new IntroScreen(
        list,

        MaterialPageRoute(builder: (context) => ChooseAccount()),





      ),
    );

  }
}