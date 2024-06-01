import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/Abstract/gmk_sms_service_group_dal.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_dto.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_sum_search_dto.dart';
import 'package:sparepartmanagementsystem_flutter/service_locator_setup.dart';

class ItemRequisitionDirectAddLocation extends StatefulWidget {
  final String itemId;
  const ItemRequisitionDirectAddLocation({super.key, required this.itemId});

  @override
  State<ItemRequisitionDirectAddLocation> createState() => _ItemRequisitionDirectAddLocationState();
}

class _ItemRequisitionDirectAddLocationState extends State<ItemRequisitionDirectAddLocation> {
  final _gmkSMSServiceGroupDAL = locator<GMKSMSServiceGroupDAL>();
  final _inventSumDtoList = <InventSumDto>[];
  late final _inventSumSearchDto = InventSumSearchDto(itemId: widget.itemId);

  @override
  void initState() {
    super.initState();
    _getInventSum();
  }

  Future<void> _getInventSum() async {
    final response = await _gmkSMSServiceGroupDAL.getInventSumList(_inventSumSearchDto);
    //response.data!.removeWhere((element) => element.availPhysical == 0);
    if (response.success) {
      setState(() {
        _inventSumDtoList.clear();
        _inventSumDtoList.addAll(response.data!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available stock for item ${widget.itemId}'),
      ),
      body: ListView.builder(
        itemCount: _inventSumDtoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_inventSumDtoList[index].inventLocationId),
            subtitle: Text(_inventSumDtoList[index].wMSLocationId),
            trailing: Text(_inventSumDtoList[index].availOrdered.toString()),
            onTap: () {
              Navigator.of(context).pop(_inventSumDtoList[index]);
            },
          );
        },
      ),
    );
  }
}
