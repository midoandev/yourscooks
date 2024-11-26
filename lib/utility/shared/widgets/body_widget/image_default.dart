import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDefault extends StatelessWidget {
  String assetImage;
  double height;
  double width;
  BoxFit? boxFit;
  double? borderCircular;
  EdgeInsetsGeometry? padding;

  ImageDefault(
      {super.key,
      required this.assetImage,
      required this.height,
      required this.width,
      this.borderCircular,
        this.padding,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.dialog(
          Dialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 4,
                        child: Image.asset(
                          assetImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 2), //(x,y)
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          barrierDismissible: false),
      child: Container(
        height: height,
        width: width,
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderCircular ?? 6),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            assetImage,
            fit: boxFit ?? BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
