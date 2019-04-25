//
//  GameScene.swift
//  Pong Nedkov
//
//  Created by Dennis Jivko Nedkov on 4/15/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

let ballCategory: UInt32 = 1
let topCategory: UInt32 = 2
let paddleCategory: UInt32 = 4 // 0x1 << 5

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var topPaddle = SKSpriteNode()
    var ball = SKSpriteNode()
    var counter = 0
    var label = SKLabelNode()
   
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = border
        
        let topLeft = CGPoint(x: frame.origin.x, y:-frame.origin.y)
        let topRight = CGPoint(x: -frame.origin.x, y:-frame.origin.y)
        
        let top = SKNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        self.addChild(top)
        
        
        topPaddle = self.childNode(withName: "topPaddle") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        
        
        topPaddle.physicsBody?.categoryBitMask = paddleCategory
        ball.physicsBody?.categoryBitMask = ballCategory
        top.physicsBody?.categoryBitMask = topCategory
        
        ball.physicsBody?.contactTestBitMask = topCategory|paddleCategory
        
        label = SKLabelNode(text: "0")
        label.fontSize = 100.0
        label.position = CGPoint(x: 0, y: -35)
        addChild(label)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        //print(contact.bodyA)
        //print(contact.bodyB)
        
        if contact.bodyA.categoryBitMask == topCategory{
            changePaddle(node: topPaddle)
        }
        
        if contact.bodyA.categoryBitMask == paddleCategory{
            counter += 1
            label.text = "\(counter)"
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
    func changePaddle(node: SKSpriteNode){
        if node.color == .yellow{
            node.removeAllActions()
            node.removeFromParent()
        }
        node.color = .yellow
    }
}
