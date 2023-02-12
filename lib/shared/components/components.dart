import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

import '../../modules/news_app/web_view/web_view.dart';

Widget defaultButton
    ({
      double width = double.infinity ,
      Color backgroundColor = Colors.blue ,
      double redius = 0.0,
      required Function() function ,
      required String text ,
}){
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(redius),
    ),
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget defaultTextFormField
({
      required TextEditingController controller,
      required TextInputType keyboardType,
      Function(String value) ? onSubmit,
      required String? Function( String ? value) validation,
      Function(String value) ? onChange,
      required String fieldName,
      required IconData prefixIcon,
      IconData ? suffixIcon,
      Function() ? onPressedSuffixIcon,
      bool obscureText = false,
      Function() ? onTap,
      int ? maxLines = 1,
      int ? minLines,
      bool isClickable = true,
}){
  return TextFormField(
    onTap: onTap,
    enabled: isClickable,
    minLines: minLines,
    maxLines: maxLines,
    obscureText: obscureText,
    controller: controller,
    keyboardType: keyboardType,
    onFieldSubmitted: onSubmit,
    validator: validation,
    onChanged: onChange,
    decoration: InputDecoration(
      labelText: fieldName,
      border: OutlineInputBorder(),
      prefixIcon: Icon(
          prefixIcon
      ),
      suffixIcon: IconButton(
        onPressed: onPressedSuffixIcon,
        icon: Icon(
            suffixIcon
        ),
      ),
    ),
  );
}

Widget buildTaskItem({required Map model}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(model['time']),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              model['data'],
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildArticleItem({ required BuildContext context ,required String ? image , required String ? title , required String ? date ,required String url}){

  return InkWell(
    onTap: (){
      navigateTo(context: context , widget: WebViewScreen(url: url));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      '$image',
                    ),
                    fit: BoxFit.cover,

                  )
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '$title',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '$date',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void navigateTo({required BuildContext context , required Widget widget}){
  Navigator.push(
      context ,
      MaterialPageRoute(
          builder: (context) => widget
      ),
  );
}

void navigateAndFinish({required BuildContext context , required Widget widget}){
  Navigator.pushReplacement(
    context ,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Widget defaultTextButton ({required String text , required Function() function}){
  return TextButton(
    child: Text(
      text.toUpperCase(),
    ),
    onPressed: function,
  );
}

void showToast({
  required String text,
  required ToastStates toastStates
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(toastStates),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates{ SUCCESS , ERROR , WARNING }

Color chooseToastColor(ToastStates toastStates){
  late Color color;
  switch(toastStates){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required String title,
  required BuildContext context,
  List<Widget> ? actions,
}){
  return AppBar(
    title: Text(
      title,
    ),
    titleSpacing: 0.0,
    actions: actions,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(IconBroken.Arrow___Left_2),
    ),
  );
}