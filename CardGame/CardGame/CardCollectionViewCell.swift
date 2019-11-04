//
//  CardCollectionViewCell.swift
//  CardGame
//
//  Created by احلام المطيري on 04/08/2019.
//  Copyright © 2019 احلام المطيري. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card){
        
        // keep track of the card that get passed in
        self.card = card
        if card.isMatched == true{
            //if the card has been matched, then make the image views invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }else{
             //if the card has been not matched, then make the image views visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        
        frontImageView.image = UIImage(named: card.imageName)
        
        // determine if the card is in a flipped up state or flipped down state
        if card.isFlipped == true{
              // make sure the front image is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews ], completion: nil)
            
        }else{
            // make sure the back image is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip (){
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
        
    }
    func remove(){
        //remove both imageviews from being visible
        backImageView.alpha = 0
        //  Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}
