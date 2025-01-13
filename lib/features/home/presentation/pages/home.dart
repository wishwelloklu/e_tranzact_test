import 'package:etranzazct_test/app/routes/app_routes.dart';
import 'package:etranzazct_test/app/routes/route_navigator.dart';
import 'package:etranzazct_test/app/theme/app_colors.dart';
import 'package:etranzazct_test/app/theme/font_style.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_events.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_states.dart';
import 'package:etranzazct_test/features/home/presentation/bloc/api_image_bloc.dart';
import 'package:etranzazct_test/features/home/presentation/bloc/api_image_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthStates>(listener: (context, authState) {
        if (authState is UnAuthenticatedState) {
          routeAndRemoveNavigator(context, AppRoutes.login);
        }
      }, builder: (context, authState) {
        if (authState is AuthenticatedState) {
          return BlocBuilder<ApiImageBloc, ApiImageStates>(
              builder: (context, state) {
            switch (state) {
              case SuccessState():
                final cat = state.catModel;
                return Stack(
                  alignment: AlignmentDirectional.center,
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      cat.url,
                      height: cat.height.toDouble(),
                      width: cat.width.toDouble(),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.transparent.withOpacity(.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome ${authState.userModel.firstname}',
                            style: AppFontStyle.boldFont(
                              size: 40,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            'Todays\'s cat image is ready',
                            style: AppFontStyle.boldFont(
                                size: 20, color: AppColors.white),
                          )
                        ],
                      ),
                    )
                  ],
                );

              case ErrorState():
                return Center(
                  child: Text(state.error),
                );

              default:
                return Center(child: CircularProgressIndicator());
            }
          });
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }
}
