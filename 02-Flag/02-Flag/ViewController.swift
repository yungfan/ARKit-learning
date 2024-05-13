//
//  ViewController.swift
//  02-Flag
//
//  Created by student on 2021/9/18.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    // ARVeiw
    @IBOutlet var arView: ARView!
    // Reality Composer中的场景
    var flagAnchor: Flag.FlagScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 加载场景
        flagAnchor = try! Flag.loadFlagScene()
        // 添加场景
        arView.scene.anchors.append(flagAnchor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 发送触发行为的通知
        flagAnchor.notifications.rotateTrigger.post()
    }
    
    @IBAction func snapshot(_ sender: Any) {
        // 保存AR截图
        arView.snapshot(saveToHDR: false) { (image) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }
}
