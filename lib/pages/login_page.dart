import 'package:flutter/material.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';
import 'package:protocol_app/widgets/input_field_with_label_widget.dart';
import 'package:protocol_app/widgets/text_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.only(left: 40, right: 60),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignInside),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_placeholder.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Login to your .gov.kh account or authirized email address.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      InputFieldWithLabelWidget(
                        controller: _emailController,
                        label: 'Email',
                        placeholder: 'example@gov.kh',
                        isOptional: false,
                        inputType: TextFieldTypeEnum.email,
                        iconPath: 'assets/icons/info.png',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InputFieldWithLabelWidget(
                        controller: _passWordController,
                        label: 'Password',
                        placeholder: 'Enter your password',
                        isOptional: false,
                        inputType: TextFieldTypeEnum.password,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButtonWidget(
                              isPrimary: true,
                              btnAction: () => Navigator.pop(context),
                              btnTitle: 'Login',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
