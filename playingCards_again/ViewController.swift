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
    override func viewDidLoad(){
        super.viewDidLoad()
        var card = deck.draw()
        while card != nil{
            print("\(card!)")
            card = deck.draw()
        }
    }
}

