
import 'dart:async';
import 'dart:math';

import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/flutter_local_notification.dart';
import 'package:flutter_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> habits = [];
    List<String> habitDescription = [];

 final List<Color> backgroundColors = [
  const Color.fromARGB(255, 255, 234, 233),
  const Color.fromARGB(255, 227, 243, 255),
  const Color.fromARGB(255, 230, 255, 231),
  const Color.fromARGB(255, 255, 245, 230), // Light orange
  const Color.fromARGB(255, 230, 255, 245), // Light green
  const Color.fromARGB(255, 255, 230, 245), // Light pink
  // Add more colors as needed
];

final List<Color> foregroundColors = [
  const Color.fromARGB(255, 195, 110, 110),
  const Color.fromARGB(255, 99, 146, 180),
  const Color.fromARGB(255, 169, 162, 96),
  const Color.fromARGB(255, 210, 120, 75), // Dark orange
  const Color.fromARGB(255, 75, 210, 120), // Dark green
  const Color.fromARGB(255, 210, 75, 120), // Dark pink
  // Add more colors as needed
];
final List<Color> darkModeBackgroundColors = [
  const Color.fromARGB(255, 128, 117, 116),
  const Color.fromARGB(255, 113, 121, 128),
  const Color.fromARGB(255, 115, 128, 116),
  const Color.fromARGB(255, 128, 122, 115), // Dark orange
  const Color.fromARGB(255, 115, 128, 122), // Dark green
  const Color.fromARGB(255, 128, 115, 122), // Dark pink
  // Add more colors as needed
];

final List<Color> darkModeForegroundColors = [
  Color.fromARGB(255, 249, 204, 204),
  Color.fromARGB(255, 198, 225, 244),
  Color.fromARGB(255, 255, 250, 195),
  Color.fromARGB(255, 250, 208, 187), // Dark orange
  Color.fromARGB(255, 187, 238, 204), // Dark green
  Color.fromARGB(255, 246, 186, 206), // Dark pink
  // Add more colors as needed
];



   final List<String> motivationalQuotes = [
    'The only way to do great work is to love what you do.',
    'Believe you can and you’re halfway there.',
    'Don’t watch the clock; do what it does. Keep going.',
    "Success is found in the daily repetition of small actions. Keep showing up, keep putting in the effort, and eventually, you'll reach your goals.",
"Every habit you build is like a brick in the foundation of your future. With each consistent action, you're laying the groundwork for a stronger, better version of yourself.",
"Change doesn't happen overnight, but every small step you take towards building better habits brings you closer to your dreams. Stay patient, stay consistent, and trust the process.",
"Your habits shape your destiny. By making positive choices every day, no matter how small, you're actively shaping the life you want to live. Embrace the power of your habits.",
"Building habits is like investing in yourself. Each action you take towards your goals is a deposit into your future success. Keep investing, keep growing, and watch your life transform.",
"The road to success is paved with consistent effort and determination. Stay focused on your habits, even when it's tough, and know that every step forward brings you closer to your dreams.",
"The journey of a thousand miles begins with a single step. Your habits are the steps that lead you towards your goals. Keep taking those steps, no matter how small, and you'll get there.",
"In the battle between who you are and who you want to be, your habits are the deciding factor. Choose your habits wisely, nurture them daily, and watch yourself evolve into the person you aspire to become.",
"Life is a series of choices, and your habits are the foundation of those choices. By cultivating positive habits, you're setting yourself up for a life filled with success, fulfillment, and happiness.",
"It's not about being perfect; it's about making progress. Every time you choose to prioritize your habits, you're moving closer to the life you desire. Keep moving forward, one habit at a time.",
    // Add more quotes as needed
  ];
 final Random _random = Random();
 final Random random = Random();
String getRandomQuote() {
  int quoteIndex = _random.nextInt(motivationalQuotes.length);
  return motivationalQuotes[quoteIndex];
}
String randomQuote =   '';

Timer _timer = Timer(const Duration(milliseconds: 1), () {});

void updateQuote() {
  setState(() {
    randomQuote = getRandomQuote();
  });
}

void loadDarkMode() async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      isDarkModeEnabled.value = prefs.getBool('theme') ?? false;
    });
  }
bool completedTutorial = false;

@override
void initState() {
    randomQuote = getRandomQuote();
  super.initState();
  loadDarkMode();
  loadHabits();
  isTutorialCompleted();
 }

@override
void dispose() {
  _timer.cancel(); // Don't forget to dispose the timer when you're done
  super.dispose();
}
void isTutorialCompleted() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 completedTutorial = prefs.getBool('completedTutorial') ?? false;
}
  
  void loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      habits = prefs.getStringList('habits') ?? [];
      habitDescription = prefs.getStringList('habitDescription') ?? [];
    });
  }
  @override
 Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeEnabled,
