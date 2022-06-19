//
//  card.swift
//  flogGameApp
//
//  Created by 曾曜澤 on 2022/6/19.
//

import Foundation
import UIKit

struct Card {
    var cardName:String?
    var cardImage:UIImage?
    var flipped:Bool? = false
}

var cards = [
    Card(cardName: "0", cardImage: UIImage(named: "pic0")),
    Card(cardName: "1", cardImage: UIImage(named: "pic1")),
    Card(cardName: "2", cardImage: UIImage(named: "pic2")),
    Card(cardName: "3", cardImage: UIImage(named: "pic3")),
    Card(cardName: "4", cardImage: UIImage(named: "pic4")),
    Card(cardName: "5", cardImage: UIImage(named: "pic5")),
    
    Card(cardName: "0", cardImage: UIImage(named: "pic0")),
    Card(cardName: "1", cardImage: UIImage(named: "pic1")),
    Card(cardName: "2", cardImage: UIImage(named: "pic2")),
    Card(cardName: "3", cardImage: UIImage(named: "pic3")),
    Card(cardName: "4", cardImage: UIImage(named: "pic4")),
    Card(cardName: "5", cardImage: UIImage(named: "pic5")),
    ]
