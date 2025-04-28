import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';
import 'package:protocol_app/models/responses/auth_response_model.dart';
import 'package:protocol_app/models/responses/error_response_model.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';
import 'package:protocol_app/pages/login_header.dart';
import 'package:protocol_app/providers/auth_provider.dart';
import 'package:protocol_app/utilities/overlay_service.dart';
import 'package:protocol_app/utilities/text_field_validator.dart';
import 'package:protocol_app/widgets/standard_field_with_label_widget.dart';
import 'package:protocol_app/widgets/text_button_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  // TextEditingController _startTimeController = TextEditingController();
  // TextEditingController _endTimeController = TextEditingController();

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      OverlayService.showOverlayStatus('Please fix the errors in the form.',
          status: false);
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final result = await authProvider.login(
      _emailController.text,
      _passWordController.text,
    );

    if (result is AuthResponseModel) {
      _formKey.currentState!.reset();
      OverlayService.showOverlayStatus(result.message, status: true);
      context.go('/event');
    } else if (result is ErrorResponseModel) {
      String errorMessage = '';

      if (result.errors.isNotEmpty) {
        result.errors.forEach((key, value) {
          if (value is List) {
            errorMessage += '$key: ${value.join(', ')}\n';
          } else if (value is String) {
            errorMessage += '$key: $value\n';
          } else {
            errorMessage += '$key: $value\n'; // Handle other potential types
          }
        });
      } else {
        errorMessage =
            'Login failed. Please check your credentials.'; // Generic error if no specific errors
      }

      OverlayService.showOverlayStatus(errorMessage.trim(), status: false);
    } else {
      OverlayService.showOverlayStatus('anUnexpectedErrorOccurred',
          status: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(whiteColor),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color(blackColor).withAlpha((0.05 * 255).round()),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              border: const Border(
                bottom: BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside),
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: const Color(blueColor),
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
                          const LoginHeader(
                            title: loginTitleKh,
                            description: loginDescriptionKh,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          StandardFieldWithLabelWidget(
                            controller: _emailController,
                            label: 'Email',
                            placeholder: 'example@gov.kh',
                            isOptional: false,
                            inputType: TextFieldTypeEnum.email,
                            validator: TextFieldValidator.emailValidator,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          StandardFieldWithLabelWidget(
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
                                  btnAction: () => _onSubmit(),
                                  btnTitle: loginKh,
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
        ),
      ),
    );
  }
}
