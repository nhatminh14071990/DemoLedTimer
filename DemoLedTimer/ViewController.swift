//
//  ViewController.swift
//  DemoLedTimer
//
//  Created by Van Ho Si on 9/22/17.
//  Copyright © 2017 Van Ho Si. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberBall:Int = 9//max 9, lon hon se xay ra loi do sai toa do cua tung bong den led, khi nao co time se fix
    let marginTop: CGFloat = 300
    let marginBottom: CGFloat = 30
    let marginLeft: CGFloat = 30
    let marginRight: CGFloat = 30
    var widthBall: CGFloat = 0
    var heightBall: CGFloat = 0
    
    var lastOnLed: String = "-1"
    let prefixTag = 10000000
    var currentCycle = "right"
    var ballsIsTurnOn = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.drawBall()
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.running), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @objc func running(){
//        var arrayOfLastOnLed = [String]()
//        var arrayOfLastOnLedTemp = Array(lastOnLed.characters)
//        if(arrayOfLastOnLedTemp.count > 2){
//            var tempString: String = ""
//            for i in 0..<(arrayOfLastOnLedTemp.count - 1){
//                tempString = tempString + String(arrayOfLastOnLedTemp[i])
//            }
//
//            arrayOfLastOnLed.append(tempString)
//
//            let numberLast = String(arrayOfLastOnLedTemp[arrayOfLastOnLedTemp.count - 1])
//
//            arrayOfLastOnLed.append(numberLast)
//        }else{
//            arrayOfLastOnLed.append(String(arrayOfLastOnLedTemp[0]))
//            arrayOfLastOnLed.append(String(arrayOfLastOnLedTemp[1]))
//        }
        
        self.turnOffLed()
        
//        print("ballsIsTurnOn.count: \(ballsIsTurnOn.count)")
        if(ballsIsTurnOn.count == numberBall * numberBall){
            ballsIsTurnOn = []
            lastOnLed = "-1"
            currentCycle = "right"
        }
        
        var arrayOfLastOnLed = Array(lastOnLed.characters)
        
//        print("arrayOfLastOnLed: \(arrayOfLastOnLed)")
        
        
        
        switch currentCycle {
            case "right":
                if(lastOnLed == "-1"){
                    lastOnLed = "11"
                }else{
                    var n = Int(String(arrayOfLastOnLed[0]))!
                    n = n + 1
                    let tag = String(n) + String(arrayOfLastOnLed[1])
                    let existBall = self.isExistsBall(tag: tag)
                    
                    if(existBall == true && !ballsIsTurnOn.contains(tag)){
                        lastOnLed = tag
//                        print("right-lastOnLed: \(lastOnLed)")
                    }else{
//                        print("down")
                        currentCycle = "down"
                    }
                    
                }
                break;
            case "down":
                
                var n = Int(String(arrayOfLastOnLed[1]))!
                n = n + 1
                
                let tag = String(arrayOfLastOnLed[0]) + String(n)
                let existBall = self.isExistsBall(tag: tag)
                
                if(existBall == true && !ballsIsTurnOn.contains(tag)){
                    lastOnLed = tag
//                    print("down-lastOnLed: \(lastOnLed)")
                }else{
//                    print("left")
                    currentCycle = "left"
                }
                
                break
            case "left":
                var n = Int(String(arrayOfLastOnLed[0]))!
                
                n = n - 1
                let tag = String(n) + String(arrayOfLastOnLed[1])
                let existBall = self.isExistsBall(tag: tag)
                
                if(existBall == true && !ballsIsTurnOn.contains(tag)){
                    lastOnLed = tag
//                    print("left-lastOnLed: \(lastOnLed)")
                }else{
//                    print("up")
                    currentCycle = "up"
                }
                
                break
            
            case "up":
                var n = Int(String(arrayOfLastOnLed[1]))!
                
                n = n - 1
                
                let tag = String(arrayOfLastOnLed[0]) + String(n)
                let existBall = self.isExistsBall(tag: tag)
                
                if(existBall == true && !ballsIsTurnOn.contains(tag)){
                    lastOnLed = tag
//                    print("Up - lastOnLed: \(lastOnLed)")
                }else{
//                    print("right")
                    currentCycle = "right"
                    
                }
                
                break
            
            default:
                print("nothing")
                break
        }
        
        if(!ballsIsTurnOn.contains(lastOnLed)){
            ballsIsTurnOn.append(lastOnLed)
        }
        self.turnOnLed()
    }
    
    func isExistsBall(tag: String) -> Bool{
//        print("inputTag: \(tag)")
        let newTag = Int(tag)! + prefixTag
        if (self.view.viewWithTag(newTag) as? UIImageView) != nil{
            return true
        }
        return false
    }
    
    func turnOnLed(){
        
        if let ball = self.view.viewWithTag((prefixTag + Int(lastOnLed)!)) as? UIImageView{
            ball.image = UIImage(named: "green")
        }
    }
    
    func turnOffLed(){
        
        if let ball = self.view.viewWithTag((prefixTag + Int(lastOnLed)!)) as? UIImageView{
            ball.image = UIImage(named: "grey")
        }
    }
    
    func drawBall(){
//        print("numberBall: \(numberBall)")
        
        if(numberBall > 0){
            let image = UIImage(named: "grey")
            widthBall = CGFloat(image!.size.width)
            heightBall = CGFloat(image!.size.height)
            
            let spaceWith = self.spaceWidthBetweenBall()
            let spaceHeight = self.spaceHeightBetweenBall()
            
            for index in 1...numberBall{
                
                let positionX = marginLeft + (CGFloat(index - 1) * spaceWith)
                
                for i in 1...numberBall{
                    let positionY = marginTop + (CGFloat(i - 1) * spaceHeight)
                    
                    let ball = UIImageView(image: image)
                    ball.center = CGPoint(x: positionX, y: positionY)
                    
                    let indexTag = Int(String(index) + String(i))!
                    let tag = prefixTag + indexTag
//                    print("tag: \(tag)")
                    ball.tag = tag
                    
                    self.view.addSubview(ball)
                    
                }
                
            }
        }
        
        
    }
    
    
    
    func spaceHeightBetweenBall() -> CGFloat{
        
        
        let totalHeightSpace = self.view.bounds.size.height - marginTop - marginBottom
        
        let space = totalHeightSpace / CGFloat(numberBall - 1)
        return space
        
    }
    
    func spaceWidthBetweenBall() -> CGFloat{
        
        
        let totalWidthSpace = self.view.bounds.size.width - marginLeft - marginRight
        
        let space = totalWidthSpace / CGFloat(numberBall - 1)
        return space
    }
    
}

