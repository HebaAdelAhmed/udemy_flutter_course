import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isVisiable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultTextFormField(
                    prefixIcon: Icons.email,
                    controller: emailController,
                    fieldName: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validation: (value){
                      if(value!.isEmpty) {
                        return 'Email address must be not empty';
                      } else if(!value.contains('@')) {
                        return 'Email address must have a \'@\'';
                      }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                      fieldName: 'Password',
                      obscureText: isVisiable,
                      suffixIcon: isVisiable ? Icons.visibility : Icons.visibility_off,
                      onPressedSuffixIcon: (){
                        setState(() {
                          isVisiable = !isVisiable;
                        });
                      },
                      keyboardType: TextInputType.visiblePassword,
                      validation: (value){
                        if(value!.isEmpty) {
                          return 'Password must be not empty';
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    redius: 20,
                    function: (){
                      if(formKey.currentState!.validate()){
                        print('Email: ${emailController.text} ,Password: ${passwordController.text}');
                      }
                    } ,
                    text: 'Login',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? '
                      ),
                      SizedBox(
                        width: 5,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
