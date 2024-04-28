import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_assignment_1/core/routes/app_router.dart';
import 'package:mobile_assignment_1/core/utils/default_button.dart';
import 'package:mobile_assignment_1/core/utils/default_form_field.dart';
import 'package:mobile_assignment_1/core/utils/showtoast.dart';
import 'package:mobile_assignment_1/core/utils/validations.dart';
import 'package:mobile_assignment_1/features/home/widgets/custom_input_field.dart';
import 'package:mobile_assignment_1/features/register/cubit/cubit.dart';
import 'package:mobile_assignment_1/features/register/cubit/states.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  var studentIdController = TextEditingController();
  var levelController = TextEditingController();
  var genderController = TextEditingController();
  var password;
  var repassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          ToastContext().init(context);
          if (state is RegisterErrorState) {
            showToast(
                massage:
                    state.error.substring(state.error.indexOf("]") + 1).trim(),
                state: ToastStates.ERROR);
          }
          if (state is CreateUserSuccessState) {
            context.go(AppRouter.kLoginView);
            print('Account created successfully' '');
            showToast(
              massage: 'Account created successfully',
              state: ToastStates.SUCCESS,
            );
          }
        },
        builder: (context, state) {
          ToastContext().init(context);
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomInputField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Full Name',
                            val: value,
                            fieldType: ValidationType.name,
                          ),
                          label: 'Name',
                          icon: Icons.person_rounded,
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          controller: studentIdController,
                          type: TextInputType.number,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'StudentID',
                            val: value,
                            fieldType: ValidationType.number,
                          ),
                          label: 'StudentID',
                          icon: Icons.numbers,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        CustomInputField(
                          controller: levelController,
                          type: TextInputType.number,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Level',
                            val: value,
                            fieldType: ValidationType.number,
                          ),
                          label: 'Level',
                          icon: Icons.numbers,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        CustomInputField(
                          controller: genderController,
                          type: TextInputType.text,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Gender',
                            val: value,
                            fieldType: ValidationType.text,
                          ),
                          label: 'Gender',
                          icon: Icons.person_rounded,
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
                          height: 15.0,
                        ),
                        CustomInputField(
                          controller: repasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Confirm Password',
                            val: value,
                            fieldType: ValidationType.confirmPassword,
                            confirmPass: passwordController.text,
                          ),
                          label: 'Confirm Password',
                          icon: Icons.lock_rounded,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is RegisterLoadingState,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          fallback: (context) => defaultButton(
                            function: () {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  studentId: studentIdController.text,
                                  level:int.parse( levelController.text),
                                  gender: genderController.text,
                                );
                                RegisterCubit.get(context).storeUserLocally(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  studentId: studentIdController.text,
                                  level:int.parse( levelController.text),
                                  gender: genderController.text,
                                );


                              }
                            },
                            text: 'REGISTER',
                            isUpperCase: true,
                          ),
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
