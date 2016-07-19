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
        print(currentRate)
    }
}
