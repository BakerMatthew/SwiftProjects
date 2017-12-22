//
//  ViewController.swift
//  TextAndColors
//
//  Created by Matt Baker, A01536520 on 1/21/16.
//  Copyright (c) 2016 USU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myLabel: UILabel!
	
    let myLabelArray : [String] = ["This", "label", "keeps", "changing", "what", "it", "says", "!"]
    var myLabelArrayIndex = 0
    
    @IBAction func changeTextButton(_ sender: AnyObject) {
        myLabel.text = myLabelArray[myLabelArrayIndex]
        
        myLabelArrayIndex += 1
        if myLabelArrayIndex >= myLabelArray.count {
            myLabelArrayIndex = 0
        }
    }
    
    @IBAction func redButton(_ sender: AnyObject) {
        myLabel.textColor = UIColor.red
    }
    @IBAction func orangeButton(_ sender: AnyObject) {
        myLabel.textColor = UIColor.orange
    }
    @IBAction func yellowButton(_ sender: AnyObject) {
        myLabel.textColor = UIColor.yellow
    }
    @IBAction func greenButton(_ sender: AnyObject) {
        myLabel.textColor = UIColor.green
    }
    @IBAction func blueButton(_ sender: AnyObject) {
        myLabel.textColor = UIColor.blue
    }
    @IBAction func violetButton(_ sender: AnyObject) {
        myLabel.textColor = UIColor.purple
    }
    
    let randomColorArray : [UIColor] = [UIColor.black, UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple]
    var currentColor = 0
    
    @IBAction func randomColorButton(_ sender: AnyObject) {
        var nextColor = Int(arc4random()) % randomColorArray.count
        while currentColor == nextColor {
            nextColor = Int(arc4random()) % randomColorArray.count
        }
        currentColor = nextColor
        
        myLabel.textColor = randomColorArray[currentColor]
    }
}

