//
//  ViewController.swift
//  03-Earth
//
//  Created by 杨帆 on 2021/9/19.
//

import RealityKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let earchAnchor = try! Earth.loadEarthScene()

        arView.scene.anchors.append(earchAnchor)
    }
}
