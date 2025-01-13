import 'package:etranzazct_test/app/routes/app_routes.dart';
import 'package:etranzazct_test/app/theme/app_colors.dart';
import 'package:etranzazct_test/app/theme/app_string.dart';
import 'package:etranzazct_test/app/theme/font_style.dart';
import 'package:etranzazct_test/app/utils/loading_screen.dart';
import 'package:etranzazct_test/app/utils/scaffold_toast.dart';
import 'package:etranzazct_test/features/auth/data/user_model.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_events.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_states.dart';
import 'package:etranzazct_test/widgets/input_textfield.dart';
import 'package:etranzazct_test/widgets/primary_button.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/routes/route_navigator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginState();
}

class _LoginState extends State<SignUpPage> {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final fnameTextEditingController = TextEditingController();
  final lnameTextEditingController = TextEditingController();
  final emailFocusNode = FocusNode();
  final fnameFocusNode = FocusNode();
  final lnameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    fnameTextEditingController.clear();
    lnameTextEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthStates>(
        listener: (context, state) {
          switch (state) {
            case UnAuthenticatedState():
              if (state.error != null) {
                showToast(state.error!, context: context);
              }
              break;
            case AuthenticatedState():
              routeAndRemoveNavigator(context, AppRoutes.home);
            case AuthProcessing():
              LoadingScreen.instance()
                  .show(text: AppString.processing, context: context);
            default:
          }
        },
        child: Form(
          key: _formstate,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: [
              SvgPicture.asset(
                'assets/images/login.svg',
                height: MediaQuery.sizeOf(context).height * .3,
              ),
              Text(
                'Sign up',
                style: AppFontStyle.boldFont(size: 40),
              ),
              SizedBox(height: 15),
              InputTextfield(
                controller: emailTextEditingController,
                focusNode: emailFocusNode,
                hint: 'Email ID',
                leading: Icon(Icons.alternate_email_sharp),
                isEmail: true,
              ),
              SizedBox(height: 15),
              InputTextfield(
                controller: fnameTextEditingController,
                focusNode: fnameFocusNode,
                hint: 'First name',
                leading: Icon(FeatherIcons.user),
              ),
              SizedBox(height: 15),
              InputTextfield(
                controller: lnameTextEditingController,
                focusNode: lnameFocusNode,
                hint: 'Last name',
                leading: Icon(FeatherIcons.user),
              ),
              SizedBox(height: 15),
              InputTextfield(
                  controller: passwordTextEditingController,
                  focusNode: passwordFocusNode,
                  hint: 'Password',
                  leading: Icon(Icons.lock),
                  obscure: true,
                  trailing: InkWell(
                      child: Text(
                    'Forgot?',
                    style: AppFontStyle.boldFont(color: Colors.black),
                  ))),
              SizedBox(height: 40),
              PrimaryButton(
                text: 'Sign up',
                onPressed: () {
                  if (_formstate.currentState?.validate() ?? false) {
                    context.read<AuthBloc>().add(SignupEvent(UserModel(
                          email: emailTextEditingController.text,
                          password: passwordTextEditingController.text,
                          firstname: fnameTextEditingController.text,
                          lastname: lnameTextEditingController.text,
                        )));
                  }
                },
                backgroundColor: AppColors.blueColor,
                foregroundColor: AppColors.white,
              ),
              SizedBox(height: 15),
              Center(
                child: Text.rich(TextSpan(
                  text: 'Already has an account? ',
                  style: AppFontStyle.normalFont(),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: AppFontStyle.boldFont(color: AppColors.blueColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => popBack(context),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
