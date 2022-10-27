//

import UIKit
import RealityKit

class ViewController: UIViewController {
    var tankAnchor: TinyToyTank._TinyToyTank?
    var isActionPlaying: Bool = false

    @IBOutlet var arView: ARView!

    @IBAction func tankRightPressed(_ sender: Any) {
        if self.isActionPlaying { return }
        else { self.isActionPlaying = true }
        tankAnchor!.notifications.tankRight.post()
    }
    @IBAction func tankForwardPressed(_ sender: Any) {
        tankAnchor!.notifications.tankForward.post()
    }
    @IBAction func tankLeftPressed(_ sender: Any) {
        tankAnchor!.notifications.tankLeft.post()
    }
    @IBAction func turretRightPressed(_ sender: Any) {
        tankAnchor!.notifications.turretRight.post()
    }
    @IBAction func cannonFirePressed(_ sender: Any) {
        tankAnchor!.notifications.cannonFire.post()
    }
    @IBAction func turretLeftPressed(_ sender: Any) {
        tankAnchor!.notifications.turretLeft.post()
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  load the scene and store it in tankAnchor.
        tankAnchor = try! TinyToyTank.load_TinyToyTank()

        tankAnchor!.cannon?.setParent(tankAnchor!.tank, preservingWorldTransform: true)
        // Each behavior will send an actionComplete notification once its animation sequence ends.
        tankAnchor?.actions.actionComplete.onAction = { _ in
            self.isActionPlaying = false
        }
        // Add the tank anchor to the scene
        arView.scene.anchors.append(tankAnchor!)
    }
}
