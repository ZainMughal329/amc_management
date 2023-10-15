

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class cardCode extends StatelessWidget {
  const cardCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 230.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50)
              ),
              color: Color(0xFF363f93)
            ),
            child: Stack(
              children: [
                Positioned(

                  top: 80,
                  left: 0,
                  child: Container(
                    height: 100.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )
                    ),
                  ),
                ),
                Positioned(
                    top: 110,
                    left: 20,
                    child:
                Text(
                  '',style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF363f93)
                ),)
                ),

              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 230.h,
            child: Stack(
              children: [
                Positioned(
                    top: 35,
                    left: 20,
                    child: Material(

                  child: Container(
                    height: 180.0.h,
                    // width: ,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      // BoxShadow(
                      //   color: Colors.grey.withOpacity(0.3),
                      //   offset: Offset(-10.0, 10.0),
                      //   blurRadius: 20.0,
                      //   spreadRadius: 4.0
                      // )
                    ),
                  ),
                )),
                Positioned(
                  top: 0,
                    left: 30,
                    child:Card(
                      elevation: 10.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Container(
                        height: 200.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(""),)
                        ),
                      ),
                    ) ),
                Positioned(
                    top: 60,
                    left: 200,
                    child: Container(
                      height: 150.h,
                      width: 160.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("",style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF363f93),
                            fontWeight: FontWeight.bold
                          ),),
                          Text("",style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),),
                          Divider(color: Colors.black,),
                          Text("",style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),),

                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
