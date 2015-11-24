//
//  GameScene.swift
//  SpaceRun }MCf2mN3nEhcR+J3KdpMQaaJtax9MDDYoV.Jh@ZMj7HDtAvGLG
//
//  Created by Jack Hall on 11/19/15.
//  Copyright (c) 2015 Jack Hall. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let shipSpeed: CGFloat = 5.0
    let torpedoFlightDuration: NSTimeInterval = 5.0
    let torpedoInterval = 7.0
    
    var lastUpdatedTime: NSTimeInterval = 0.0
    var lastShotFiredTime: NSTimeInterval = 0.0
    weak var shipTouch: UITouch?
    var ship: SKSpriteNode? = nil
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.blackColor()
        ship = SKSpriteNode(imageNamed: "Spaceship")
        ship!.size = CGSize.init(width: 40, height: 40)
        ship!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(ship!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.shipTouch = touches.first
        
        //        self.ship?.position = self.shipTouch!.locationInNode(self)
    }
    
    override func update(currentTime: CFTimeInterval) {
        if (lastUpdatedTime == 0) {
            lastUpdatedTime = currentTime
        }
        let delta = currentTime - lastUpdatedTime
        
        if ((shipTouch) != nil) {
            _moveTowardPoint((shipTouch?.locationInNode(self))!, timeDelta: delta)
            if (currentTime - lastShotFiredTime > torpedoInterval) {
                _fireZeMissles()
                lastShotFiredTime = currentTime
            }
        }
        
        lastUpdatedTime = currentTime;
    }
    
    func _fireZeMissles() {
        let torpedo = SKSpriteNode(imageNamed: "photon")
        torpedo.position = (ship?.position)!
        self.addChild(torpedo)
        
        let fly = SKAction.moveByX(0, y: self.size.height + torpedo.size.height, duration: torpedoFlightDuration)
        
        torpedo.runAction(fly)
    }
    
    func _moveTowardPoint(point: CGPoint, timeDelta: NSTimeInterval) {
        if (ship != nil) {
            let distanceRemaining = sqrt(pow(ship!.position.x - point.x, 2) + pow(ship!.position.y - point.y, 2))
            
            if (distanceRemaining > 4) {
                let distanceToTravel = distanceRemaining / shipSpeed
                let angle = atan2(point.y - ship!.position.y, point.x - ship!.position.x)
                let yOffset = distanceToTravel * sin(angle)
                let xOffset = distanceToTravel * cos(angle)
                
                ship!.position.x = ship!.position.x + xOffset
                ship!.position.y = ship!.position.y + yOffset
            }
        }
    }
}
