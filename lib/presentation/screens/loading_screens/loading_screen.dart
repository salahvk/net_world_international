import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class ViewPageLoading extends StatelessWidget {
  const ViewPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Shimmer.fromColors(
                  baseColor: Colormanager.secondary,
                  highlightColor: Colormanager.primary,
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amber),
                  )),
                
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Shimmer.fromColors(
                   baseColor: Colormanager.secondary,
                  highlightColor: Colormanager.primary,
                    child: Container(
                      height: 50,
                      width: size.width*.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber),
                    )),
              ),
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Shimmer.fromColors(
                   baseColor: Colormanager.secondary,
                  highlightColor: Colormanager.primary,
                    child: Container(
                      height: 50,
                      width: size.width*.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber),
                    )),
              ),
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Shimmer.fromColors(
                   baseColor: Colormanager.secondary,
                  highlightColor: Colormanager.primary,
                    child: Container(
                      height: 50,
                      width: size.width*.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
