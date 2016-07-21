//
//  GameViewController.swift
//  Ziggity Zag
//
//  Created by Abideen Onalaja on 11/07/2016.
//  Copyright (c) 2016 xs. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    let scene = SCNScene()
    let cameraNode = SCNNode();
    
    let firstBox = SCNNode()
    
    var goingLeft = Bool();
    
    var person = SCNNode()
    
    
    
    override func viewDidLoad(){
//        super.viewDidLoad()
        self.createScene()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if goingLeft == false {
            person.removeAllActions()
            person.runAction(SCNAction.repeatActionForever(SCNAction.moveBy(SCNVector3Make(-100, 0, 0), duration: 20)))
            goingLeft = true
        } else {
            person.removeAllActions()
            person.runAction(SCNAction.repeatActionForever(SCNAction.moveBy(SCNVector3Make(0, 0, -100), duration: 20)))
            goingLeft = false
        }
    }

    func createScene() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        let sceneView = self.view as! SCNView

        sceneView.scene = scene
        
        // Create Person
        let personGeo = SCNSphere(radius: 0.2)
        person = SCNNode(geometry: personGeo)
        let personMaterial  = SCNMaterial()
        personMaterial.diffuse.contents = UIColor.greenColor()
        personGeo.materials = [personMaterial]
        person.position = SCNVector3Make(0, 1.1, 0)
        scene.rootNode.addChildNode(person)

        // create Camera
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.camera?.orthographicScale = 3
        cameraNode.position = SCNVector3Make(20, 20, 20)
        cameraNode.eulerAngles = SCNVector3Make(-45, 45, 0)
        let constraint = SCNLookAtConstraint(target: firstBox)
        constraint.gimbalLockEnabled = true
        self.cameraNode.constraints = [constraint]
        scene.rootNode.addChildNode(cameraNode);
        
        // Create Box
        let firstBoxGeo = SCNBox(width: 1, height: 1.5, length: 1, chamferRadius: 0)
        firstBox.geometry = firstBoxGeo
        
        // Box Material
        let boxMaterial = SCNMaterial()
        boxMaterial.diffuse.contents = UIColor(red: 0.2, green: 0.8, blue: 0.9, alpha: 1.0)
        
        firstBoxGeo.materials = [boxMaterial]
        firstBox.position = SCNVector3Make(0, 0, 0)
        
        scene.rootNode.addChildNode(firstBox)
        
        // Create light
        let light = SCNNode()
        light.light = SCNLight()
        light.light?.type = SCNLightTypeDirectional
        light.eulerAngles = SCNVector3Make(-45, 45, 0)
        scene.rootNode.addChildNode(light)
        
        // Create light
        let light2 = SCNNode()
        light2.light = SCNLight()
        light2.light?.type = SCNLightTypeDirectional
        light2.eulerAngles = SCNVector3Make(45, 45, 0)
        scene.rootNode.addChildNode(light2)
    }
    
    

}
