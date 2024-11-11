import 'package:barber/features/add_service/firebase_sevice_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/sevice_model.dart';

part 'get_service_state.dart';

class GetServiceCubit extends Cubit<GetServiceState> {
  GetServiceCubit({required this.firebaseSeviceHelper})
      : super(GetServiceInitial());
  FirebaseSeviceHelper firebaseSeviceHelper;
  List<SeviceModel> services = [];

  Future<void> getAllData() async {
    emit(GetServiceLoading());
    try {
      services = await firebaseSeviceHelper.getAllData();
      emit(GetServiceSuccess(services));
    } catch (e) {
      emit(GetServiceError(e.toString()));
    }
  }
}
