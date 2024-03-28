import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_search_dto.dart';

import '../../Model/api_response_dto.dart';
import '../../Model/invent_sum_dto.dart';
import '../../Model/paged_list_dto.dart';
import '../../Model/purch_line_dto.dart';
import '../../Model/purch_table_dto.dart';
import '../../Model/purch_table_search_dto.dart';

abstract class GMKSMSServiceGroupDAL {
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto);
  // get a file from server as blob
  Future<String> getImageFromNetworkUri(String networkUri);
  Future<String> getImageWithResolutionFromNetworkUri(String networkUri, int maxLength);
  Future<ApiResponseDto<PagedListDto<PurchTableDto>>> getPurchTablePagedList(int pageNumber, int pageSize, PurchTableSearchDto dto);
  Future<ApiResponseDto<List<PurchLineDto>>> getPurchLineList(String purchId);
  Future<ApiResponseDto<PagedListDto<WMSLocationDto>>> getWMSLocationPagedList(int pageNumber, int pageSize, WMSLocationSearchDto dto);
  Future<ApiResponseDto<PurchTableDto>> getPurchTable(String purchId);
  Future<ApiResponseDto<List<InventSumDto>>> getInventSumList(InventSumSearchDto dto);
}