class ApiPath {
  // GMKSMSServiceGroup
  static const String getInventTablePagedList = '/api/GMKSMSServiceGroup/GetInventTablePagedList';
  static const String getPurchTablePagedList = '/api/GMKSMSServiceGroup/GetPurchTablePagedList';
  static const String getPurchLineList = '/api/GMKSMSServiceGroup/GetPurchLineList';
  static const String getWMSLocationPagedList = '/api/GMKSMSServiceGroup/GetWMSLocationPagedList';
  static const String getImageFromNetworkUri = '/api/GMKSMSServiceGroup/GetImageFromNetworkUri';
  static const String getImageWithResolutionFromNetworkUri = '/api/GMKSMSServiceGroup/GetImageWithResolutionFromNetworkUri';
  static const String getPurchTable = '/api/GMKSMSServiceGroup/GetPurchTable';
  static const String getInventSumList = '/api/GMKSMSServiceGroup/GetInventSumList';

  // GoodsReceipt
  static const String addGoodsReceipt = '/api/GoodsReceiptService';
  static const String deleteGoodsReceipt = '/api/GoodsReceiptService';
  static const String getGoodsReceipt = '/api/GoodsReceiptService';
  static const String getGoodsReceiptById = '/api/GoodsReceiptService';
  static const String updateGoodsReceipt = '/api/GoodsReceiptService';
  static const String getGoodsReceiptPagedList = '/api/GoodsReceiptService/GetAllPagedList';
  static const String getGoodsReceiptByParams = '/api/GoodsReceiptService/GetByParams';
  static const String getGoodsReceiptByParamsPagedList = '/api/GoodsReceiptService/GetByParamsPagedList';
  static const String addGoodsReceiptWithLines = '/api/GoodsReceiptService/AddWithLines';
  static const String updateGoodsReceiptWithLines = '/api/GoodsReceiptService/UpdateWithLines';
  static const String getGoodsReceiptByIdWithLines = '/api/GoodsReceiptService/GetByIdWithLines';
  static const String postToAX = '/api/GoodsReceiptService/PostToAX';

  // NumberSequence
  static const String addNumberSequence = '/api/NumberSequenceService';
  static const String deleteNumberSequence = '/api/NumberSequenceService';
  static const String fetchNumberSequence = '/api/NumberSequenceService';
  static const String fetchNumberSequenceById = '/api/NumberSequenceService';
  static const String updateNumberSequence = '/api/NumberSequenceService';

  // Permission
  static const String addPermission = '/api/PermissionService';
  static const String deletePermission = '/api/PermissionService';
  static const String fetchAllModule = '/api/PermissionService/GetAllModules';
  static const String fetchAllPermissionType = '/api/PermissionService/GetAllPermissionTypes';
  static const String fetchPermission = '/api/PermissionService';
  static const String fetchPermissionByRoleId = '/api/PermissionService/GetByRoleId';

  // Role
  static const String addRole = '/api/RoleService';
  static const String addUserToRole = '/api/RoleService/AddUser';
  static const String deleteRole = '/api/RoleService';
  static const String deleteUserFromRole = '/api/RoleService/DeleteUser';
  static const String fetchByIdWithUsers = '/api/RoleService/GetByIdWithUsers';
  static const String fetchRole = '/api/RoleService';

  // User
  static const String loginWithActiveDirectory = '/api/UserService/LoginWithActiveDirectory';
  static const String getUserByIdWithRoles = '/api/UserService/GetByIdWithRoles';
  static const String getUserByUsernameWithRoles = '/api/UserService/GetByUsernameWithRoles';
  static const String getUser = '/api/UserService';
  static const String getUserById = '/api/UserService';
  static const String deleteUser = '/api/UserService';
  static const String addUser = '/api/UserService';
  static const String addRoleToUser = '/api/UserService/AddRole';
  static const String deleteRoleFromUser = '/api/UserService/DeleteRole';
  static const String getUsersFromActiveDirectory = '/api/UserService/GetUsersFromActiveDirectory';
  static const String updateUser = '/api/UserService';
  static const String refreshToken = '/api/UserService/RefreshToken';
  static const String revokeToken = '/api/UserService/RevokeToken';
  static const String revokeAllTokens = '/api/UserService/RevokeAllTokens';

  // Row Level Access
  static const String addRowLevelAccess = '/api/RowLevelAccessService';
  static const String deleteRowLevelAccess = '/api/RowLevelAccessService';
  static const String getRowLevelAccess = '/api/RowLevelAccessService';
  static const String getRowLevelAccessByParams = '/api/RowLevelAccessService/GetByParams';
  static const String getRowLevelAccessById = '/api/RowLevelAccessService';
  static const String updateRowLevelAccess = '/api/RowLevelAccessService';
  static const String getRowLevelAccessByUserId = '/api/RowLevelAccessService/GetByUserId';
  static const String bulkDeleteRowLevelAccess = '/api/RowLevelAccessService/BulkDelete';
}