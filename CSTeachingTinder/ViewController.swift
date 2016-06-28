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
    
    private weak var webView: WKWebView!
    
    private var userContentController: WKUserContentController!


    @IBAction func expandButton(sender: AnyObject) {
    
        // Set the page URL we want to download
        let URL = NSURL(string: "http://iswift.org")
        
        // Try downloading it
        do {
            let htmlSource = try String(contentsOfURL: URL!, encoding: NSUTF8StringEncoding)
            print(htmlSource)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        //loadPage("https://dribbble.com/", partialContentQuerySelector: ".dribbbles.group")
    
      
        
      
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

