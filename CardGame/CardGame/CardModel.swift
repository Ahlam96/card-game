//
//  CardModel.swift
//  CardGame
//
//  Created by احلام المطيري on 31/07/2019.
//  Copyright © 2019 احلام المطيري. All rights reserved.
//

import Foundation
class CardModel{
    
    
    func getCard() -> [Card] {
        
        // declare an array to store number we have already generated
        var generatedNumbersArray = [Int]()
        
        
        //declare an array to store the generated card
        var generatedCardArray = [Card]()
        
        // randomly generate pairs of cards
        while generatedNumbersArray.count < 8{
            
            let randomnumber = arc4random_uniform(13) + 1
            
            //ensure that the random number is not one we already have
            if generatedNumbersArray.contains(Int(randomnumber)) == false {
              
                print (randomnumber)
                
                //store into the generated number array
                generatedNumbersArray.append(Int(randomnumber))
                
                let cardOne = Card()
                cardOne.imageName = "card\(randomnumber)"
                generatedCardArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomnumber)"
                generatedCardArray.append(cardTwo)
                
            }
            
            
            
            
            // make it so we only have uniqe pairs of card
        }
        // Randomize the array
        for i in 0...generatedCardArray.count-1{
            //find a random index to swap with
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardArray.count)))
            
            // swap the two card
            
            let temporaryStorage = generatedCardArray[i]
            generatedCardArray[i] = generatedCardArray[randomNumber]
            generatedCardArray[1] = temporaryStorage
        }
        
        //return the array
        return generatedCardArray
    }
}
