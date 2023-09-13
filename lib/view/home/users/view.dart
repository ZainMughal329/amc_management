import 'package:amc_management/view/home/users/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/colors.dart';
class userListView extends GetView<userController> {
  const userListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.state.ref,
        builder: ( BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){

            if(snapshot.hasData){
              print('if');
              return snapshot.data!.docs.length !=0?ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context,index){
                    return ListTile(
                      title: Text(snapshot.data!.docs[index]['UserName'].toString()),
                      subtitle: Text(snapshot.data!.docs[index]['Email'].toString()),
                      // trailing: PopupMenuButton(
                      //     icon: Icon(Icons.more_vert),
                      //     itemBuilder:
                      //     (context)=>[
                      //       PopupMenuItem(
                      //
                      //
                      //           child: ListTile(
                      //             onTap: (){
                      //
                      //             },
                      //         leading: Icon(Icons.delete_forever_outlined),
                      //         title: Text('delete'),
                      //       )),
                      //       PopupMenuItem(child:
                      //       ListTile(
                      //         onTap: (){
                      //           Get.back();
                      //         }
                      //         ,
                      //         leading: Icon(Icons.cancel),
                      //         title: Text('cancel'),
                      //       ))
                      //
                      // ]),
                      // leading: Container(
                      //   height: 40,
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border: Border.all(color: AppColors.primaryIconColor)
                      //   ),
                      //   child: snapshot.data!.docs[index]['profile'].toString()==""?
                      //   Icon(Icons.person_2_outlined):ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: Image(
                      //       fit: BoxFit.cover,
                      //       image: NetworkImage(
                      //         snapshot.data!.docs[index]['profile'].toString()
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    );
                  } ):Container();
            }
             else if (snapshot.hasError){
               print('else if');
              return Center(child: CircularProgressIndicator());
            }
            else{
              print('else');
            return Container(); }

        }
      )
    );
  }
}
