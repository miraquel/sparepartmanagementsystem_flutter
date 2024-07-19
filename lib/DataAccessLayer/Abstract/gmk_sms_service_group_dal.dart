import 'package:sparepartmanagementsystem_flutter/Model/dimension_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/vend_packing_slip_jour_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/wms_location_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/purch_table_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_ax_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_ax_dto.dart';

abstract class GMKSMSServiceGroupDAL {
  Future<ApiResponseDto<InventTableDto>> getInventTable(String itemId);
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto);
  Future<ApiResponseDto<PagedListDto<InventTableDto>>> getRawInventTablePagedList(int pageNumber, int pageSize, InventTableSearchDto dto);
  Future<ApiResponseDto<String>> getInventTableLabelTemplate(InventTableDto dto, int copies);
  Future<String> getImageFromNetworkUri(String networkUri);
  Future<String> getImageWithResolutionFromNetworkUri(String networkUri, int maxLength);
  Future<ApiResponseDto<PagedListDto<PurchTableDto>>> getPurchTablePagedList(int pageNumber, int pageSize, PurchTableSearchDto dto);
  Future<ApiResponseDto<List<PurchLineDto>>> getPurchLineList(String purchId);
  Future<ApiResponseDto<PagedListDto<WMSLocationDto>>> getWMSLocationPagedList(int pageNumber, int pageSize, WMSLocationSearchDto dto);
  Future<ApiResponseDto<WMSLocationDto>> getWMSLocation(WMSLocationDto dto);
  Future<ApiResponseDto<PurchTableDto>> getPurchTable(String purchId);
  Future<ApiResponseDto<List<InventSumDto>>> getInventSumList(InventSumSearchDto dto);
  Future<ApiResponseDto<PagedListDto<WorkOrderAxDto>>> getWorkOrderPagedList(int pageNumber, int pageSize, WorkOrderSearchDto dto);
  Future<ApiResponseDto<List<WorkOrderLineAxDto>>> getWorkOrderLineList(String workOrderHeaderId);
  Future<ApiResponseDto<List<InventLocationDto>>> getInventLocationList(InventLocationDto dto);
  Future<ApiResponseDto<List<DimensionDto>>> getDimensionList(String dimensionName);
  Future<ApiResponseDto<VendPackingSlipJourDto>> getVendPackingSlipJourWithLines(String packingSlipId);
}