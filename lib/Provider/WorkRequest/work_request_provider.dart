import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_request_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Provider/snackbar_message.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'work_request_provider.g.dart';

@riverpod
class WorkRequest extends _$WorkRequest {
  @override
  FutureOr<WorkRequestDto> build(String agseamWrId) async {
    final workRequestDal = locator<WorkRequestDal>();
    final response = await workRequestDal.getWorkRequest(agseamWrId);

    if (response.success) {
      return response.data!;
    } else {
      throw Exception(response.errorMessages);
    }
  }

  Future<void> updateAcceptedWorkRequest(WorkRequestDto dto) async {
    state = const AsyncLoading();
    final workRequestDal = locator<WorkRequestDal>();
    final response = await workRequestDal.updateAcceptedWorkRequest(dto);

    if (response.success) {
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(response.errorMessages.first);
    }
    ref.invalidateSelf();
  }

  Future<void> createWorkOrderTable(WorkRequestDto dto) async {
    state = const AsyncLoading();
    try {
      final workRequestDal = locator<WorkRequestDal>();
      final response = await workRequestDal.createWorkOrderTable(dto);

      if (response.success) {
        ref.read(snackbarMessageProvider.notifier).show(response.message);
      } else {
        ref.read(snackbarMessageProvider.notifier).show(response.errorMessages.first);
      }
    } on DioException catch (e) {
      ref.read(snackbarMessageProvider.notifier).show('Error creating work order table: ${e.response?.data["errorMessages"]?.first ?? e.message}');
    }
    ref.invalidateSelf();
  }

  Future<void> updateWorkRequest(WorkRequestDto dto) async {
    state = const AsyncLoading();
    final workRequestDal = locator<WorkRequestDal>();
    final response = await workRequestDal.updateWorkRequest(dto);

    if (response.success) {
      ref.read(snackbarMessageProvider.notifier).show(response.message);
    } else {
      ref.read(snackbarMessageProvider.notifier).show(response.errorMessages.first);
    }
    ref.invalidateSelf();
  }

  Future<bool> validateWrkCtrId(String wrkCtrId) async {
    //state = const AsyncLoading();
    final workRequestDal = locator<WorkRequestDal>();
    final response = await workRequestDal.validateWrkCtrId(wrkCtrId);

    //ref.invalidateSelf();

    if (response.success) {
      return response.data ?? false;
    } else {
      return false;
    }
  }
}