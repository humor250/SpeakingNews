//
//  SynthesisSpeak.swift
//  SayingNews
//
//  Created by duoda james on 2018/9/8.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import AVFoundation

class SynthesisSpeak: NSObject {
    static let shared = SynthesisSpeak()
    
    let synth = AVSpeechSynthesizer()
    let audioSession = AVAudioSession.sharedInstance()
    
    override init() {
        super.init()
        
        synth.delegate = self
    }
    
    func say(sentence: String) {
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
            
            let utterance = AVSpeechUtterance(string: sentence)
            //utterance.pitchMultiplier = -2.0
            try audioSession.setActive(true)
            
            synth.speak(utterance)
        } catch {
            print("Uh oh!")
        }
    }
    
    func stop(at: AVSpeechBoundary) {
        do {
            synth.stopSpeaking(at: at)
            try audioSession.setActive(false)
        } catch {
            print("Uh oh!")
        }
    }
}

extension SynthesisSpeak: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        do {
            try audioSession.setActive(false)
        } catch {
            print("Uh oh!")
        }
    }
}
