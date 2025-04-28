import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';
import 'package:protocol_app/utilities/custom_dialog.dart' show CustomDialog;
import 'package:protocol_app/utilities/text_field_validator.dart';
import 'package:protocol_app/widgets/standard_field_with_label_widget.dart';

class AddNewEvent extends StatefulWidget {
  const AddNewEvent({super.key});

  @override
  State<AddNewEvent> createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priorityController = TextEditingController();
  final _confidentialityController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _roomController = TextEditingController();
  final _buildingController = TextEditingController();
  final _floorController = TextEditingController();
  final _acknowledgmentMessageController = TextEditingController();
  final _noteController = TextEditingController();
  final _ledByController = TextEditingController();
  final _thankYouController = TextEditingController();
  final _attachmentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priorityController.dispose();
    _confidentialityController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _roomController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _acknowledgmentMessageController.dispose();
    _noteController.dispose();
    _ledByController.dispose();
    _thankYouController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      String name = _nameController.text;
      String description = _priorityController.text;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      color: const Color(whiteColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            StandardFieldWithLabelWidget(
                              controller: _nameController,
                              label: 'Event Name',
                              placeholder: 'example@gov.kh',
                              isOptional: false,
                              inputType: TextFieldTypeEnum.text,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            StandardFieldWithLabelWidget(
                              controller: _nameController,
                              label: 'Event Name',
                              placeholder: 'example@gov.kh',
                              isOptional: false,
                              inputType: TextFieldTypeEnum.text,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _priorityController,
                                    label: 'Priority',
                                    placeholder: '',
                                    isOptional: false,
                                    inputType: TextFieldTypeEnum.radio,
                                    validator: TextFieldValidator.textValidator,
                                    options: const ['Normal', 'Urgent'],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _priorityController,
                                    label: 'Confidentiality',
                                    placeholder: '',
                                    isOptional: false,
                                    inputType: TextFieldTypeEnum.radio,
                                    validator: TextFieldValidator.textValidator,
                                    options: const [
                                      'Confidential',
                                      'Non-confidential'
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            StandardFieldWithLabelWidget(
                              controller: _dateController,
                              label: 'Date',
                              placeholder: 'DD/MM/YYYY',
                              isOptional: false,
                              inputType: TextFieldTypeEnum.date,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            StandardFieldWithLabelWidget(
                              controller: _startTimeController,
                              endTimeController: _endTimeController,
                              label: 'Time',
                              placeholder: '00:00',
                              isOptional: false,
                              inputType: TextFieldTypeEnum.time,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _locationController,
                                    label: 'Location',
                                    placeholder: 'Location',
                                    isOptional: false,
                                    inputType: TextFieldTypeEnum.longText,
                                    validator: TextFieldValidator.textValidator,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _roomController,
                                    label: 'Room',
                                    placeholder: 'Room',
                                    isOptional: true,
                                    inputType: TextFieldTypeEnum.longText,
                                    validator: TextFieldValidator.textValidator,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _buildingController,
                                    label: 'Building',
                                    placeholder: 'Building',
                                    isOptional: true,
                                    inputType: TextFieldTypeEnum.text,
                                    validator: TextFieldValidator.textValidator,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _floorController,
                                    label: 'Floor',
                                    placeholder: 'Floor',
                                    isOptional: true,
                                    inputType: TextFieldTypeEnum.text,
                                    validator: TextFieldValidator.textValidator,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                                'ឧ. ក្រសួងប្រៃសណីយ៍និងទូរគមនាគមន៍, អគារ “ក”, ជាន់ទី ៣, បន្ទប់៖ សាលប្រជុំ A3'),
                            const SizedBox(height: 24),
                            StandardFieldWithLabelWidget(
                              controller: _acknowledgmentMessageController,
                              label: 'Acknowledgment Message',
                              placeholder: 'Acknowledgment Message',
                              isOptional: false,
                              inputType: TextFieldTypeEnum.longText,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            StandardFieldWithLabelWidget(
                              controller: _noteController,
                              label: 'Noted',
                              placeholder: 'Noted Message',
                              isOptional: false,
                              inputType: TextFieldTypeEnum.longText,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            StandardFieldWithLabelWidget(
                              controller: _ledByController,
                              label: 'Led By',
                              placeholder: 'Led By',
                              isOptional: true,
                              inputType: TextFieldTypeEnum.text,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            StandardFieldWithLabelWidget(
                              controller: _thankYouController,
                              label: 'Thank You Message',
                              placeholder: '🙏Thank You Message🙏',
                              isOptional: true,
                              inputType: TextFieldTypeEnum.text,
                              validator: TextFieldValidator.textValidator,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: StandardFieldWithLabelWidget(
                                    controller: _attachmentController,
                                    label: 'Attachment',
                                    placeholder:
                                        'Please submit documents as PDF, PNG, or JPEG files, with a maximum file size of 10MB',
                                    isOptional: false,
                                    inputType: TextFieldTypeEnum.file,
                                    validator: TextFieldValidator.textValidator,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: const Text('Save'),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              CustomDialog.cancel(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
