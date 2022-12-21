import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/privacypolicy.dart';

class ScreenTerms extends StatelessWidget {
  const ScreenTerms({super.key});
//========================About
  Widget about(context) {
    return ListTile(
      leading: Icon(
        Icons.info,
        size: 29,
        color: Colors.white,
      ),
      title: const Text(
        'About',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        showAboutDialog(
            context: context,
            applicationName: 'Lets do',
            applicationIcon: Image.asset(
              'Asset/icons/ic_launcher.png',
              height: 45,
              width: 45,
            ),
            applicationVersion: "1.0.1",
            children: [
              const texts(
                  mystring:
                      'Lets do App is a kind of app that generally used to maintain our day-to-day tasks and schedule events. It is helpful in planning our daily routines  and events always reminds you with notification',
                  myfontsize: 16,
                  mycolor: Colors.black,
                  fontweight: FontWeight.normal),
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: texts(
                    mystring: 'App developed by Ayyubi',
                    myfontsize: 15,
                    mycolor: Colors.black,
                    fontweight: FontWeight.bold),
              )
            ]);
      },
    );
  }

//===============privacypolicy
  Widget privacypolicy(context) {
    return ListTile(
      leading: const Icon(
        Icons.privacy_tip,
        color: Colors.white,
        size: 29,
      ),
      title: const Text('Privacy policy',
          style: TextStyle(
            // height: 2,
            color: Colors.white,
            fontFamily: 'poppins',
            fontSize: 20,
            // fontWeight: FontWeight.bold
          )),
      onTap: () {
        showDialog(
            context: context,
            builder: (builder) {
              return settingmenupopup(mdFilename: 'privacy_policy.md');
            });
      },
    );
  }

//================termsandcondition
  Widget termsconditions(context) {
    return ListTile(
      leading: const Icon(
        Icons.library_books,
        color: Colors.white,
        size: 29,
      ),
      title: const Text('Terms and conditions',
          style: TextStyle(
            // height: 2,
            color: Colors.white,
            fontFamily: 'poppins',
            fontSize: 20,
          )),
      onTap: () {
        showDialog(
            context: context,
            builder: (builder) {
              return settingmenupopup(mdFilename: 'terms_and_conditions.md');
            });
      },
    );
  }

//========version
  Widget version() {
    return const texts(
        mystring: 'version \n 1.0.1',
        myfontsize: 16,
        mycolor: Colors.white60,
        fontweight: FontWeight.normal);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      height: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          about(context),
          privacypolicy(context),
          termsconditions(context),
          version()
        ],
      ),
    ));
  }
}
