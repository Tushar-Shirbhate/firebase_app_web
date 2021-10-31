import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_web/Custom/TodoCard.dart';
import 'package:firebase_app_web/pages/AddToDo.dart';
import 'package:firebase_app_web/pages/view_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
          FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black87,
        appBar:AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
          ),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
            SizedBox(
              width: 25
            )
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(
                    "Monday 21",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                    IconButton(
                        onPressed: (){
                         var instance = FirebaseFirestore.instance
                              .collection("Todo");
                         for(int i=0; i<selected.length; i++){
                       //   instance.
                         }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 28,
                        )
                    ),
                ]
                ),
              )
            ),
            preferredSize: Size.fromHeight(35),
          )
        ),
          bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 32,
                    color: Colors.white
                  ),
                title: Container()
              ),BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AddToDoPage()));
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigoAccent,
                            Colors.purple
                          ]
                        )
                      ),
                      child: Icon(
                        Icons.add,
                        size: 32,
                        color: Colors.white
                      ),
                    ),
                  ),
                title: Container()
              ),BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 32,
                    color: Colors.white
                  ),
                title: Container()
              ),
            ]
      ),
        body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                Map<String, dynamic> document =
                (snapshot.data! as QuerySnapshot).docs[index].data() as Map<String, dynamic>;
                switch (document["Category"]) {
                  case "Work":
                    iconData : Icons.run_circle_outlined;
                    iconColor : Colors.red;
                    break;
                    case "WorkOut":
                    iconData : Icons.alarm;
                    iconColor : Colors.teal;
                    break;
                    case "Food":
                    iconData : Icons.local_grocery_store;
                    iconColor : Colors.blue;
                    break;
                  case "Design":
                    iconData : Icons.audiotrack;
                    iconColor : Colors.green;
                    break;
                    default:
                    iconData : Icons.run_circle_outlined;
                    iconColor : Colors.red;
                }
                selected.add(Select(id: (snapshot.data! as QuerySnapshot).docs[index].id, checkValue: false));
                return InkWell(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ViewData(
                      document: document,
                      id: (snapshot.data! as QuerySnapshot).docs[index].id,
                    )));
                  },
                  child: TodoCard(
                      title: document["ttile"] == null
                              ? "Hey There"
                              : document["ttile"],
                      check: selected[index].checkValue,
                      iconBGColor: Colors.white,
                      iconColor:  iconColor,
                      iconData: iconData,
                      time: "10 AM",
                      index: index,
                    onChange: onChange,
                  ),
                );
            }
            );
          }
        ),
      );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select{
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}

