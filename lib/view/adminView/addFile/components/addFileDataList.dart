import 'package:amc_management/res/components/SessionViewComponents/elevated_button.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_card_widget.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../res/colors.dart';
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
                              img: snapshot.data!.docs[index]['images'],
                                date: DateTime.parse(snapshot.data!.docs[index]['Date'].toString()),
                                name: snapshot.data!.docs[index]['Name'],
                                dept: snapshot.data!.docs[index]['Dept'],
                                details: snapshot.data!.docs[index]['Detail'],
                                fileNum: snapshot.data!.docs[index]['FileNum'],
                                from: snapshot.data!.docs[index]['From'])

                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          // elevation: 4,
                          color: AppColors.elevatedButtonColour,// Add shadow to the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0), // Round the corners
                          ),
                          margin: EdgeInsets.all(16.0), // Margin around the card

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['Name'],
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['dept'],
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['From'],
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['FileNum'],
                                            style: TextStyle(fontSize: 16.0),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['Detail'],
                                              style: TextStyle(fontSize: 16.0)
                                          ),
                                          Text(
                                           DateTime.parse(snapshot.data!.docs[index]['Date'].toString()),
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          // elevatedButton(tittle: 'Details', onpress: (){
                                          //
                                          // })
                                        ],
                                      )
                                     




                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ) ;

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



//InkWell(
//                       onTap: (){
//                         Get.to(
//                             ()=>addFileShowContainer(
//                               img: snapshot.data!.docs[index]['images'],
//                                 date: snapshot.data!.docs[index]['Date'],
//                                 name: snapshot.data!.docs[index]['Name'],
//                                 dept: snapshot.data!.docs[index]['Dept'],
//                                 details: snapshot.data!.docs[index]['Detail'],
//                                 fileNum: snapshot.data!.docs[index]['FileNum'],
//                                 from: snapshot.data!.docs[index]['From'])
//
//                         );
//                       },
//                     child: CustomCardWidget(
//                     // imagePath: snapshot.data!.docs[index]['images'],
//                      date: snapshot.data!.docs[index]['Date'],
//                     receiverName: snapshot.data!.docs[index]['From'],
//                     fileNumber: snapshot.data!.docs[index]['FileNum'],
//                     fileName: snapshot.data!.docs[index]['Name'],
//                     deptName: snapshot.data!.docs[index]['Dept'],
//                     ))