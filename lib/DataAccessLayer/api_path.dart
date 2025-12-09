class ApiPath {
  // GMKSMSServiceGroup
  static const String getInventTable                                = '/api/v1/GMKSMSServiceGroup/GetInventTable';
  static const String getInventTablePagedList                       = '/api/v1/GMKSMSServiceGroup/GetInventTablePagedList';
  static const String getRawInventTablePagedList                    = '/api/v1/GMKSMSServiceGroup/GetRawInventTablePagedList';
  static const String getPurchTablePagedList                        = '/api/v1/GMKSMSServiceGroup/GetPurchTablePagedList';
  static const String getPurchLineList                              = '/api/v1/GMKSMSServiceGroup/GetPurchLineList';
  static const String getWMSLocationPagedList                       = '/api/v1/GMKSMSServiceGroup/GetWMSLocationPagedList';
  static const String getWMSLocation                                = '/api/v1/GMKSMSServiceGroup/GetWMSLocation';
  static const String getImageFromNetworkUri                        = '/api/v1/GMKSMSServiceGroup/GetImageFromNetworkUri';
  static const String getImageWithResolutionFromNetworkUri          = '/api/v1/GMKSMSServiceGroup/GetImageWithResolutionFromNetworkUri';
  static const String getPurchTable                                 = '/api/v1/GMKSMSServiceGroup/GetPurchTable';
  static const String getInventSumList                              = '/api/v1/GMKSMSServiceGroup/GetInventSumList';
  static const String getWorkOrderPagedList                         = '/api/v1/GMKSMSServiceGroup/GetWorkOrderPagedList';
  static const String getWorkOrderLineList                          = '/api/v1/GMKSMSServiceGroup/GetWorkOrderLineList';
  static const String getInventLocationList                         = '/api/v1/GMKSMSServiceGroup/GetInventLocationList';
  static const String getDimensionList                              = '/api/v1/GMKSMSServiceGroup/GetDimensionList';
  static const String getVendPackingSlipJourWithLines               = '/api/v1/GMKSMSServiceGroup/GetVendPackingSlipJourWithLines';
  static const String getInventTableLabelTemplate                   = '/api/v1/GMKSMSServiceGroup/GetInventTableLabelTemplate';

  // GoodsReceipt
  static const String addGoodsReceiptHeader                         = '/api/v1/GoodsReceiptService/AddGoodsReceiptHeader';
  static const String deleteGoodsReceiptHeader                      = '/api/v1/GoodsReceiptService/DeleteGoodsReceiptHeader';
  static const String getAllGoodsReceiptHeader                      = '/api/v1/GoodsReceiptService/GetAllGoodsReceiptHeader';
  static const String getGoodsReceiptById                           = '/api/v1/GoodsReceiptService/GetGoodsReceiptHeaderById';
  static const String updateGoodsReceipt                            = '/api/v1/GoodsReceiptService/UpdateGoodsReceiptHeader';
  static const String getAllGoodsReceiptHeaderPagedList             = '/api/v1/GoodsReceiptService/GetAllGoodsReceiptHeaderPagedList';
  static const String getGoodsReceiptHeaderByParams                 = '/api/v1/GoodsReceiptService/GetGoodsReceiptHeaderByParams';
  static const String getGoodsReceiptHeaderByParamsPagedList        = '/api/v1/GoodsReceiptService/GetGoodsReceiptHeaderByParamsPagedList';
  static const String addGoodsReceiptHeaderWithLines                = '/api/v1/GoodsReceiptService/AddGoodsReceiptHeaderWithLines';
  static const String addAndReturnGoodsReceiptHeaderWithLines       = '/api/v1/GoodsReceiptService/AddAndReturnGoodsReceiptHeaderWithLines';
  static const String updateGoodsReceiptHeaderWithLines             = '/api/v1/GoodsReceiptService/UpdateGoodsReceiptHeaderWithLines';
  static const String getGoodsReceiptHeaderByIdWithLines            = '/api/v1/GoodsReceiptService/GetGoodsReceiptHeaderByIdWithLines';
  static const String postToAX                                      = '/api/v1/GoodsReceiptService/PostToAX';
  static const String getGoodsReceiptLabelTemplate                  = '/api/v1/GoodsReceiptService/GetGoodsReceiptLabelTemplate';

  // WorkOrderHeader
  static const String addWorkOrderHeader                            = '/api/v1/WorkOrderService/AddWorkOrderHeader';
  static const String addWorkOrderHeaderWithLines                   = '/api/v1/WorkOrderService/AddWorkOrderHeaderWithLines';
  static const String updateWorkOrderHeader                         = '/api/v1/WorkOrderService/UpdateWorkOrderHeader';
  static const String deleteWorkOrderHeader                         = '/api/v1/WorkOrderService/DeleteWorkOrderHeader';
  static const String getWorkOrderHeaderById                        = '/api/v1/WorkOrderService/GetWorkOrderHeaderById';
  static const String getAllWorkOrderHeaderPagedList                = '/api/v1/WorkOrderService/GetAllWorkOrderHeaderPagedList';
  static const String getWorkOrderHeaderByParamsPagedList           = '/api/v1/WorkOrderService/GetWorkOrderHeaderByParamsPagedList';
  // WorkOrderLine
  static const String addWorkOrderLine                              = '/api/v1/WorkOrderService/AddWorkOrderLine';
  static const String updateWorkOrderLine                           = '/api/v1/WorkOrderService/UpdateWorkOrderLine';
  static const String deleteWorkOrderLine                           = '/api/v1/WorkOrderService/DeleteWorkOrderLine';
  static const String getWorkOrderLineById                          = '/api/v1/WorkOrderService/GetWorkOrderLineById';
  static const String getWorkOrderLineByWorkOrderHeaderId           = '/api/v1/WorkOrderService/GetWorkOrderLineByWorkOrderHeaderId';
  // ItemRequisition
  static const String addItemRequisition                            = '/api/v1/WorkOrderService/AddItemRequisition';
  static const String updateItemRequisition                         = '/api/v1/WorkOrderService/UpdateItemRequisition';
  static const String deleteItemRequisition                         = '/api/v1/WorkOrderService/DeleteItemRequisition';
  static const String getItemRequisitionById                        = '/api/v1/WorkOrderService/GetItemRequisitionById';
  static const String getItemRequisitionByParams                    = '/api/v1/WorkOrderService/GetItemRequisitionByParams';
  static const String getItemRequisitionByWorkOrderLineId           = '/api/v1/WorkOrderService/GetItemRequisitionByWorkOrderLineId';

  // Work Order Direct
  static const String getWorkOrderHeaderDirect                      = '/api/v1/WorkOrderServiceDirect/GetWorkOrderHeader';
  static const String getWorkOrderHeaderPagedListDirect             = '/api/v1/WorkOrderServiceDirect/GetWorkOrderHeaderPagedList';
  static const String addWorkOrderLineDirect                        = '/api/v1/WorkOrderServiceDirect/AddWorkOrderLine';
  static const String updateWorkOrderLineDirect                     = '/api/v1/WorkOrderServiceDirect/UpdateWorkOrderLine';
  static const String getWorkOrderLineDirect                        = '/api/v1/WorkOrderServiceDirect/GetWorkOrderLine';
  static const String getWorkOrderLineListDirect                    = '/api/v1/WorkOrderServiceDirect/GetWorkOrderLineList';
  static const String closeWorkOrderLineAndPostInventJournalDirect  = '/api/v1/WorkOrderServiceDirect/CloseWorkOrderLineAndPostInventJournal';
  static const String addItemRequisitionDirect                      = '/api/v1/WorkOrderServiceDirect/AddItemRequisition';
  static const String updateItemRequisitionDirect                   = '/api/v1/WorkOrderServiceDirect/UpdateItemRequisition';
  static const String deleteItemRequisitionDirect                   = '/api/v1/WorkOrderServiceDirect/DeleteItemRequisition';
  static const String deleteItemRequisitionDirectWithListOfRecId    = '/api/v1/WorkOrderServiceDirect/DeleteItemRequisitionWithListOfRecId';
  static const String getItemRequisitionDirect                      = '/api/v1/WorkOrderServiceDirect/GetItemRequisition';
  static const String getItemRequisitionListDirect                  = '/api/v1/WorkOrderServiceDirect/GetItemRequisitionList';
  static const String createInventJournalTable                      = '/api/v1/WorkOrderServiceDirect/CreateInventJournalTable';

  // NumberSequence
  static const String addNumberSequence                             = '/api/v1/NumberSequenceService/AddNumberSequence';
  static const String deleteNumberSequence                          = '/api/v1/NumberSequenceService/DeleteNumberSequence';
  static const String getAllNumberSequence                          = '/api/v1/NumberSequenceService/GetAllNumberSequence';
  static const String getNumberSequenceById                         = '/api/v1/NumberSequenceService/GetNumberSequenceById';
  static const String getNumberSequenceByParams                     = '/api/v1/NumberSequenceService/GetNumberSequenceByParams';
  static const String updateNumberSequence                          = '/api/v1/NumberSequenceService/UpdateNumberSequence';

  // Permission
  static const String addPermission                                 = '/api/v1/PermissionService/AddPermission';
  static const String deletePermission                              = '/api/v1/PermissionService/DeletePermission';
  static const String getAllModules                                 = '/api/v1/PermissionService/GetAllModules';
  static const String getAllPermissionType                          = '/api/v1/PermissionService/GetAllPermissionTypes';
  static const String getAllPermission                              = '/api/v1/PermissionService/GetAllPermission';
  static const String getPermissionByRoleId                         = '/api/v1/PermissionService/GetPermissionByRoleId';
  static const String getPermissionByParams                         = '/api/v1/PermissionService/GetPermissionByParams';

  // Role
  static const String addRole                                       = '/api/v1/RoleService/AddRole';
  static const String addUserToRole                                 = '/api/v1/RoleService/AddUserToRole';
  static const String deleteRole                                    = '/api/v1/RoleService/DeleteRole';
  static const String deleteUserFromRole                            = '/api/v1/RoleService/DeleteUserFromRole';
  static const String getRoleByIdWithUsers                          = '/api/v1/RoleService/GetRoleByIdWithUsers';
  static const String getAllRole                                    = '/api/v1/RoleService/GetAllRole';

  // User
  static const String loginWithActiveDirectory                      = '/api/v1/UserService/LoginWithActiveDirectory';
  static const String getUserByIdWithRoles                          = '/api/v1/UserService/GetUserByIdWithRoles';
  static const String getUserByUsernameWithRoles                    = '/api/v1/UserService/GetUserByUsernameWithRoles';
  static const String getAllUser                                    = '/api/v1/UserService/getAllUser';
  static const String getUserByParams                               = '/api/v1/UserService/GetUserByParams';
  static const String getUserById                                   = '/api/v1/UserService/GetUserById';
  static const String deleteUser                                    = '/api/v1/UserService/DeleteUser';
  static const String addUser                                       = '/api/v1/UserService/AddUser';
  static const String addRoleToUser                                 = '/api/v1/UserService/AddRoleToUser';
  static const String deleteRoleFromUser                            = '/api/v1/UserService/DeleteRoleFromUser';
  static const String getUsersFromActiveDirectory                   = '/api/v1/UserService/GetUsersFromActiveDirectory';
  static const String updateUser                                    = '/api/v1/UserService/UpdateUser';
  static const String refreshToken                                  = '/api/v1/UserService/RefreshToken';
  static const String revokeToken                                   = '/api/v1/UserService/RevokeToken';
  static const String revokeAllTokens                               = '/api/v1/UserService/RevokeAllTokens';
  static const String getUserByIdWithUserWarehouse                  = '/api/v1/UserService/GetUserByIdWithUserWarehouse';

  // User Warehouse
  static const String addUserWarehouse                              = '/api/v1/UserWarehouseService/AddUserWarehouse';
  static const String deleteUserWarehouse                           = '/api/v1/UserWarehouseService/DeleteUserWarehouse';
  static const String updateUserWarehouse                           = '/api/v1/UserWarehouseService/UpdateUserWarehouse';
  static const String getAllUserWarehouse                           = '/api/v1/UserWarehouseService/GetAllUserWarehouse';
  static const String getUserWarehouseById                          = '/api/v1/UserWarehouseService/GetUserWarehouseById';
  static const String getUserWarehouseByParams                      = '/api/v1/UserWarehouseService/GetUserWarehouseByParams';
  static const String getUserWarehouseByUserId                      = '/api/v1/UserWarehouseService/GetUserWarehouseByUserId';
  static const String getDefaultUserWarehouseByUserId               = '/api/v1/UserWarehouseService/GetDefaultUserWarehouseByUserId';

  // Row Level Access
  static const String addRowLevelAccess                             = '/api/v1/RowLevelAccessService/AddRowLevelAccess';
  static const String deleteRowLevelAccess                          = '/api/v1/RowLevelAccessService/DeleteRowLevelAccess';
  static const String getAllRowLevelAccess                          = '/api/v1/RowLevelAccessService/GetAllRowLevelAccess';
  static const String getRowLevelAccessByParams                     = '/api/v1/RowLevelAccessService/GetRowLevelAccessByParams';
  static const String getRowLevelAccessById                         = '/api/v1/RowLevelAccessService/GetRowLevelAccessById';
  static const String updateRowLevelAccess                          = '/api/v1/RowLevelAccessService/UpdateRowLevelAccess';
  static const String getRowLevelAccessByUserId                     = '/api/v1/RowLevelAccessService/GetRowLevelAccessByUserId';
  static const String bulkDeleteRowLevelAccess                      = '/api/v1/RowLevelAccessService/BulkDeleteRowLevelAccess';

  // Version Tracker
  static const String getAllVersionTracker                          = '/api/v1/VersionTrackerService/GetAllVersionTracker';
  static const String addVersionTracker                             = '/api/v1/VersionTrackerService/AddVersionTracker';
  static const String updateVersionTracker                          = '/api/v1/VersionTrackerService/UpdateVersionTracker';
  static const String deleteVersionTracker                          = '/api/v1/VersionTrackerService/DeleteVersionTracker';
  static const String getVersionTrackerById                         = '/api/v1/VersionTrackerService/GetVersionTrackerById';
  static const String getVersionTrackerByParams                     = '/api/v1/VersionTrackerService/GetVersionTrackerByParams';
  static const String getLatestVersionTracker                       = '/api/v1/VersionTrackerService/GetLatestVersionTracker';
  static const String getVersionFeed                                = '/api/v1/VersionTrackerService/GetVersionFeed';

  // Work Request
  static const String getWorkRequestPagedList                       = '/api/v1/WorkRequestService/GetWorkRequestPagedList';
  static const String getWorkRequest                                = '/api/v1/WorkRequestService/GetWorkRequest';
  static const String updateAcceptedWorkRequest                     = '/api/v1/WorkRequestService/UpdateAcceptedWorkRequest';
  static const String createWorkOrderTable                          = '/api/v1/WorkRequestService/CreateWorkOrderTable';
  static const String getConditionList                              = '/api/v1/WorkRequestService/GetConditionList';
  static const String getTaskList                                   = '/api/v1/WorkRequestService/GetTaskList';
  static const String updateWorkRequest                             = '/api/v1/WorkRequestService/UpdateWorkRequest';
  static const String validateWrkCtrId                              = '/api/v1/WorkRequestService/ValidateWrkCtrId';

  // Operation Type
  static const String addOperationType                              = '/api/v1/OperationTypeService/Add';
  static const String deleteOperationType                           = '/api/v1/OperationTypeService/Delete';
  static const String getAllOperationType                           = '/api/v1/OperationTypeService/GetAll';
  static const String updateOperationType                           = '/api/v1/OperationTypeService/Update';
  static const String getOperationTypeById                          = '/api/v1/OperationTypeService/GetById';
  static const String getOperationTypeByParams                      = '/api/v1/OperationTypeService/GetByParams';

  // Operation Template
  static const String addOperationTemplate                          = '/api/v1/OperationTemplateService/Add';
  static const String deleteOperationTemplate                       = '/api/v1/OperationTemplateService/Delete';
  static const String getAllOperationTemplates                      = '/api/v1/OperationTemplateService/GetAll';
  static const String updateOperationTemplate                       = '/api/v1/OperationTemplateService/Update';
  static const String getOperationTemplateById                      = '/api/v1/OperationTemplateService/GetById';
  static const String getOperationTemplateByParams                  = '/api/v1/OperationTemplateService/GetByParams';

  // Operation Template Column
  static const String addOperationTemplateColumn                    = '/api/v1/OperationTemplateColumnService/Add';
  static const String deleteOperationTemplateColumn                 = '/api/v1/OperationTemplateColumnService/Delete';
  static const String getAllOperationTemplateColumns                = '/api/v1/OperationTemplateColumnService/GetAll';
  static const String updateOperationTemplateColumn                 = '/api/v1/OperationTemplateColumnService/Update';
  static const String getOperationTemplateColumnById                = '/api/v1/OperationTemplateColumnService/GetById';
  static const String getOperationTemplateColumnByParams            = '/api/v1/OperationTemplateColumnService/GetByParams';

  // Operation Template Row
  static const String addOperationTemplateRow                       = '/api/v1/OperationTemplateRowService/Add';
  static const String deleteOperationTemplateRow                    = '/api/v1/OperationTemplateRowService/Delete';
  static const String getAllOperationTemplateRows                   = '/api/v1/OperationTemplateRowService/GetAll';
  static const String updateOperationTemplateRow                    = '/api/v1/OperationTemplateRowService/Update';
  static const String getOperationTemplateRowById                   = '/api/v1/OperationTemplateRowService/GetById';
  static const String getOperationTemplateRowByParams               = '/api/v1/OperationTemplateRowService/GetByParams';

  // Operation Entry Header
  static const String addOperationEntryHeader                       = '/api/v1/OperationEntryHeaderService/Add';
  static const String deleteOperationEntryHeader                    = '/api/v1/OperationEntryHeaderService/Delete';
  static const String getAllOperationEntryHeaders                   = '/api/v1/OperationEntryHeaderService/GetAll';
  static const String updateOperationEntryHeader                    = '/api/v1/OperationEntryHeaderService/Update';
  static const String getOperationEntryHeaderById                   = '/api/v1/OperationEntryHeaderService/GetById';
  static const String getOperationEntryHeaderByParams               = '/api/v1/OperationEntryHeaderService/GetByParams';

  // Operation Entry Line
  static const String addOperationEntryLine                         = '/api/v1/OperationEntryLineService/Add';
  static const String deleteOperationEntryLine                      = '/api/v1/OperationEntryLineService/Delete';
  static const String getAllOperationEntryLines                     = '/api/v1/OperationEntryLineService/GetAll';
  static const String updateOperationEntryLine                      = '/api/v1/OperationEntryLineService/Update';
  static const String getOperationEntryLineById                     = '/api/v1/OperationEntryLineService/GetById';
  static const String getOperationEntryLineByParams                 = '/api/v1/OperationEntryLineService/GetByParams';

  // Operation Entry Verification
  static const String addOperationEntryVerification                 = '/api/v1/OperationEntryVerificationService/Add';
  static const String deleteOperationEntryVerification              = '/api/v1/OperationEntryVerificationService/Delete';
  static const String getAllOperationEntryVerifications             = '/api/v1/OperationEntryVerificationService/GetAll';
  static const String updateOperationEntryVerification              = '/api/v1/OperationEntryVerificationService/Update';
  static const String getOperationEntryVerificationById             = '/api/v1/OperationEntryVerificationService/GetById';
  static const String getOperationEntryVerificationByParams         = '/api/v1/OperationEntryVerificationService/GetByParams';

  // Operation Template Verificator
  static const String addOperationTemplateVerificator               = '/api/v1/OperationTemplateVerificatorService/Add';
  static const String deleteOperationTemplateVerificator            = '/api/v1/OperationTemplateVerificatorService/Delete';
  static const String getAllOperationTemplateVerificators           = '/api/v1/OperationTemplateVerificatorService/GetAll';
  static const String updateOperationTemplateVerificator            = '/api/v1/OperationTemplateVerificatorService/Update';
  static const String getOperationTemplateVerificatorById           = '/api/v1/OperationTemplateVerificatorService/GetById';
  static const String getOperationTemplateVerificatorByParams       = '/api/v1/OperationTemplateVerificatorService/GetByParams';
}