import 'package:flutter/material.dart';
import 'package:sparepartmanagementsystem_flutter/App/loading_overlay.dart';
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
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getInventSum();
  }

  Future<void> _getInventSum() async {
    try {
      setState(() => _isLoading = true);
      final response = await _gmkSMSServiceGroupDAL.getInventSumList(_inventSumSearchDto);
      response.data!.removeWhere((element) => element.availPhysical == 0);
      if (response.success) {
        setState(() {
          _inventSumDtoList.clear();
          _inventSumDtoList.addAll(response.data!);
        });
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Locations'),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('Below are the locations with available physical stock. Please choose a location to continue.', style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15),
              child: Text.rich(
                TextSpan(
                  text: 'Item ID: ',
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  children: [
                    TextSpan(
                      text: widget.itemId,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _inventSumDtoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_inventSumDtoList[index].inventLocationId),
                    subtitle: Text(_inventSumDtoList[index].wMSLocationId),
                    trailing: Text("Available Physical: ${_inventSumDtoList[index].availPhysical}", style: const TextStyle(fontSize: 13)),
                    onTap: () => Navigator.of(context).pop(_inventSumDtoList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
