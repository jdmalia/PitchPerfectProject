//
//  PlaybackViewController.swift
//  PitchPerfectProject
//
//  Created by Jason Malia on 7/9/16.
//  Copyright © 2016 Jason Malia. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackViewController: UIViewController {
    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var changeRatePitchNode: AVAudioUnitTimePitch!
    var stopTimer: NSTimer!
    
    var currentRate: Float = 1.0
    var currentPitch: Float = 0.0
    
    var pitchState: PitchState!
    var playState: PlayingState!
    let ACTIVE: CGFloat = 1, INACTIVE: CGFloat = 0.5
    
    enum ButtonType: Int { case Chipmunk=0, Vader }
    enum PitchState: Int { case Normal=0, Chipmunk, Vader }
    enum PlayingState { case Playing, NotPlaying }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        // UI
        setPlayState(.NotPlaying)
        setPitchState(.Normal)
        chipmunkButton.alpha = INACTIVE
        vaderButton.alpha = INACTIVE
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeRate(sender: UISlider) {
        currentRate = sender.value
        adjustAudio()
        print(currentRate)
    }
    
    @IBAction func changePitch(sender: UIButton) {
        // Changes pitch when Chipmunk or Vader button is pressed
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Chipmunk:
            pitchState == .Chipmunk ? setPitchState(.Normal) : setPitchState(.Chipmunk)
        case .Vader:
            pitchState == .Vader ? setPitchState(.Normal) : setPitchState(.Vader)
        }
        adjustAudio()
    }
    
    @IBAction func playAudio(sender: UIButton) {
        print("\nNow Playing")
        print("Pitch: "+String(currentPitch))
        print("Rate: "+String(currentRate) + "\n")
        
        setPlayState(.Playing)
        playSound(currentRate, pitch: currentPitch)
    }
    
    func setPitchState(state: PitchState) {
        self.pitchState = state
        switch state {
        case .Normal:
            currentPitch = 0
            chipmunkButton.alpha = INACTIVE
            vaderButton.alpha = INACTIVE
        case .Chipmunk:
            currentPitch = 1000
            chipmunkButton.alpha = ACTIVE
            vaderButton.alpha = INACTIVE
        case .Vader:
            currentPitch = -1000
            chipmunkButton.alpha = INACTIVE
            vaderButton.alpha = ACTIVE
        }
    }
    
    func setPlayState(state: PlayingState) {
        self.playState = state
        switch state {
        case .NotPlaying:
            playButton.enabled = true
        case .Playing:
            playButton.enabled = false
        }
    }
    
    func adjustAudio() {
        // If playing, adjust pitch or rate
        if(playState == .Playing) {
            changeRatePitchNode.pitch = currentPitch
            changeRatePitchNode.rate = currentRate
            //If rate changes, should really update stop timer...
        }
    }
}
