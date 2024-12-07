import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/Screeens/Auth/OpenEmail.dart';
import 'package:spotify_clone/Screeens/view/Dashboard.dart';

class Forget extends StatelessWidget {
  const Forget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 130),
                    child: InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Create account',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'What\'s your email address?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey[900],
                  child: TextFormField(),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'We\'ll send you a login link',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(onTap: (){
                Get.to(OpenEmail());

              },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[800],
                  ),
                  child: Center(
                      child: Text(
                        'Get link',
                        style: TextStyle(color: Colors.grey[900],fontSize: 20,fontWeight: FontWeight.bold),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
