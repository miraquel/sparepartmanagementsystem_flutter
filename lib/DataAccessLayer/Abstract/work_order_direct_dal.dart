import 'package:sparepartmanagementsystem_flutter/Model/api_response_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_req_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/paged_list_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_line_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/work_order_header_dto.dart';

abstract class WorkOrderDirectDAL {
  Future<ApiResponseDto<WorkOrderHeaderDto>> getWorkOrderHeader(String agsEamWoId);
  Future<ApiResponseDto<PagedListDto<WorkOrderHeaderDto>>> getWorkOrderHeaderPagedList(int pageNumber, int pageSize, WorkOrderHeaderDto dto);
  Future<ApiResponseDto> addWorkOrderLine(WorkOrderLineDto dto);
  Future<ApiResponseDto> updateWorkOrderLine(WorkOrderLineDto dto);
  Future<ApiResponseDto<WorkOrderLineDto>> getWorkOrderLine(String agsEamWoId, int line);
  Future<ApiResponseDto<List<WorkOrderLineDto>>> getWorkOrderLineList(String agsEamWoId);
  Future<ApiResponseDto> closeWorkOrderLineAndPostInventJournal(WorkOrderLineDto dto);
  Future<ApiResponseDto> addItemRequisition(InventReqDto dto);
  Future<ApiResponseDto> updateItemRequisition(InventReqDto dto);
  Future<ApiResponseDto> deleteItemRequisition(InventReqDto dto);
  Future<ApiResponseDto> deleteItemRequisitionWithListOfRecId(List<int> agsWORecId);
  Future<ApiResponseDto<InventReqDto>> getItemRequisition(InventReqDto dto);
  Future<ApiResponseDto<List<InventReqDto>>> getItemRequisitionList(int agsWORecId);
  Future<ApiResponseDto> createInventJournalTable(WorkOrderLineDto dto);
}