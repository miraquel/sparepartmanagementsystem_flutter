import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:sparepartmanagementsystem_flutter/Model/invent_table_dto.dart';

import '../DataAccessLayer/api_path.dart';
import '../environment.dart';
import '../service_locator_setup.dart';

class InventoryMasterDetails extends StatefulWidget {
  final InventTableDto inventTableDto;
  const InventoryMasterDetails({super.key, required this.inventTableDto});

  @override
  State<InventoryMasterDetails> createState() => _InventoryMasterDetailsState();
}

class _InventoryMasterDetailsState extends State<InventoryMasterDetails> {
  final _logger = locator<Logger>();
  late NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigator = Navigator.of(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // create CustomScrollView with SliverAppBar without SliverList
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/inventoryMasterEdit', arguments: widget.inventTableDto);
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: GestureDetector(
                  onTap: () {
                    _logger.i('Item Id: ${widget.inventTableDto.itemId}');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.8),
                    ),
                    child: Text('Item Id: ${widget.inventTableDto.itemId}', style: const TextStyle(color: Colors.white)),
                  ),
                ),
                titlePadding: const EdgeInsets.only(bottom: 16),
                centerTitle: true,
                expandedTitleScale: 1.5,
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                collapseMode: CollapseMode.parallax,
                background: widget.inventTableDto.image.isNotEmpty ?
                  GestureDetector(
                    onTap: () {
                      _logger.i('Image tapped');
                      _navigator.pushNamed('/fullScreenImageViewer', arguments: {
                        'imageNetworkPath': widget.inventTableDto.image,
                        'errorHandler': (error) {
                          _logger.e('Error loading image', error: error);
                        }
                      });
                    },
                    child: Hero(
                      tag: widget.inventTableDto.image,
                      child: CachedNetworkImage(
                        imageUrl: "${Environment.baseUrl}${ApiPath.getImageWithResolutionFromNetworkUri}?networkUri=${widget.inventTableDto.image}&maxLength=500",
                        width: 500,
                        height: 500,
                        fadeInDuration: const Duration(seconds: 0),
                        fadeOutDuration: const Duration(seconds: 0),
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            const SpinKitCircle(color: Colors.blue, size: 50, duration: Duration(milliseconds: 500)),
                        errorWidget: (context, url, error) {
                          _logger.e('Error loading image', error: error);
                          return SizedBox.fromSize(size: const Size.square(500), child: const Icon(Icons.error));
                        }
                      ),
                    ),
                  ) : const Image(image: AssetImage('assets/images/no_image.png'), width: 500, height: 500)
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        _navigator.pushNamed('/inventoryMasterStockList', arguments: widget.inventTableDto);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero
                        ),
                      ),
                      child: const Text('View On Hand Stock')),
                  ListTile(
                    title: const Text('Item Id'),
                    subtitle: Text(widget.inventTableDto.itemId),
                  ),
                  ListTile(
                    title: const Text('Product Name'),
                    subtitle: Text(widget.inventTableDto.productName),
                  ),
                  ListTile(
                    title: const Text('Search Name'),
                    subtitle: Text(widget.inventTableDto.searchName),
                  ),
                  ListTile(
                    title: const Text('Description'),
                    subtitle: Text(widget.inventTableDto.description),
                  ),
                  ListTile(
                    title: const Text('Product Type'),
                    subtitle: Text(widget.inventTableDto.productType),
                  ),
                  ListTile(
                    title: const Text('Production Type'),
                    subtitle: Text(widget.inventTableDto.productionType),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
