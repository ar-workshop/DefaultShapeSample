import UIKit
import ARKit

class ViewController: UIViewController {
  @IBOutlet weak var sceneView: ARSCNView!
  let config = ARWorldTrackingConfiguration()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.sceneView.session.run(config)
    self.sceneView.autoenablesDefaultLighting = true
  }
  
  @IBAction func add(_ sender: UIButton) {
    let shapeAndColors: [[Any]] = [
      [SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03), UIColor.red],
      [SCNCapsule(capRadius: 0.1, height: 0.3), UIColor.green],
      [SCNCone(topRadius: 0, bottomRadius: 0.2, height: 0.2), UIColor.blue],
      [SCNCylinder(radius: 0.1, height: 0.2), UIColor.white],
      [SCNPlane(width: 0.1, height: 0.1), UIColor.black],
      [SCNPyramid(width: 0.1, height: 0.1, length: 0.1), UIColor.brown],
      [SCNSphere(radius: 0.1), UIColor.yellow],
      [SCNTorus(ringRadius: 0.1, pipeRadius: 0.05), UIColor.gray],
      [SCNTube(innerRadius: 0.05, outerRadius: 0.1, height: 0.1), UIColor.purple],
    ]
    var index = 1.0
    shapeAndColors.forEach { shapeAndColor in
      let node = SCNNode()
      node.geometry = shapeAndColor.first as? SCNGeometry
      node.geometry?.firstMaterial?.specular.contents = UIColor.white
      node.geometry?.firstMaterial?.diffuse.contents = shapeAndColor.last as? UIColor
      node.position = SCNVector3(0.1 * index, -0.3, -0.3)
      self.sceneView.scene.rootNode.addChildNode(node)
      index += 5
    }
  }
  
  @IBAction func reset(_ sender: UIButton) {
    self.sceneView.session.pause()
    self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
      node.removeFromParentNode()
    }
    self.sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
  }
}

