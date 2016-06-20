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

