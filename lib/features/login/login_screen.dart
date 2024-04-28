import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_assignment_1/core/routes/app_router.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';
import 'package:mobile_assignment_1/core/utils/default_button.dart';
import 'package:mobile_assignment_1/core/utils/default_form_field.dart';
import 'package:mobile_assignment_1/core/utils/default_text_button.dart';
import 'package:mobile_assignment_1/core/utils/showtoast.dart';
import 'package:mobile_assignment_1/core/utils/validations.dart';
import 'package:mobile_assignment_1/features/home/widgets/custom_input_field.dart';
import 'package:mobile_assignment_1/features/login/cubit/cubit.dart';
import 'package:mobile_assignment_1/features/login/cubit/states.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            print('---------------------> from log in getuserdate');
            print('state from login screen --> ${state.toString()}');
            CacheHelper.saveData(key: 'token', value: AppConst.token).then((value) {
              context.go(AppRouter.kHomeView);
              print('Logged in Succesfully');

            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        // Text(
                        //   'login now to browse our hot offers',
                        //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        // ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomInputField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'E-mail',
                            val: value,
                            fieldType: ValidationType.email,
                          ),
                          label: 'E-mail',
                          icon: Icons.email_rounded,
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),

                        CustomInputField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,

                          validate: (value) => checkFieldValidation(
                            fieldName: 'Password',
                            val: value,
                            fieldType: ValidationType.password,
                          ),
                          label: 'Password',
                          icon: Icons.lock_rounded,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),

                        ConditionalBuilder(
                          condition: state is LoginLoadingState,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          fallback: (context) => defaultButton(
                            function: ()async{
                              if (formkey.currentState!.validate()) {
                                await LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                print('--->>> ${AppConst.token}');
                                print('--->>> ${AppConst.userProfile!.toJson().toString()}');

                              }
                            },
                            text: 'Login',
                          ),
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                context.push(AppRouter.kRegisterView);
                              },
                              text: 'Register',
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
        },
      ),
    );
  }
}
