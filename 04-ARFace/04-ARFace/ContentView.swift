//
//  ContentView.swift
//  04-ARFace
//
//  Created by 杨帆 on 2021/11/24.
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
        
        if ARFaceTrackingConfiguration.isSupported {
            let config = ARFaceTrackingConfiguration()
            config.maximumNumberOfTrackedFaces = 1
            config.isWorldTrackingEnabled = true

            let faceAnchor = try! FaceMask.loadCasque()
            arView.session.delegate = arView
            arView.addGesture()
            arView.scene.addAnchor(faceAnchor)
            arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

extension ARView: ARSessionDelegate {
    func addGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(change))
        addGestureRecognizer(gesture)
    }

    @objc func change() {
        let hatAnchor = try! FaceMask.loadHat()
        scene.anchors.removeAll()
        scene.addAnchor(hatAnchor)
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif
