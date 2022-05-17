import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointmentPage extends StatefulWidget {
  List<Map<dynamic, dynamic>> services = [];
  BookAppointmentPage({required this.services});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  bool isLoading = true;
  String? uid;
  String? phonep;
  final _formKey = GlobalKey<FormState>();
  String serviceState = "";
  getData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("uid").toString();
      phonep = prefs.getString("phone").toString();
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.services);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    setState(() {
      serviceState = widget.services[0]['uid'];
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text(
          'Book Appointment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 13, right: 13),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: screenHeight * .025),
                    // const Text(
                    //   "Details",
                    //   style: TextStyle(
                    //     fontSize: 28,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(height: screenHeight * .01),
                    // Text(
                    //   "Sign up to get started!",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     color: Colors.black.withOpacity(.6),
                    //   ),
                    // ),
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: serviceState,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Select service'),
                          onChanged: (String? newValue) {
                            setState(() {
                              serviceState = newValue!;
                            });
                          },
                          items: widget.services.map(
                            (item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    serviceState = item['uid'];
                                  });
                                  print(serviceState);
                                },
                                child: Text(item['service_type']),
                                value: "${item['uid']}",
                              );
                            },
                          ).toList(),
                          // items: _Sector.map((item) {
                          //   // items: [
                          //   return DropdownMenuItem(
                          //     onTap: () {
                          //       fetchCell();
                          //       setState(() {
                          //         sectorName = item['name'];
                          //         _cellState = _Cell[0]['id'].toString();
                          //       });
                          //     },
                          //     child: Text(item['name']),
                          //     value: item['id'].toString(),
                          //   );
                          // }).toList(),
                          //  value: _myState,
                          // ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * .025),

                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(flex: 1, child: Text("".split(' ')[0])),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * .045),
                    Consumer<AuthProvider>(
                      builder: (context, value, child) => RaisedButton(
                        child: auth.loading ? Text("Loading") : Text("Save"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // _formKey.currentState!.save();
                            User? user =
                                await FirebaseAuth.instance.currentUser;
                            try {
                              setState(() {
                                value.loading = true;
                              });

                              print(value.loading);
                              auth.createDependant(
                                  // dob: selectedDate.toString(),
                                  // id_number: id_number,
                                  // gender: option,
                                  // insurance_number: ins_number,
                                  // names: names,
                                  // usersId: uid,
                                  // phone_number: phone,
                                  // usersPhoneNumber: phonep,
                                  // weight: weight
                                  );
                              setState(() {
                                value.loading = false;
                              });
                            } catch (e) {
                              print(e.toString());
                            }

                            // Navigator.pushReplacementNamed(context, SignInWithPhoneNumberAndPassword.id);

                          }
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * .045),
                  ],
                ),
              ),
      ),
    );
  }
}
