//
//  ViewController.swift
//  playingCards_again
//
//  Created by minsoo kim on 2018. 9. 9..
//  Copyright © 2018년 minsoo kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()
    
    
    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet {
            let swipe = UISwipeGestureRecognizer(target:self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            let pinchSelector = #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizerBy:))
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: pinchSelector)
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: playingCardView.isFaceUp =  !playingCardView.isFaceUp
        default : break
        }
    }
    
    @objc func nextCard(){
        if let card = deck.draw(){
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
}

