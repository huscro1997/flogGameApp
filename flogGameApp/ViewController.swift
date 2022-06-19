//
//  ViewController.swift
//  flogGameApp
//
//  Created by 曾曜澤 on 2022/6/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var time:Timer?
    var cards = [Card]()
    var pickedCard = [Int]()
    var pair = 0
    
    var seeTime = 4
    var gameTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameInit()
    }
    
    func gameInit()->Void{
        timeLabel.text = String(seeTime)
        scoreLabel.text = String(pair)
        
        cards = [
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
        cards.shuffle()
        displayCards()
        
    }
    
    func displayCards() {
        for (i,_) in cards.enumerated(){
            cardButtons[i].setImage(cards[i].cardImage, for: .normal)
            cards[i].flipped = true
        }
        if time == nil {
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        }
    }
    
    @objc func countDown() {
        seeTime -= 1
        if seeTime == 0 {
            time?.invalidate()
            time = nil
            for (i,_) in cards.enumerated() {
                cardButtons[i].setImage(UIImage(named: "Pokeball"), for: .normal)
                UIView.transition(with: cardButtons[i], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                cards[i].flipped = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.timeLabel.text = String(self.gameTime)
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.gameTimeCountDown), userInfo: nil, repeats: true)
            }
        }
        timeLabel.text = String(seeTime)
    }
    //卡片翻面
    func filp(index:Int) {
        if cards[index].flipped == false {
            cardButtons[index].setImage(cards[index].cardImage, for: .normal)
            UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            cards[index].flipped = true
        } else {
            cardButtons[index].setImage(UIImage(named: "Pokeball"), for: .normal)
            UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            cards[index].flipped = false
        }
    }
    @objc func gameTimeCountDown() {
        gameTime -= 1
        timeLabel.text = String(gameTime)
        if gameTime == 0 {
            time?.invalidate()
            time = nil
            let timeOutAlert = UIAlertController(title: "Time Out", message: "Try Again", preferredStyle: .alert)
            let timeOutAction = UIAlertAction(title: "Restart", style: .default) { (_) in
                self.restart()
                }
            timeOutAlert.addAction(timeOutAction)
            present(timeOutAlert, animated: true, completion: nil)
            }
        }
    func restart() {
        seeTime = 4
        gameTime = 60
        pair = 0
        pickedCard.removeAll()
        
        for i in cardButtons{
            i.isEnabled = true
        }
        gameInit()
    }
    
    @IBAction func flipCard(_ sender: UIButton) {
        if let cardNum = cardButtons.firstIndex(of: sender){
            pickedCard.append(cardNum)
            filp(index: cardNum)
            //判斷卡片是否相同
            if pickedCard.count == 2 {
                //相同
                if cards[pickedCard[0]].cardName==cards[pickedCard[1]].cardName {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        self.pair += 100
                        self.scoreLabel.text = String(self.pair)
                        for i in self.pickedCard{
                            self.cardButtons[i].isEnabled = false
                            UIView.transition(with: self.cardButtons[i], duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                        }
                        if self.pair == 600 {
                            self.time?.invalidate()
                            self.time = nil
                            let gameCompleteAlert = UIAlertController(title: "Game Complete", message: "Awesome!", preferredStyle: .alert)
                            let gameCompleteAction = UIAlertAction(title: "Restart", style: .default) { (_) in
                                self.restart()
                            }
                            gameCompleteAlert.addAction(gameCompleteAction)
                            self.present(gameCompleteAlert, animated: true, completion: nil)
                        }
                        self.pickedCard.removeAll()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        for i in self.pickedCard{
                            self.filp(index: i)
                        }
                        self.pickedCard.removeAll()
                    }
                }
            }
                
            
        }
    }
    

}
    