builder: (context, value, child) {
    return Scaffold(
 appBar: AppBar(
   actions: [
    IconButton(
      icon: const Icon(
        Icons.settings,
      ),
      iconSize: 35,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
      }
    ),
  ],
  title:
     Column( 
        children: [ 
           completedTutorial?Container(
             child:  Text(
              'Habit Builder',
              style: TextStyle(fontSize: 25),
            
          
   ),
           ):
   Container(
   
     margin: EdgeInsets.only(left: 50),
   
     child:  Text(
              'Habit Builder',
              style: TextStyle(fontSize: 25),
            ),
          
   ),

        ],
      
    
  ),
  centerTitle: true,
 
  // Other AppBar properties...
),


      body:
       SingleChildScrollView(
   child:   Container(
        margin: const EdgeInsets.only(top: 20.0,bottom: 20), 
      child:Center(
 
   child:  Column(
    mainAxisAlignment: MainAxisAlignment.center, 
                mainAxisSize: MainAxisSize.max, 
  children: [
    const Text(
      'Track Your Habits',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
    ),
    habits.isEmpty ? Container( // Check if habits is empty
      margin: const EdgeInsets.only(left: 20,right: 20,top: 70,bottom: 70),
      child: Column(children:[
        const Text("Not created any habit yet?"),
        ElevatedButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateHabitPage()),
          ).then((_) => loadHabits());
        }, child: const Text("+ Create your first habit")),
      ])   
    ) : Container(), // Return an empty Container when habits is not empty
    ...habits.asMap().entries.map((entry) {
  int index = entry.key;
  String habit = entry.value;
  String habitDescription1 = '';
 if (habitDescription.isNotEmpty && index < habitDescription.length) {
     habitDescription1 = habitDescription[index];
    // rest of your code
  }    
  



  return Container(
    width: 350,
    margin:const EdgeInsets.only(top: 10,left: 20,right: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:isDarkModeEnabled.value? darkModeBackgroundColors[index % darkModeBackgroundColors.length]:backgroundColors[index % backgroundColors.length], // This is the color of the text // This is the background color of th
           foregroundColor:value? darkModeForegroundColors[index % darkModeForegroundColors.length]:foregroundColors[index % foregroundColors.length], // This is the color of the text // This is the background color of th
   // This is the color of the text
    padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10), // This is the padding
    textStyle: const TextStyle(fontSize: 20), // This is the font size
    shape: RoundedRectangleBorder( // This is the shape of the button
      borderRadius: BorderRadius.circular(15),
    ),
        ),
        onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HabitPage(
                            habit: habit,
                            habitDescription: habitDescription1,
                            onDelete: () {
                              setState(() {
                                habits.remove(habit);
                                habitDescription.remove(habitDescription1);
                              });
                            },)),
          );
        },
        
        child: Text(habit),
      ),
      );

    }).toList(),
    // Other widgets here
  
       Center(
   child: Container(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20,bottom: 20),
        margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
decoration: const BoxDecoration(
          color: Color.fromARGB(139, 157, 248, 247),

    borderRadius: BorderRadius.all(Radius.circular(15)),
    
    
  ),
    child:  
       Column( children:[
        const Text("Daily motivation:\n",
        style:TextStyle(fontWeight: FontWeight.w600),),
         Text(randomQuote,
        textAlign: TextAlign.center,
      ),
      
      ]
      ),
      ),
   ),
       
    ],
  ),
      
),
      ),
     ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateHabitPage()),
          ).then((_) => loadHabits());
        },
        child: const Icon(Icons.add),
      ),
    );
}
    );
  }
}

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final habitController = TextEditingController();
  final habitDescriptionController = TextEditingController(); // Controller for the habit description

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Habit'),
      ),
      body: Padding( // Wrap your Column in a Padding widget
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
         // Add horizontal padding
        child: Column(
          children: [
            TextField(
              controller: habitController,
              decoration: const InputDecoration(labelText: 'Habit Name'),
              maxLength: 28,
            ),
            TextField( // Add a TextField for the habit description
              controller: habitDescriptionController,
              decoration: const InputDecoration(labelText: 'Habit Motive (Visible in notifications)'),
            ),
Padding(
  padding: const EdgeInsets.all(20.0),
           child:  ElevatedButton(
              
              onPressed: () async {
                
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> habits = prefs.getStringList('habits') ?? [];
                List<String> habitDescription = prefs.getStringList('habitDescription') ?? [];

                 if(habits.contains(habitController.text)){
                   showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cant use Habit'),
            content: const Text('This habit already exists'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
                 }
                 else if(habitController.text.trim() == '' || habitDescriptionController.text.trim()== ''){
 showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cant use Habit'),
            content: const Text('Enter the habit name and description first.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
                 }
                 else{
            if(habits.length >= 6){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Habit Limit Reached'),
            content: const Text('You have exceeded the limit of habits. Try deleting some and try again.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      habits.add(habitController.text);
      habitDescription.add(habitDescriptionController.text);
      await prefs.setStringList('habits', habits);
      await prefs.setStringList('habitDescription', habitDescription);

      Navigator.pop(context);
    }         }    },
              
              child: const Text('Save Habit'),
               
            ),
),
          ],
        ),
      ),
    );
  }
}
class HabitPage extends StatefulWidget {
  final String habit;
  final String habitDescription;
  final VoidCallback onDelete;


