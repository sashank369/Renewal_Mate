import 'package:flutter/material.dart';
import 'package:renewal_mate/Welcome_page.dart';
import 'AddDeadline.dart';
import 'Welcome_page.dart';
import 'Services.dart';

class HomePage extends StatefulWidget {
  @override
  final Services services;
  const HomePage({super.key, required this.services});
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  // Future<void> signOut() async {
  //   await _auth.signOut();
  // }
  Future<void> fetchRemainders() async {
    await widget.services.getRemainder();
    setState(() {});
  }

  Future<void> fetchUpcomingRemainders() async {
    await widget.services.upcomingRemainder();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        // backgroundColor: Colors.blue,
        title: Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/looogo.png',
              width: 165,
              height: 160,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Manage your subscription',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDeadline(services: widget.services),
                ),
              ).then((_) {
                
                fetchRemainders();
                fetchUpcomingRemainders();
              });
            },
            child: Text('Add New DeadLine'),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Today's Reminders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: widget.services.getRemainder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No reminders available'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var reminder = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 250,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Type: ${reminder['type']}',
                                      style: TextStyle(fontSize: 16)),
                                  Text('Name: ${reminder['name']}',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Upcoming Deadlines',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              
              future: widget.services.upcomingRemainder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No upcoming deadlines available'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var deadline = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 250,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Type:  ${deadline['type']}',
                                      style: TextStyle(fontSize: 16)),
                                  Text('Name:  ${deadline['name']}',
                                      style: TextStyle(fontSize: 16)),
                                  Text('Deadline:  ${deadline['date']}',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Services().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
            child: Text('Log Out'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
