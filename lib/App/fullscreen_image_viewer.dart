import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:sparepartmanagementsystem_flutter/DataAccessLayer/api_path.dart';
import 'package:sparepartmanagementsystem_flutter/environment.dart';

class FullscreenImageViewer extends StatefulWidget {
  final String imageNetworkPath;
  final Function(dynamic) errorHandler;

  const FullscreenImageViewer(
      {super.key, required this.imageNetworkPath, required this.errorHandler});

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
              Center(
                child: Hero(
                  tag: widget.imageNetworkPath,
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(
                        '${Environment.baseUrl}${ApiPath.getImageFromNetworkUri}?networkUri=${widget.imageNetworkPath}'),
                    loadingBuilder: (context, event) {
                      if (event == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      widget.errorHandler(error);
                      return const Center(
                        child: Text('Error loading image'),
                      );
                    },
                  ),
                ),
              ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