  HabitPage({required this.habit,required this.habitDescription, required this.onDelete});

  @override
  _HabitPageState createState() => _HabitPageState();
}
class Habit {
  final String week;
  final int times;

  Habit(this.week, this.times);
}
class _HabitPageState extends State<HabitPage> {
    final ValueNotifier<CalendarFormat> _calendarFormat = ValueNotifier(CalendarFormat.twoWeeks);
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<String> _markedDates = [];
    List<String> habits = [];
        List<String> habitDescription = [];



  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    loadNotificationSetting();
    loadHabits();
ValueNotifier(CalendarFormat.month);
  _focusedDay = DateTime.now();
  _selectedDay = _focusedDay;
  _loadMarkedDates();
  }

  void loadNotificationSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('${widget.habit}_notifications') ?? false;
    });
  }
  void loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      habits = prefs.getStringList('habits') ?? [];
      habitDescription = prefs.getStringList('habitDescription') ??[];
    });
  }
 


void _loadMarkedDates() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _markedDates = prefs.getStringList('${widget.habit}_markedDates') ?? [];
}

void _markDate(DateTime date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  if (!_markedDates.contains(formattedDate)) {
    _markedDates.add(formattedDate);
  await prefs.setStringList('${widget.habit}_markedDates', _markedDates);  }
}
 void _unmarkDate(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    if (_markedDates.contains(formattedDate)) {
      _markedDates.remove(formattedDate);
await prefs.setStringList('${widget.habit}_markedDates', _markedDates);    }
  }

@override
void dispose() {
  _calendarFormat.dispose();
  super.dispose();
}

Future<void> initAutoStart() async {
  try {
    //check auto-start availability.
    var test = await isAutoStartAvailable;
    print(test);
    //if available then navigate to auto-start setting page.
    if (test == true) await getAutoStartPermission();
  } on PlatformException catch (e) {
    print(e);
  }
  if (!mounted) return;
}

 Future<List<Habit>> getWeeklyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> markedDates0 = prefs.getStringList('${widget.habit}_markedDates') ?? [];

    // Convert the strings to DateTime objects
    List<DateTime> markedDates = markedDates0.map((date) => DateFormat('yyyy-MM-dd').parse(date)).toList();

    // Sort the dates
    markedDates.sort();

    // Initialize a map to hold the count of marked dates in each week
    Map<String, int> weeklyData = {};

    for (var date in markedDates) {
      // Get the week number
      int weekNumber = ((date.day - date.weekday + 10) / 7).floor();

      // Create a key for the year and week number
      String key = '${date.year}-W$weekNumber';

      // If the key doesn't exist in the map, add it with a value of 1
      // If the key does exist in the map, increment its value
      weeklyData.update(key, (value) => value + 1, ifAbsent: () => 1);
    }

    // Convert the map to a list of Habit objects
    List<Habit> habits = weeklyData.entries.map((entry) => Habit(entry.key, entry.value)).toList();

    return habits;
  }
    TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit),
      ),
      body:SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center, 
                mainAxisSize: MainAxisSize.max, 
        children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
      child:  SwitchListTile(
  title: const Text('Enable Notifications'),
  value: notificationsEnabled,
  onChanged: (bool value) async {
    if (value) {
SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasInitAutoStart = prefs.getBool('hasInitAutoStart') ?? false;
    if (!hasInitAutoStart) {
      await selectTime(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Notifications'),
            content: const Text('You may be taken to Autostart permission to enable periodic notifications in background. Periodic notifications will be received everyday and can be disabled anytime.'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('${widget.habit}_notifications', value);
                  Navigator.of(context).pop();
                  setState(() {
                    notificationsEnabled = value;
                  });

                  if (notificationsEnabled) {
                     await Local_notification.scheduleNotification(
                      title:widget.habit,
                      body:widget.habitDescription,
                      payload: 'Your Payload',
                      id: habits.indexOf(widget.habit),
                      hour:selectedTime.hour,
                      minute: selectedTime.minute // Replace with your notification ID
                    );

  
 
        await prefs.setBool('hasInitAutoStart', true);

    await initAutoStart();
  

                    // Call the function when the switch is enabled
                 
                    // When the notification is tapped
Future selectNotification(String? payload) async {
    // Navigate to the item list screen
 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HabitPage(
                            habit: widget.habit,
                            habitDescription: widget.habitDescription,
                            onDelete: () {
                              setState(() {
                                habits.remove(widget.habit);
                                habitDescription.remove(widget.habitDescription);
                              });
                            },)),
          );  
  // Add more conditions for other types of notifications
}

                  }
                },
              ),
            ],
          );
        },
      );
    }
    else{
       SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('${widget.habit}_notifications', value);
                  setState(() {
                    notificationsEnabled = value;
                  });

                  if (notificationsEnabled) {
                    await selectTime(context);
                    await Local_notification.scheduleNotification(
                      title:widget.habit,
                      body:widget.habitDescription,
                      payload: 'Your Payload',
                      id: habits.indexOf(widget.habit),
                      hour:selectedTime.hour,
                      minute: selectedTime.minute // Replace with your notification ID
                    );

                  }
                  else{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('${widget.habit}_notifications', value);
      setState(() {
        notificationsEnabled = value;
      });
      if(!notificationsEnabled){
        await Local_notification.cancel(habits.indexOf(widget.habit)); // Replace with your notification ID

      }

                  }

    }
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('${widget.habit}_notifications', value);
      setState(() {
        notificationsEnabled = value;
      });
      if(!notificationsEnabled){
        await Local_notification.cancel(habits.indexOf(widget.habit)); // Replace with your notification ID

      }
    }
  },
),
        ),

        Container(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10,bottom: 10),
        margin: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
