import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/item_requisition_dto.dart';

abstract class WorkOrderDAL {
  // Work Order Header
  Future<ApiResponseDto> addWorkOrderHeader(WorkOrderHeaderDto dto);
  Future<ApiResponseDto> addWorkOrderHeaderWithLines(WorkOrderHeaderDto dto);
  Future<ApiResponseDto> updateWorkOrderHeader(WorkOrderHeaderDto dto);
  Future<ApiResponseDto> deleteWorkOrderHeader(int id);
  Future<ApiResponseDto<WorkOrderHeaderDto>> getWorkOrderHeaderById(int id);
  Future<ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>> getAllWorkOrderHeaderPagedList(int pageNumber, int pageSize);
  Future<ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>> getWorkOrderHeaderByParamsPagedList(int pageNumber, int pageSize, WorkOrderHeaderDto entity);
  Future<ApiResponseDto<List<WorkOrderLineDto>>> getWorkOrderLineByWorkOrderHeaderId(int id);

  // Work Order Line
  Future<ApiResponseDto> addWorkOrderLine(WorkOrderLineDto dto);
  Future<ApiResponseDto> updateWorkOrderLine(WorkOrderLineDto dto);
  Future<ApiResponseDto> deleteWorkOrderLine(int id);
  Future<ApiResponseDto<WorkOrderLineDto>> getWorkOrderLineById(int id);

  // Item Requisition
  Future<ApiResponseDto> addItemRequisition(ItemRequisitionDto dto);
  Future<ApiResponseDto> updateItemRequisition(ItemRequisitionDto dto);
  Future<ApiResponseDto> deleteItemRequisition(int id);
  Future<ApiResponseDto<ItemRequisitionDto>> getItemRequisitionById(int id);
  Future<ApiResponseDto<List<ItemRequisitionDto>>> getItemRequisitionByParams(ItemRequisitionDto entity);
  Future<ApiResponseDto<List<ItemRequisitionDto>>> getItemRequisitionByWorkOrderLineId(int id);

}