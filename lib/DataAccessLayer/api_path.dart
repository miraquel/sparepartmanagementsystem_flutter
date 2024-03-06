class ApiPath {
  // GMKSMSServiceGroup
  static const String getInventTablePagedList = '/api/GMKSMSServiceGroup/GetInventTablePagedList';
  static const String getPurchTablePagedList = '/api/GMKSMSServiceGroup/GetPurchTablePagedList';
  static const String getImageFromNetworkUri = '/api/GMKSMSServiceGroup/GetImageFromNetworkUri';
  static const String getImageWithResolutionFromNetworkUri = '/api/GMKSMSServiceGroup/GetImageWithResolutionFromNetworkUri';

  // GoodsReceiptHeader
  static const String addGoodsReceiptHeader = '/api/GoodsReceiptHeaderService';
  static const String deleteGoodsReceiptHeader = '/api/GoodsReceiptHeaderService';
  static const String getGoodsReceiptHeader = '/api/GoodsReceiptHeaderService';
  static const String getGoodsReceiptHeaderById = '/api/GoodsReceiptHeaderService';
  static const String updateGoodsReceiptHeader = '/api/GoodsReceiptHeaderService';
  static const String getGoodsReceiptHeaderPagedList = '/api/GoodsReceiptHeaderService/GetAllPagedList';
  static const String getGoodsReceiptHeaderByParams = '/api/GoodsReceiptHeaderService/GetByParams';
  static const String getGoodsReceiptHeaderByParamsPagedList = '/api/GoodsReceiptHeaderService/GetByParamsPagedList';

  // GoodsReceiptLine
  static const String addGoodsReceiptLine = '/api/GoodsReceiptLineService';
  static const String deleteGoodsReceiptLine = '/api/GoodsReceiptLineService';
  static const String getGoodsReceiptLine = '/api/GoodsReceiptLineService';
  static const String getGoodsReceiptLineById = '/api/GoodsReceiptLineService';
  static const String updateGoodsReceiptLine = '/api/GoodsReceiptLineService';
  static const String getGoodsReceiptLineByParams = '/api/GoodsReceiptLineService/GetByParams';

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
}