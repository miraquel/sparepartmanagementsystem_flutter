import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/work_request_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_request_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

part 'work_request_list_provider.g.dart';

@riverpod
Future<PagedListDto<WorkRequestDto>> pagedListWorkRequest(Ref ref, PagedListRequestDto dto) async {
  final workRequestDal = locator<WorkRequestDal>();
  final workRequest = await workRequestDal.getWorkRequestPagedList(dto);

  if (workRequest.success) {
    return workRequest.data!;
  } else {
    throw Exception(workRequest.errorMessages);
  }
}
