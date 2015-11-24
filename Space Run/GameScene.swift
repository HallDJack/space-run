//
//  GameScene.swift
//  SpaceRun }MCf2mN3nEhcR+J3KdpMQaaJtax9MDDYoV.Jh@ZMj7HDtAvGLG
//
//  Created by Jack Hall on 11/19/15.
//  Copyright (c) 2015 Jack Hall. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var lastUpdatedTime: NSTimeInterval = 0.0
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
            //          self.ship?.position = self.shipTouch!.locationInNode(self)
        }
        
        lastUpdatedTime = currentTime;
    }
    
    func _moveTowardPoint(point: CGPoint, timeDelta: NSTimeInterval) {
        speed = 5
        if (ship != nil) {
            let distanceRemaining = sqrt(pow(ship!.position.x - point.x, 2) + pow(ship!.position.y - point.y, 2))
            
            if (distanceRemaining > 4) {
                let distanceToTravel = distanceRemaining / speed
                let angle = atan2(point.y - ship!.position.y, point.x - ship!.position.x)
                let yOffset = distanceToTravel * sin(angle)
                let xOffset = distanceToTravel * cos(angle)
                
                ship!.position.x = ship!.position.x + xOffset
                ship!.position.y = ship!.position.y + yOffset
            }
        }
    }
}
