//
//  ViewController.swift
//  CSTeachingTinder
//
//  Created by cssummer16 on 6/13/16.
//  Copyright © 2016 cssummer16. All rights reserved.
//

import UIKit
import WebKit



class ViewController: UIViewController, WKNavigationDelegate{
    var showingFront = true
    var front: UIImageView!
    var back: UIImageView!

    @IBAction func expandButton(sender: AnyObject) {
        
        // UIApplication.sharedApplication().openURL(NSURL(string: "http://www.google.com")!)
        print(countLikes())
        
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup when loading the view.
        
        let draggableBackground: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
        self.view.addSubview(draggableBackground)
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func countLikes() -> Int {
        var count = 0
        if canPerformAction(#selector(DraggableViewBackground.swipeLeft), withSender: DraggableView.self) {
                count += 1
         
        }
        
        return count
        
        
        
    }
    
    func countDislikes() -> Int {
        var count = 0
        if canPerformAction(#selector(DraggableViewBackground.swipeRight), withSender: DraggableView.self) {
                count += 1
          
        }
        
        return count
    }
    
}

