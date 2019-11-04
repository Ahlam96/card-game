//
//  ViewController.swift
//  CardGame
//
//  Created by احلام المطيري on 31/07/2019.
//  Copyright © 2019 احلام المطيري. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var model = CardModel ()
    var cardArray = [Card] ()
    var firstFlippedCardIndex: IndexPath?
    var timer:Timer?
    var milliseconds:Float = 30 * 1000 // 30 second
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // call the getCard method of the card
        cardArray = model.getCard()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapesed), userInfo: nil, repeats: true)
       RunLoop.main.add(timer!, forMode: .common)
        //RunLoop.main.add(<#T##timer: Timer##Timer#>, forMode: CFRunLoopMode)
       
      
    }
    override func viewDidAppear(_ animated: Bool) {
       // soundManage.playSound(.shuffle)
        SoundManager.playSound(.shuffle)
    }
    
    // MARK: - Timer method
    @objc func timerElapesed(){
       milliseconds -= 1
        //convert to secons
       let seconds = String(format: "%.2f", milliseconds/1000)
        // set label
        timerLabel.text = "Time Remaining: \(seconds)"
        // when the time reach to zero
        if milliseconds <= 0{
            
            //Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // check if there are any cards unmatched
            checkGameEnded()
            
            
        }
    }
    
    // MARK : - UICollectionView protocol methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a cardcollectionviewcell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        //set that card for the cell
        cell.setCard(card)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check if there's any time left
        if milliseconds<=0{
            return
        }
     
        // get the cell that the user selected
      let cell =   collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false  && card.isMatched == false{
            
            cell.flip()
            
            
            // play the flip sound
           // soundManage.playSound(.flip)
            SoundManager.playSound(.flip)
            // set the status of the card
            card.isFlipped = true
            
            // determine if it's the first card or second card that's flipped over
            if firstFlippedCardIndex == nil {
                //This is the first card being flipped
                firstFlippedCardIndex = indexPath
            }else {
                // this is a second card
                // TODO: perform the matching logic
                checkForMatches(indexPath)
            }
            
        }
//        else {
//            //flip the card back
//            cell.flipBack()
//            card.isFlipped = false
//        }
//
   
    }
    //MARK: -Game Logic Method
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        // Get the cells for the two cards that were reveald
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Ger the cards for the two cards that were reveald
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // compare the two cards
      if  cardOne.imageName == cardTwo.imageName {
            
            // it's a match
        
        
        //play sound
      //  soundManage.playSound(.match)
        SoundManager.playSound(.match)
            // set the status of the cards
        cardOne.isMatched = true
        cardTwo.isMatched = true
        
            //remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
        
        //check if there are any cards left unmatched
        checkGameEnded()
        
        }else{
            // it's not a match
        
        //play sound
      //  soundManage.playSound(.nomatch)
        SoundManager.playSound(.nomatch)
        // set the status of the cards
        cardOne.isFlipped = false
        cardTwo.isFlipped = false
        
        // Flip both cards back
        cardOneCell?.flipBack()
        cardTwoCell?.flipBack()
        }
        // tell the collectionvie to reload the cell of first card if it is nil
        if cardOneCell == nil{
            collectionView.reloadItems(at:[ firstFlippedCardIndex!])
        }
        //reset the prperty that track the first card flipped
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded(){
        //determine if there are any card unmatches
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
            
        }
        //messageng varible
        var title = ""
        var message = ""
        //if not then user has won , stop the timer
        if isWon == true{
            if milliseconds > 0{
                timer?.invalidate()
            }
            title = " Congratulaions!"
            message = "You've won"
            
        }else{
            //if there are unmatched card ,check if there's any time left
            if milliseconds>0
            {
                return
            }
            title = "Game over"
            message = " You've lost"
        }
       showAlert(title, message)
    }
    func showAlert(_ title:String, _ messsage:String){
        //show won/lost messageing
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        // presentedViewController(alert, )
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

