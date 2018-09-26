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
    
    
    @IBOutlet private var cardViews: [PlayingCardView]!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count+1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = true
            let card = cards.remove(at: cards.count.arc4Random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
        }
    }
}
