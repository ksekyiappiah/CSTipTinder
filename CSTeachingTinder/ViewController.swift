//
//  ViewController.swift
//  CSTeachingTinder
//
//  Created by cssummer16 on 6/13/16.
//  Copyright © 2016 cssummer16. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore



class ViewController: UIViewController, WKNavigationDelegate{
    var showingFront = true
    var front: UIImageView!
    var back: UIImageView!
    
    private weak var webView: WKWebView!
    
    private var userContentController: WKUserContentController!


    @IBAction func expandButton(sender: AnyObject) {
        
        loadPage("https://dribbble.com/", partialContentQuerySelector: ".dribbbles.group")
    
      
        
      
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
    
    private func createViews() {
        userContentController = WKUserContentController()
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        let views: [String: AnyObject] = ["webView": webView, "topLayoutGuide": topLayoutGuide]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide][webView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[topLayoutGuide][webView]|", options: [], metrics: nil, views: views))
        
        
        self.webView = webView
    }
    
    private func loadPage(urlString: String, partialContentQuerySelector selector: String) {
        userContentController.removeAllUserScripts()
        let userScript = WKUserScript(source: scriptWithDOMSelector(selector),
                                      injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
                                      forMainFrameOnly: true)
        
        userContentController.addUserScript(userScript)
        
        let url = NSURL(string: urlString)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    private func scriptWithDOMSelector(selector: String) -> String {
        let script =
            "var selectedElement = document.querySelector('\(selector)');" +
        "document.body.innerHTML = selectedElement.innerHTML;"
        return script
    }
    
}

