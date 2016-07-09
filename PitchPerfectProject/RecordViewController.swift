//
//  ViewController.swift
//  PitchPerfectProject
//
//  Created by Jason Malia on 7/7/16.
//  Copyright © 2016 Jason Malia. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    enum recordViewState {
        case READY_TO_RECORD
        case RECORDING
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        print("Recording audio...")
        setViewState(.RECORDING)
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        print("Stopped recording.")
        setViewState(.READY_TO_RECORD)
        //performSegueWithIdentifier("playbackSeque", sender: )
    }
    
    override func viewWillAppear(animated: Bool) {
        setViewState(.READY_TO_RECORD)
    }
    
    func setViewState(state: recordViewState){
        // Set up state of buttons/label
        switch state {
            
        case .READY_TO_RECORD:
            recordButton.enabled = true
            recordButton.hidden = false
            stopButton.enabled = false
            stopButton.hidden = true
            recordingLabel.text = "Record Audio"
            
        case .RECORDING:
            recordButton.enabled = false
            recordButton.hidden = true
            stopButton.enabled = true
            stopButton.hidden = false
            recordingLabel.text = "Stop Recording"
            
        }
    }

}

