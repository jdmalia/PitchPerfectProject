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
    
    var recordedAudioURL: NSURL!
    var currentRate: Float!
    var currentPitch: Float = 0.0
    var state: PlaybackState = .Normal
    
    let ACTIVE: CGFloat = 1, INACTIVE: CGFloat = 0.5
    
    enum ButtonType: Int { case Chipmunk=0, Vader }
    enum PlaybackState: Int { case Normal=0, Chipmunk, Vader }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chipmunkButton.alpha = INACTIVE
        vaderButton.alpha = INACTIVE
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // configureUI(playState: .NotPlaying)
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
            state == .Chipmunk ? changeState(.Normal) : changeState(.Chipmunk)
        case .Vader:
            state == .Vader ? changeState(.Normal) : changeState(.Vader)
        }
        adjustAudio()
    }
    
    @IBAction func playAudio(sender: UIButton) {
        print("\nNow Playing")
        print("Pitch: "+String(currentPitch))
        print("Rate: "+String(currentRate) + "\n")
    }
    
    func changeState(state: PlaybackState) {
        self.state = state
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
    
    func adjustAudio() {
        // If playing, adjust pitch or rate
    }
}
