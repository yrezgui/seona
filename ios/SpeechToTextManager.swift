//
//  SpeechToTextManager.swift
//  Seona
//
//  Created by Yacine Rezgui on 28/01/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Foundation
import WatsonDeveloperCloud

@objc(SpeechToTextManager)
class SpeechToTextManager: NSObject {

  var sttService:SpeechToText!
  var recorder:AVAudioRecorder!
  var audioPlayer:AVAudioPlayer!
  
  @objc func startService(username: String, password: String) -> Void {
    NSLog("%@ %@", username, password);
    self.sttService = SpeechToText(username: username, password: password)
  }
  
  @objc func startRecording(callback: RCTResponseSenderBlock) -> Void {
    NSLog("recording...")
    
    let filePath    = NSURL(fileURLWithPath: "\(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])/SpeechToTextRecording.wav")
    
    let session = AVAudioSession.sharedInstance()
    var settings = [String: AnyObject]()
    
    settings[AVSampleRateKey] = NSNumber(float: 44100.0)
    settings[AVNumberOfChannelsKey] = NSNumber(int: 1)
    do {
      try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
      self.recorder = try AVAudioRecorder(URL: filePath, settings: settings)
    } catch {
      // error
    }
    
    callback([self.recorder.record()])
  }
  
  @objc func stopRecording() -> Void {
    NSLog("stop recording...")
    self.recorder.stop()
  }
  
  @objc func play() -> Void {
    NSLog("stop recording...")
    
    let filePath    = NSURL(fileURLWithPath: "\(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])/SpeechToTextRecording.wav")
    
    do {
      try self.audioPlayer = AVAudioPlayer(contentsOfURL: filePath)
      self.audioPlayer.prepareToPlay()
      self.audioPlayer.play()
    } catch {
      // error
    }
  }
  
  @objc func transcript(callback: RCTResponseSenderBlock) -> Void {
    NSLog("transcripting...")
    
    let data = NSData(contentsOfURL: self.recorder.url)
    
    if let data = data {
      
      self.sttService.transcribe(data , format: .WAV, completionHandler: {response, error -> Void in
        callback([(response?.transcription())!])
      })
    }
  }
}
