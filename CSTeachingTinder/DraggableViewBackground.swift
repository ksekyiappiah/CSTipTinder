//
//  DraggableViewBackground.swift
//  CSTeachingTinder
//
//  Created by cssummer16 on 6/13/16.
//  Copyright (c) 2015 gcweb. All rights reserved.
//

import Foundation
import UIKit
import Kanna





class DraggableViewBackground: UIView, DraggableViewDelegate {
    var exampleCardLabels = [String]()
    var actualCardLabels = [String]()
    var allCards: [DraggableView]!
    var myWebView: UIWebView!
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 290
    
    
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    var menuButton: UIButton!
    var messageButton: UIButton!
    var checkButton: UIButton!
    var xButton: UIButton!
    var expandButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
       
        exampleCardLabels = []
        
        for var i = 0 ; i <= 10000; ++i {
          
            exampleCardLabels.append("No Internet Connection")
        }
        actualCardLabels = []
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()
    }
    
    func setupView() -> Void {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        xButton = UIButton(frame: CGRectMake((self.frame.size.width - CARD_WIDTH)/2 + 35, self.frame.size.height/2 + CARD_HEIGHT/2 + 10, 59, 59))
        xButton.setImage(UIImage(named: "xButton"), forState: UIControlState.Normal)
        xButton.addTarget(self, action: "swipeLeft", forControlEvents: UIControlEvents.TouchUpInside)
        
        checkButton = UIButton(frame: CGRectMake(self.frame.size.width/2 + CARD_WIDTH/2 - 85, self.frame.size.height/2 + CARD_HEIGHT/2 + 10, 59, 59))
        checkButton.setImage(UIImage(named: "checkButton"), forState: UIControlState.Normal)
        checkButton.addTarget(self, action: "swipeRight", forControlEvents: UIControlEvents.TouchUpInside)
        
      
    
        self.addSubview(xButton)
        self.addSubview(checkButton)
        
      
        
    }
    
   
    
    func displayURL() {
        let webView = UIWebView(frame: self.bounds)
        self.addSubview(webView)
        
        let URL = NSURL(string: "http://csteachingtips.org/random-tip")
        webView.loadRequest(NSURLRequest(URL: URL!))
        print(webView.loading)
    }

    
  
    func createDraggableViewWithDataAtIndex(index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT))
       draggableView.information.text = exampleCardLabels[index]
       
        draggableView.information.adjustsFontSizeToFitWidth = true
        draggableView.information.numberOfLines = 10
        draggableView.delegate = self
        return draggableView
    }
    
    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for var i = 0; i < exampleCardLabels.count; i++ {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
             
                allCards.append(newCard)
                
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                    if Reachability.isConnectedToNetwork() == true {
                        newCard.displayURL()
                    } else {
                        print("Internet connection FAILED")
                        var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    
                }
                
            }
            
            for var i = 0; i < loadedCards.count; i++ {
                if i > 0 {
                    self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                    
                } else {
                    self.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }
    
    func cardSwipedLeft(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            if Reachability.isConnectedToNetwork() == true {
                allCards[cardsLoadedIndex].displayURL()
                cardsLoadedIndex = cardsLoadedIndex + 1
                self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            } else {
                print("Internet connection FAILED")
                var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }

         
        }
    }
    
    func cardSwipedRight(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            if Reachability.isConnectedToNetwork() == true {
                allCards[cardsLoadedIndex].displayURL()
                cardsLoadedIndex = cardsLoadedIndex + 1
                self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            } else {
                print("Internet connection FAILED")
                var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
           
        }
    }
    
  
    
    func swipeRight() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
        UIView.animateWithDuration(0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        UIView.animateWithDuration(0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
    

    
    
    
}