//
//  ViewController.swift
//  CSTeachingTinder
//
//  Created by cssummer16 on 6/13/16.
//  Copyright © 2016 cssummer16. All rights reserved.
//

import UIKit
//import WebKit


class ViewController: UIViewController /*WKNavigationDelegate */{

    
    
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
    
    
    
 /*   @IBAction func expandWhenTapped(sender: UIButton) {
        // fucntion to execute when Expand button is tapped
        
        // self.ExpandButton.setTitle("COLLAPSE", forState: UIControlState.Normal)
        var webView: WKWebView!
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
       
        
        
        func openTapped() {
            
            
            let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .ActionSheet)
            ac.addAction(UIAlertAction(title: "apple.com", style: .Default, handler: openPage))
            ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .Default, handler: openPage))
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            
        }
        
       
        
        func openPage(action: UIAlertAction!) {
            let url = NSURL(string: "https://" + action.title!)!
            webView.loadRequest(NSURLRequest(URL: url))
        }
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: Selector(openTapped()))
 
 
        
       let url = NSURL(string: "http://apple.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
      
        
    }*/
}

