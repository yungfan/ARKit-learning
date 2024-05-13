//
//  ViewController.swift
//  01-Robot
//
//  Created by 杨帆 on 2021/9/18.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!

    var robotAnchor: Robot._Robot!

    override func viewDidLoad() {
        super.viewDidLoad()

        robotAnchor = try! Robot.load_Robot()
        robotAnchor.generateCollisionShapes(recursive: false)

        arView.scene.anchors.append(robotAnchor)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        robotAnchor.notifications.work.post()
    }
}
