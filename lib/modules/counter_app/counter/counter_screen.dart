import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit , CounterStates>(
        listener: (context, state) {
        },
        builder: (context , state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child: Text(
                      'Minuse',
                    ),
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text(
                        'pluse'
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

