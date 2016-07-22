//
//  ViewController.swift
//  CSTeachingTinder
//
//  Created by cssummer16 on 6/13/16.
//  Copyright © 2016 cssummer16. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import Kanna








class ViewController: UIViewController, WKNavigationDelegate{
    
    private weak var webView: WKWebView!
    
  
    private var userContentController: WKUserContentController!

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
    
    
 
    
   
    
    
   
}

