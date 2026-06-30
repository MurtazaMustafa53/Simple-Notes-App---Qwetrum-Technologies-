import 'package:flutter/material.dart';
import 'package:staticnotes/Model/Customcard.dart';
import 'package:staticnotes/Veiw/Screens/Notes/NotesScreen.dart';
import 'package:staticnotes/Veiw/Screens/countryListScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen",style: TextStyle(fontWeight: FontWeight.bold),),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    Customcard(
                      title: "Country Lists",
                      icon: Icons.public,
                      color: Colors.lightGreen,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => (Countrylistscreen())),
                        );
                      },
                    ),
                    Customcard(
                      title: "Notes",
                      icon: Icons.list,
                      color: Colors.lightGreen,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => (NotesScreen())),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
