import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Services.dart';


class AddDeadline extends StatefulWidget {
  @override
   final Services services;
  const AddDeadline({super.key, required this.services});
  AddDeadlineState createState() => AddDeadlineState();
}

class AddDeadlineState extends State<AddDeadline> {
  TextEditingController _name = TextEditingController();
  TextEditingController _type = TextEditingController();
  
  DateTime selectedDate = DateTime.now();
  String selectedDate_1 = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDate_1 = '${picked.day}-${picked.month}-${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        
      ),
      
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Add New Deadline',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  controller: _type,
                ),
                
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: _name,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(
                          text: selectedDate.toString().substring(0, 10)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await widget.services.AddRemainder(_type.text,_name.text, selectedDate_1);
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage(services: widget.services,)),
                    // );
                  },
                  child: Text('Add Deadline'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
