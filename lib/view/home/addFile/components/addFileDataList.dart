import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../fileshow.dart';
class addFileDataList extends GetView<addFileController> {
  const addFileDataList({super.key});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: controller.state.ref.snapshots(),
          builder:(BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              return snapshot.data!.docs.length !=0?
              ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context,index){
                    return InkWell(
                      onTap: (){
                        Get.to(
                            ()=>addFileShowContainer(date: snapshot.data!.docs[index]['Date'],
                                name: snapshot.data!.docs[index]['Name'],

                                fileNum: snapshot.data!.docs[index]['FileNum'],
                                from: snapshot.data!.docs[index]['From'])

                        );
                       // Navigator.push(context, MaterialPageRoute(builder:);
                      },
                      child: Card(
                        child: Padding(padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            title:Text(snapshot.data!.docs[index]['Name'].toString()),
                            subtitle: Text(
                              snapshot.data!.docs[index]['Date'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // leading: CircleAvatar(
                            //   child:Image(image: NetworkImage(controller.imagePath.toString())),
                            // ),
                            trailing: Text(snapshot.data!.docs[index]['From'].toString(),
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    )
                    ),
                          ),
                      ),
                    ));
                  }):Container();
            }
            else if (snapshot.hasError){
              return CircularProgressIndicator();
            }
            else {
              return Container();
            }
          }),
    );
  }
}
//

