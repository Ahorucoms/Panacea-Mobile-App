// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetailPage extends StatefulWidget {
  const PersonalDetailPage({Key? key}) : super(key: key);

  @override
  State<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  String? names, id_number, weight, phone, ins_number;
  DateTime selectedDate = DateTime(1950);
  String? option;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? uid;
  String? phonep;
  bool isLoading = true;
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
    getData();
    uid = '';
    phonep = '';
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text(
          'Personal Details',
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

                    SizedBox(height: screenHeight * .025),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) return "required";
                        },
                        textAlign: TextAlign.justify,
                        onChanged: ((value) {
                          setState(() {
                            names = value;
                          });
                        }),
                        decoration: InputDecoration(
                          label: Text("Names"),
                          hintText: "Enter  your full names",
                          hintStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .025),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) return "required";
                        },
                        textAlign: TextAlign.justify,
                        onChanged: ((value) {
                          setState(() {
                            id_number = value;
                          });
                        }),
                        decoration: InputDecoration(
                          label: Text("ID Number"),
                          hintText: "Enter your Identity number",
                          hintStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .025),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) return "required";
                        },
                        textAlign: TextAlign.justify,
                        onChanged: ((value) {
                          setState(() {
                            weight = value;
                          });
                        }),
                        decoration: InputDecoration(
                          label: Text("Weight"),
                          hintText: "Enter your weigth",
                          hintStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .025),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) return "required";
                        },
                        textAlign: TextAlign.justify,
                        onChanged: ((value) {
                          setState(() {
                            phone = value;
                          });
                        }),
                        decoration: InputDecoration(
                          label: Text("Phone number"),
                          hintText: "Enter your phone number",
                          hintStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .025),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) return "required";
                        },
                        textAlign: TextAlign.justify,
                        onChanged: ((value) {
                          setState(() {
                            ins_number = value;
                          });
                        }),
                        decoration: InputDecoration(
                          label: Text("Insurance number"),
                          hintText: "Enter your insurance number",
                          hintStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Gender"),
                          Row(
                            children: [
                              Text("Male"),
                              Radio(
                                  value: "male",
                                  groupValue: option,
                                  onChanged: (value) {
                                    setState(() {
                                      option = value.toString();
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Female"),
                              Radio(
                                  value: "Female",
                                  groupValue: option,
                                  onChanged: (value) {
                                    setState(() {
                                      option = value.toString();
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                  "${selectedDate.toLocal()}".split(' ')[0])),
                          SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: RaisedButton(
                              onPressed: () => _selectDate(context),
                              child: Text('Select date'),
                            ),
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
                                  dob: selectedDate.toString(),
                                  id_number: id_number,
                                  gender: option,
                                  insurance_number: ins_number,
                                  names: names,
                                  usersId: uid,
                                  phone_number: phone,
                                  usersPhoneNumber: phonep,
                                  weight: weight);
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