decoration: const BoxDecoration(
          color: Color.fromARGB(139, 157, 248, 247),

    borderRadius: BorderRadius.all(Radius.circular(15)),
),
    
       child: TableCalendar(
          
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: 
_calendarFormat.value,
  availableCalendarFormats: const {
    CalendarFormat.month: 'Month',
    CalendarFormat.twoWeeks: 'Two Weeks',
        CalendarFormat.week: 'Week',

  },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat.value != format) {
              setState(() {
                 _calendarFormat.value = format;

              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (_markedDates.contains(DateFormat('yyyy-MM-dd').format(date))) {
                return const Positioned(
                  right: 1,
                  top: 1,
                  child: Icon(Icons.check_circle, size: 12.0),
                );
              }
              return Container();
            },
          ),
        ),
        ),
         ElevatedButton(
            onPressed: () {
              setState(() {
                _markDate(DateTime.now());
              });
            },
            child: const Text('Mark Today'),
          ),
            ElevatedButton(
            onPressed: () {
              setState(() {
                _unmarkDate(DateTime.now());
              });
            },
            child: const Text('Unmark Today'),
          ),
            FutureBuilder<List<Habit>>(
            future: getWeeklyData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<charts.Series<Habit, String>> seriesList = [
                  charts.Series<Habit, String>(
                    id: 'Habits',
                    domainFn: (Habit habit, _) => habit.week,
                    measureFn: (Habit habit, _) => habit.times,
                    data: snapshot.data!,
                  ),
                ];

                return SingleChildScrollView(
                  child: Container(
                  
                    height: 200,  // Set the height to the value you want
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                      domainAxis: charts.OrdinalAxisSpec(
    viewport: charts.OrdinalViewport('Week 1', 7),  // Display from 'Week 2' and show 4 weeks at a time
  ),
  primaryMeasureAxis: const charts.NumericAxisSpec(
    viewport: charts.NumericExtents(0, 7),  // Display from 0 to 10 on the y-axis
  ),
                  ),
                ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
      Container(), Container(
       margin: const EdgeInsets.only(bottom: 10),
       
       child:  ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 250, 241, 241)), // This is the color of the button
  ),          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete this habit?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Delete'),
                      onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
List<String> habits = prefs.getStringList('habits') ?? [];
await Local_notification.cancel(habits.indexOf(widget.habit));
habits.remove(widget.habit);
await prefs.setStringList('habits', habits);
 await prefs.remove('${widget.habit}_markedDates');
widget.onDelete();
                        loadHabits();
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.of(context).pop(); // Navigate back to the previous page

                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Delete Habit'
          , style: TextStyle(
    color: Color.fromARGB(255, 252, 41, 41), // This is the color of the text
  ),),
        ),
        ),
        
       
      
    
        ],
      ),
      ),
    );
  }
}


