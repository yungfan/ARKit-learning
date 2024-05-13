//
//  ContentView.swift
//  05-LiDAR
//
//  Created by 杨帆 on 2021/12/16.
//

import ARKit
import RealityKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.automaticallyConfigureSession = false
        let config = ARWorldTrackingConfiguration()
        // LiDAR支持场景重建
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }
        config.planeDetection = .horizontal
        arView.debugOptions.insert(.showSceneUnderstanding)
        arView.session.run(config, options: [.resetSceneReconstruction])

        let boxMesh = MeshResource.generateBox(size: 0.2)
        let boxMat = SimpleMaterial(color: .black, roughness: 0.4, isMetallic: false)
        let boxEntity = ModelEntity(mesh: boxMesh, materials: [boxMat])
        boxAnchor.addChild(boxEntity)
        arView.installGestures([.translation, .scale], for: boxEntity)
        arView.scene.anchors.append(boxAnchor)
        arView.enableTapGesture()
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

let boxAnchor = AnchorEntity(plane: .horizontal)

extension ARView {
    // 添加手势
    func enableTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlerTap))
        addGestureRecognizer(tap)
    }

    @objc func handlerTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        // 射线检测
        guard let result = raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any).first else { return }
        // 碰撞位置放置box
        boxAnchor.setTransformMatrix(result.worldTransform, relativeTo: nil)
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif
