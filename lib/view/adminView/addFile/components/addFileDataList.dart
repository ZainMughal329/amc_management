import 'package:amc_management/res/components/adminViewComponents/custom_card_widget.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'fileshow.dart';
import '../index.dart';
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
                            ()=>addFileShowContainer(
                              img: snapshot.data!.docs[index]['image'],
                                date: snapshot.data!.docs[index]['Date'],
                                name: snapshot.data!.docs[index]['Name'],
                                dept: snapshot.data!.docs[index]['Dept'],
                                details: snapshot.data!.docs[index]['Detail'],
                                fileNum: snapshot.data!.docs[index]['FileNum'],
                                from: snapshot.data!.docs[index]['From'])

                        );
                      },
                    child: CustomCardWidget(
                    imagePath: snapshot.data!.docs[index]['image'],
                    date: snapshot.data!.docs[index]['Date'],
                    receiverName: snapshot.data!.docs[index]['From'],
                    fileNumber: snapshot.data!.docs[index]['FileNum'],
                    fileName: snapshot.data!.docs[index]['Name'],
                    deptName: snapshot.data!.docs[index]['Dept'],
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

// Card(
//                         child: Padding(padding: EdgeInsets.all(8.0),
//                           child: ListTile(
//                             title:Text(snapshot.data!.docs[index]['Name'].toString()),
//                             subtitle: Text(
//                               snapshot.data!.docs[index]['Date'].toString(),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             // leading: CircleAvatar(
//                             //   child:Image(image: NetworkImage(controller.imagePath.toString())),
//                             // ),
//                             trailing: Text(snapshot.data!.docs[index]['From'].toString(),
//                     style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     )
//                     ),
//                           ),
//                       ),
//                     )

