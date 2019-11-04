//
//  SoundManager.swift
//  CardGame
//
//  Created by احلام المطيري on 08/08/2019.
//  Copyright © 2019 احلام المطيري. All rights reserved.
//

import Foundation
import AVFoundation
class SoundManager {
   static var audioPlayer:AVAudioPlayer?
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
   static func playSound(_ effect:SoundEffect){
        
        var soundFilname = ""
        
        switch effect {
        case .flip:
            soundFilname = "cardflip"
            
        case .shuffle:
            soundFilname = "shuffle"
            
        case .match:
            soundFilname = "dingcorrect"
            
        case .nomatch:
            soundFilname = "dingwrong"
            
        
        }
        // get the path to the sound file inside the bundle
       let bundlePath = Bundle.main.path(forResource: soundFilname, ofType: "wav")
        guard bundlePath != nil else {
            
            print("couldn't find sounf file\(soundFilname) in the bundle" )
            return
        }
        // create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
        // create audio player object
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //play the sound
            audioPlayer?.play()
    }
        catch{
            //could not create audio player object , log the error
            print("could not create audio player object for sound file\(soundFilname)")
        }
    }
}
