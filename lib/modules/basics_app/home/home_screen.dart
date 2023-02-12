import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  List<Widget> items = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text(
          'First App'
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: onSearch,
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt_rounded
            ),
            onPressed: onCamera,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      'https://cdn3.1800flowers.com/wcsstore/Flowers/images/catalog/104514mv2x.jpg?width=545&height=597&quality=80&auto=webp&optimize={medium}',
                    ),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.all(10),
                    color: Colors.black.withOpacity(0.7),
                    width: double.infinity,
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  void onCamera(){
    print('Pressed on Camera');
  }
  void onSearch(){
    print('on Search');
  }
}
