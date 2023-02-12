import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_data_model.dart';

class UsersScreen extends StatelessWidget {

  List<UserDataModel> userData = [
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),
    UserDataModel(name: 'Heba Adel Ahmed' , phone: '+201001394765'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemCount: userData.length,
        itemBuilder: (context , index){
          return buildUserItem(index+1, userData[index].name , userData[index].phone);
        },
        separatorBuilder: (context , index){
          return Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          );
        },
      ),
    );
  }

  Widget buildUserItem(int itemNumber , String name , String phone) => Padding(
      padding: const EdgeInsetsDirectional.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.indigo,
            child: Text(
              '$itemNumber',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
              ),
              Text(
                phone,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300
                ),
              ),
            ],
          ),
        ],
      ),
    );
}
