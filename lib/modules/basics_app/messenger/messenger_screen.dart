import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessengerScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/e/e7/Leucanthemum_vulgare_%27Filigran%27_Flower_2200px.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Chats',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.black
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.camera_alt_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.edit,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(end: 20.0 , start: 20 , top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  itemCount: 10,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context , index) => buildChatItem(),
                itemCount: 20,
                separatorBuilder: (context , index) => SizedBox(
                  height: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() => Padding(
    padding: const EdgeInsetsDirectional.only(end: 8.0),
    child: Container(
      width: 60,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/e/e7/Leucanthemum_vulgare_%27Filigran%27_Flower_2200px.jpg'),
              ),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 2.0 , bottom: 2),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            'Heba Adel Ahmed',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  Widget buildChatItem(){
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/e/e7/Leucanthemum_vulgare_%27Filigran%27_Flower_2200px.jpg'),
            ),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 2.0 , bottom: 2),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Heba Adel Ahmed Mohammed Diab',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18 ,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'How are you right now ? How are you right now ? How are you right now ? How are you right now ?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Colors.blue ,
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Text(
                      '02:09 AM'
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
