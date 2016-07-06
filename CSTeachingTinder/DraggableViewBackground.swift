//
//  DraggableViewBackground.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//

import Foundation
import UIKit



class DraggableViewBackground: UIView, DraggableViewDelegate {
    var exampleCardLabels = [String]()
    var actualCardLabels: [String] = []
    var allCards: [DraggableView]!
    
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
    let intro = "Welcome To TipTinder. Swipe left if you find tip useful. Otherwise, swipe right."
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        exampleCardLabels = [intro, "first","second", "third", "last"]
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
    func textStuff() -> Void {
        if let url = NSURL(string: "https://www.hackingwithswift.com") {
            do {
                let contents = try NSString(contentsOfURL: url, usedEncoding: nil)
                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
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
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func cardSwipedRight(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
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
    
    private func parseHTMLRow(rowElement: HTMLElement) -> Chart? {
        var url: NSURL?
        var number: Int?
        var scale: Int?
        var title: String?
        // first column: URL and number
        if let firstColumn = rowElement.childAtIndex(1) as? HTMLElement {
            // skip the first row, or any other where the first row doesn't contain a number
            if let urlNode = firstColumn.firstNodeMatchingSelector("a") {
                if let urlString = urlNode.objectForKeyedSubscript("href") as? String {
                    url = NSURL(string: urlString)
                }
                // need to make sure it's a number
                let textNumber = firstColumn.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                number = Int(textNumber)
            }
        }
        if (url == nil || number == nil) {
            return nil // can't do anything without a URL, e.g., the header row
        }
        
        if let secondColumn = rowElement.childAtIndex(3) as? HTMLElement {
            let text = secondColumn.textContent
                .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                .stringByReplacingOccurrencesOfString(",", withString: "")
            scale = Int(text)
        }
        
        if let thirdColumn = rowElement.childAtIndex(5) as? HTMLElement {
            title = thirdColumn.textContent
                .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                .stringByReplacingOccurrencesOfString("\n", withString: "")
        }
        
        if let title = title, url = url, number = number, scale = scale {
            return Chart(title: title, url: url, number: number, scale: scale)
        }
        return nil
    }
    
    
    
}