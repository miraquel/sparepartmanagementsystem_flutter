// import 'package:flutter/material.dart';
// import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
// import 'package:sparepartmanagementsystem_flutter/Model/user_warehouse_dto_builder.dart';
//
// import '../Model/user_warehouse_dto.dart';
//
// class UserWarehouseAdd extends StatefulWidget {
//   final int userId;
//   const UserWarehouseAdd({super.key, required this.userId});
//
//   @override
//   State<UserWarehouseAdd> createState() => _UserWarehouseAddState();
// }
//
// class _UserWarehouseAddState extends State<UserWarehouseAdd> {
//   final List<UserWarehouseDtoBuilder> _userWarehouses = <UserWarehouseDtoBuilder>[];
//   var _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return LoadingOverlay(
//       isLoading: _isLoading,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Add User Warehouse'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: ListView.builder(
//             itemCount: _userWarehouses.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(_userWarehouses[index].name),
//                 subtitle: Text(_userWarehouses[index].inventLocationId.toString()),
//                 // trailing: IconButton(
//                 //   icon: const Icon(Icons.delete),
//                 //   onPressed: () {
//                 //     setState(() {
//                 //       _userWarehouses.removeAt(index);
//                 //     });
//                 //   },
//                 // ),
//               );
//             }
//           )
//         ),
//       ),
//     );
//   }
//
//   // show dialog to add user warehouse
//   void _showAddUserWarehouseDialog() {
//     final formKey = GlobalKey<FormState>();
//     final userWarehouseDtoBuilder = UserWarehouseDtoBuilder();
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add User Warehouse'),
//           content: Form(
//             key: formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Invent Location Id'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter invent location id';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       userWarehouseDtoBuilder.inventLocationId = int.parse(value!);
//                     },
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Name'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter name';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       userWarehouseDtoBuilder.name = value!;
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: const Text('Is Default'),
//                     value: userWarehouseDtoBuilder.isDefault ?? false,
//                     onChanged: (value) {
//                       userWarehouseDtoBuilder.isDefault = value;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // add user warehouse
//                 setState(() {
//                   _userWarehouses.add(UserWarehouseDto(
//                     inventLocationId: 1,
//                     name: 'Warehouse 1',
//                     isDefault: true,
//                   ));
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
