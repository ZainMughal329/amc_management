import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import 'index.dart';

class sendFile extends GetView<sendFileController> {
   String img, name, email, recieverId;

  sendFile(
      {super.key,
      required this.name,
      required this.img,
      required this.email,
      required this.recieverId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context,index){
                  return Text(index.toString());
            })),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller:  controller.state.messageController,
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 10),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(right: 15),
                            suffixIcon:InkWell(
                              onTap: (){
                               controller. sendMessage();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.lightActiveIconColor,
                                  child: Icon(Icons.send,color:Colors.white),
                                ),
                              ),
                            ),
                            hintText: 'enter your message',
                            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height:0,color: AppColors.titleTextColor.withOpacity(0.8)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightActiveIconColor),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.unActiveIconColor),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.warningColor),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightTextFormFieldColor),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),

                          ),
                        ),
                      ],
                    ),
                  )),

                ],
              ),
            )

          ],

        ),
      ),
    );
  }
}
