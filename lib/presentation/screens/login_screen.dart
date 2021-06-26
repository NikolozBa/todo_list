import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/data/database_helper.dart';
import 'package:todo_list/logic/cubits/todo_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: width * 0.5,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: width * 0.4,
                  image: AssetImage('assets/logo.png'),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    style: GoogleFonts.lato(color: Colors.white),
                    controller: loginController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width*0.04,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(color: Colors.transparent)),
                        fillColor: Theme.of(context).primaryColor,
                        filled: true),
                    validator: (input) {
                      if (input == "" || input == null) {
                        return "please enter your username";
                      } else if (input.length < 4) {
                        return "your username must be at least 4 letters long";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        height: 40, width: double.infinity),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            DatabaseHelper.username = loginController.text;
                            BlocProvider.of<TodoCubit>(context).reset();
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.lato(fontSize: 20),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
