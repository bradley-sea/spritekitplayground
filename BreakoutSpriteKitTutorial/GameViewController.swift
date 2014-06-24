//
//  GameViewController.swift
//  BreakoutSpriteKitTutorial
//
//  Created by Bradley Johnson on 6/20/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let ballCategoryName = "ball"
    let paddleCategoryName = "paddle"
    let blockCategoryName = "block"
    let blockNodeCategoryName = "blockNode"
    let backgroundNodeCategoryName = "background"
    
    var scene : SKScene?
    var spriteView : SKView?
    var isFingerOnPaddle = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scene = SKScene(size: self.view.frame.size)
        //self.scene!.scaleMode = SKSceneScaleMode.Fill
        self.spriteView = SKView(frame: self.view.frame)
        self.view.addSubview(self.spriteView)
        self.spriteView!.presentScene(self.scene)
        
        let background = SKSpriteNode(imageNamed: "bg.png")
        background.name = self.backgroundNodeCategoryName
        background.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        self.scene!.addChild(background)
        
        self.scene!.physicsWorld.gravity = CGVectorMake(0.0,0.0)
        
        var borderBody = SKPhysicsBody(edgeLoopFromRect: self.view.frame)
        self.scene!.physicsBody = borderBody
        self.scene!.physicsBody.friction = 0.0
        //
        var ball = SKSpriteNode(imageNamed: "ball.png")
        ball.name = self.ballCategoryName
        ball.position = CGPoint(x: 50, y: 50)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody.restitution = 1.0
        ball.physicsBody.friction = 0.0
        ball.physicsBody.linearDamping = 0.0
        ball.physicsBody.allowsRotation = false
        
        self.scene!.addChild(ball)
        
        var paddle = SKSpriteNode(imageNamed: "paddle.png")
        paddle.position = CGPoint(x: 100, y: 100)
        self.scene!.addChild(paddle)
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.size)
        paddle.physicsBody.restitution = 0.1
        paddle.physicsBody.friction = 0.4
        paddle.physicsBody.dynamic = false
        paddle.name = self.paddleCategoryName
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        //Called when a touch begins
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self.scene!)
        let node = self.scene!.nodeAtPoint(touchLocation) as SKSpriteNode!
        if node.name == self.paddleCategoryName
        {
            println("Began touch on paddle")
            self.isFingerOnPaddle = true
        }
        
        self.someCrazyFunctionWithStatus("hi", andBlah: "bro")
    }
    
    func someCrazyFunctionWithStatus(status : String, andBlah blah : String) {
        
        
        println(blah)
        
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        
        if self.isFingerOnPaddle {
            let touch = touches.anyObject() as UITouch
            let touchLocation = touch.locationInNode(self.scene!)
            let previousLocation = touch.previousLocationInNode(self.scene!)
            let paddle = self.scene!.childNodeWithName(self.paddleCategoryName) as SKSpriteNode
            var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
            paddleX = max(paddleX, paddle.size.width/2)
            paddleX = min(paddleX, self.scene!.size.width - paddle.size.width/2)
            paddle.position = CGPoint(x: paddleX, y: paddle.position.y)
        }
        
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        self.isFingerOnPaddle = false
    }

}


