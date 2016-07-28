//
//  ViewController.swift
//  PitchPerfectProject
//
//  Created by Jason Malia on 7/7/16.
//  Copyright © 2016 Jason Malia. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    enum recordViewState: Int { case READY_TO_RECORD, RECORDING }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        setViewState(.READY_TO_RECORD)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        print("Recording audio...")
        setViewState(.RECORDING)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        if (session.respondsToSelector(#selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("granted")
                    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try! self.audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
                    self.audioRecorder.delegate = self
                    self.audioRecorder.meteringEnabled = true
                    self.audioRecorder.prepareToRecord()
                    self.audioRecorder.record()
                } else{
                    print("not granted")
                }
            })
            
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "playbackSegue") {
            let playbackVC = segue.destinationViewController as! PlaybackViewController
            let recordedAudioURL = sender as! NSURL
            playbackVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            self.performSegueWithIdentifier("playbackSegue", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        print("Stopped recording.")
        setViewState(.READY_TO_RECORD)
        audioRecorder.stop()
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

