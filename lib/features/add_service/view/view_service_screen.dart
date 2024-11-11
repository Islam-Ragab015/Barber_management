import 'package:barber/features/add_service/controller/get_service_cubit/get_service_cubit.dart';
import 'package:barber/features/add_service/view/widget/add_service.dart';
import 'package:barber/features/add_service/view/widget/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/component/error_widget.dart';

class ViewServiceScreen extends StatelessWidget {
  const ViewServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<GetServiceCubit, GetServiceState>(
          builder: (context, state) {
            var cubit = context.read<GetServiceCubit>();
            if (state is GetServiceSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  if (index == state.services.length) {
                    return AddService(index: index);
                  }
                  return ServiceItem(
                    index: index,
                    service: state.services[index],
                  );
                },
                itemCount: state.services.length + 1,
              );
            } else if (state is GetServiceError) {
              return Center(
                child: CustomErrorWidget(errorMessage: state.error),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
