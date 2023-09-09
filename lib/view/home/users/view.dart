import 'package:amc_management/view/home/users/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      leading: Text(snapshot.data!.docs[index]['Email'].toString()),
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

// ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context , index){
//                     return Card(
//                       child: ListTile(
//                         title: Text(
//                           snapshot.data!.docs[index]['UserName'].toString(),
//                         ),
//                         leading: Text(snapshot.data!.docs[index]['Email'].toString()),
//                       ),
//                     );
//                   });
//
//

// if(controller.state.auth.currentUser.toString()==snapshot.data('id').toString()){
//             return Container();
//           }else{

// FirebaseAnimatedList(
// query: controller.state.ref,
// itemBuilder: (context, snapshot, animation, index) {
// //is condition ka kam ha ka jo user login ha uski id show na krwae uer list bki sary krwa de
//
// }else{
// return Card(
// child: ListTile(
// title: Text(snapshot.child('username').value.toString()),
// subtitle: Text(snapshot.child('email').value.toString()),
// leading: Container(
// height: 40,
// width: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// border:
// Border.all(color: AppColors.primaryIconColor)),
// child: snapshot.child('profile').value.toString() == ""
// ? Icon(Icons.person_2_outlined)
//     : ClipRRect(
// borderRadius: BorderRadius.circular(50),
// child: Image(
// fit: BoxFit.cover,
// image: NetworkImage(
// snapshot.child('profile').value.toString()),
// ),
// ),
// )));
// }
// }),
//



//{
//           if(!snapshot.hasData)
//           {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final users = controller.state.auth.currentUser;
//           return ListView.builder(
//               itemCount: users.lenght,
//               itemBuilder:(context, index){
//                 final user = users[index];
//           } );
//         },