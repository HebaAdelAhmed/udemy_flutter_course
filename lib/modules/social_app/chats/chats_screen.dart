import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialLayoutCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(
                  SocialLayoutCubit.get(context).users[index],
                  context,
              ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: SocialLayoutCubit.get(context).users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        },
    );
  }

  Widget buildChatItem(SocialUserModel model , BuildContext context){
    return InkWell(
      onTap: (){
        navigateTo(context: context, widget: ChatDetailsScreen(userModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                '${model.image}'
              ),
              radius: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Hello Heba Hpssdsdsdsdsdsdm ldkfndfdnf ldnladfnlafndalf csdsdsjdnakdas dlndlasdnlasdhsdhsald ldalsdhdhal',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
