import 'package:barber/constants/app_colors.dart';
import 'package:barber/core/component/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../../../core/component/custom_textformfield.dart';
import '../controller/add_service_cubit/add_service_cubit.dart';

class AddServiceScreen extends StatelessWidget {
  AddServiceScreen({super.key});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Service'),
      ),
      body: Center(
        child: BlocBuilder<AddServiceCubit, AddServiceState>(
          builder: (context, state) {
            var cubit = context.read<AddServiceCubit>();

            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => cubit.pickServiceImage(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: CustomColors.kGreyColor),
                              height: 120,
                              width: 120,
                              child: cubit.serviceImage != null
                                  ? Image.file(
                                      cubit.serviceImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.add_a_photo_outlined,
                                      size: 40),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hintText: 'Enter Name',
                          labelText: 'Name',
                          textController: cubit.nameController,
                          fieldType: TextInputType.name,
                          validator: ValidationBuilder().required().build(),
                          prefixIcon: const Icon(Icons.star_half_rounded),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: 'Enter Price',
                          labelText: 'Price',
                          textController: cubit.priceController,
                          fieldType: TextInputType.number,
                          validator: ValidationBuilder().required().build(),
                          prefixIcon: const Icon(Icons.price_check),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: 'Enter Time',
                          labelText: 'Time',
                          textController: cubit.timeController,
                          fieldType: TextInputType.number,
                          validator: ValidationBuilder().required().build(),
                          prefixIcon: const Icon(Icons.timer),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: 'Enter Descripation',
                          labelText: 'Descripation',
                          textController: cubit.descriptionController,
                          fieldType: TextInputType.text,
                          maxLines: 3,
                          validator: ValidationBuilder().required().build(),
                          prefixIcon: const Icon(Icons.description),
                        ),
                        const SizedBox(height: 20),
                        CustomBottom(
                            text: "add service",
                            isloading: !cubit.isloading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addService();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
