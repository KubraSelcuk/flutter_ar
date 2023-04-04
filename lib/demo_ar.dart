import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class DemoAr extends StatefulWidget {
  

  @override
  State<DemoAr> createState() => _DemoArState();
}

class _DemoArState extends State<DemoAr> {
  late ARKitController arkitController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Demo Ar')),
        body: ARKitSceneView(
          
          detectionImagesGroupName: 'AR Images',
          onARKitViewCreated: (controller) => onARKitViewCreated,
        ));
  }

  void onARKitViewCreated(ARKitController c) {
    arkitController = c;
    arkitController.onAddNodeForAnchor = onAddNodeForAnchor;
  }

  void onAddNodeForAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      final position = anchor.transform.getColumn(3);
      final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.05, materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.image('images/earth.jpg'),
          )
        ]),
        position: vector.Vector3(position.x, position.y, position.z),
        eulerAngles: vector.Vector3.zero(),
      );
      arkitController.add(node);
    }
  }
}
