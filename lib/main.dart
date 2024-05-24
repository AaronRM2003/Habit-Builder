import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/flutter_local_notification.dart';
import 'package:flutter_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  Local_notification.init();

 SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeEnabled.value = prefs.getBool('theme') ?? false;

  runApp( const MyApp());
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
Timer _timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), navigateToHomePage);
  }

  void navigateToHomePage() {
    if (mounted) {
      Navigator.of(context).pushReplacement(_createRoute(const HomePage()));
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // ... rest of your code ...



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/ic_launcher.png',scale: 4,),
         // Replace with your logo
      ),
    );
  }
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

 
 @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeEnabled,
builder: (context, value, child) {

  return MaterialApp(
    title: 'Habit Builder',
    darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF253341)),
        scaffoldBackgroundColor: const Color(0xFF15202B),
      ),
      themeMode: value ? ThemeMode.dark : ThemeMode.light,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: FutureBuilder<bool>(
      future: isTutorialCompleted(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading spinner while waiting
        } else {
          if (snapshot.data == false) { // Tutorial not completed
            return  const Page1();
          } else { // Tutorial completed
            return  SplashScreen();
          }
        }
      },
    ),
  );
   } );
 }
}

Future<void> completeTutorial() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('completedTutorial', true);
}

// Call this function to check if the tutorial is completed
Future<bool> isTutorialCompleted() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool completedTutorial = prefs.getBool('completedTutorial') ?? false;
  return completedTutorial;
}
 page(context)async{
bool tutorialCompleted = await isTutorialCompleted();
if (!tutorialCompleted) {
  Navigator.of(context).push(_createRoute( SplashScreen()));
} else {
  Navigator.of(context).push(_createRoute( SplashScreen()));
}
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      
      ),
     body: Container(
        margin: const EdgeInsets.all(20.0), // Add margin to the container
        child: const Center(
          child: Text(
'Hello, Welcome to Habit Builder! ',
          style: TextStyle(
           fontSize: 15.0, // Increase the font size
            ),
            textAlign: TextAlign.justify, // Justify the text
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(

        onPressed: () {
         Navigator.of(context).pushReplacement(_createRoute(const Page2()));
        },
        child: const Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }
}

Route _createRoute(Widget destinationPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0), // Add margin to the container
        child: const Center(
          child: Text(
'On average, it takes about 66 days for a new behavior to become automatic and ingrained as a habit, although this can vary widely depending on the individual and the complexity of the habit.  ',
          style: TextStyle(
            
           fontSize: 15.0, // Increase the font size
            ),
            
            textAlign: TextAlign.justify, // Justify the text
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.of(context).pushReplacement(_createRoute(const Page3()));
        },
        child: const Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }
}
class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0), // Add margin to the container
        child: const Center(
          child: Text(
"Environmental cues play a significant role in habit formation. Simple changes to one's environment, such as rearranging furniture or placing reminders in strategic locations, can help reinforce desired habits. ",
          style: TextStyle(
           fontSize: 15.0, // Increase the font size
            ),
            textAlign: TextAlign.justify, // Justify the text
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.of(context).pushReplacement(_createRoute(const Page4()));
        },
        child: const Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }
}
class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0), // Add margin to the container
        child: const Center(
          child: Text(
" Consistency is crucial for habit formation. Even small, incremental actions done consistently over time can lead to significant changes in behavior and mindset. ",
          style: TextStyle(
           fontSize: 15.0, // Increase the font size
            ),
            textAlign: TextAlign.justify, // Justify the text
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.of(context).pushReplacement(_createRoute(const Page5()));
        },
        child: const Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }
}
class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: Container(
        margin: const EdgeInsets.all(20.0), // Add margin to the container
        child: const Center(
          child: Text(
'Lets try our best to build the habit!',
          style: TextStyle(
           fontSize: 15.0, // Increase the font size
            ),
            textAlign: TextAlign.justify, // Justify the text
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          completeTutorial();
         Navigator.of(context).pushReplacement(_createRoute(const HomePage()));
       },
        child: const Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }
}
ValueNotifier<bool> isDarkModeEnabled = ValueNotifier(false);
class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();

}

class _SettingsPage extends State<SettingsPage> {
   
 @override
  void initState() {
    super.initState();
    loadDarkMode();
  }
  void loadDarkMode() async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      isDarkModeEnabled.value = prefs.getBool('theme') ?? false;
    });
  }
  /*
  void _launchURL() async {
  var url = Uri(scheme: 'mailto',
  path: 'aaronmathew480@gmail.com',
  queryParameters: {
    'subject': 'Feedback',
    'body': 'Enter your feedback here',
  },);
  if (await canLaunchUrl(url )) {
    await launchUrl(url );
  } else {
    throw 'Could not launch $url';
  }
}*/
final Uri _url = Uri.parse('mailto:aaronmathew480@gmail.com?subject=Feedback&body=');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: const Text('Settings'),
      ),
      
     body:SingleChildScrollView(child: Column(
     children: [ Container(
        margin: const EdgeInsets.only(top: 20.0,bottom: 20,left: 20), // Add margin to the container
       
          child: SwitchListTile(title: const Text('Dark Theme'),value: isDarkModeEnabled.value, onChanged: (bool value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
               await prefs.setBool('theme',value) ;

               setState(() {
      isDarkModeEnabled.value = prefs.getBool('theme') ?? false;
    });

    
    })
        
      ),
       Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
      child:  const Column(
      children:[ 
       ExpansionTile(
            
            title: Text('About Habit Builder'),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Habit Builder is a personal development app designed with one goal in mind: to help you build better habits. We believe that small, consistent actions can lead to big changes over time, and we\'re here to support you every step of the way.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Our Mission'),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Our mission is to provide a simple, effective, and user-friendly platform that encourages and motivates users to adopt positive habits and let go of the negative ones. We aim to empower individuals to take control of their daily routines and ultimately, their lives.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Features'),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Habit Builder offers a range of features designed to make habit tracking easy and enjoyable. From personalized reminders to insightful statistics, we\'ve got everything you need to stay motivated and consistent.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Privacy'),
            children: <Widget>[
              ListTile(
                title: Text(
                  'At Habit Builder, we respect your privacy. We\'ve designed our app to collect only the data necessary to provide our services, and we never share your data with third parties.',
                ),
              ),
            ],
          ),
    


      ],
      
      ),
      
       ),
        ElevatedButton(
  onPressed:  _launchUrl,
  
  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 162, 255, 243),foregroundColor: Color.fromARGB(255, 3, 75, 71),
   shape: RoundedRectangleBorder( // This is the shape of the button
      borderRadius: BorderRadius.circular(0),

    ),
    alignment: Alignment.center
  
  ),
  
    child: const Text('Send Feedback'),

  
)
        ],
      ),
      
     
     ),
     
    );
  }
}
