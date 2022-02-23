//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var alarmPlayer: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        progressBar.progress = 0.0
        self.titleLabel.text = "How do you like your eggs?"
        timer.invalidate()
        
        countdown(minutes: eggTimes[hardness]!)
    }
    
    func countdown (minutes: Int){
        
        var secondsCounter = 1;
        let immutableSeconds: Float = Float(minutes) * 1 //Lo dejamos como minutos para hacer las pruebas rápido (5 segundos, 7 y 12)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
                    self.progressBar.progress = Float(secondsCounter)/Float(immutableSeconds)
                    if Float(secondsCounter) < immutableSeconds {
                        secondsCounter += 1
                    } else {
                        self.progressBar.progress = Float(secondsCounter)/Float(immutableSeconds)
                        Timer.invalidate()
                        self.titleLabel.text = "Done"
                        self.playAlarm()
                    }
                })
        
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            alarmPlayer = try! AVAudioPlayer(contentsOf: url!)
            alarmPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
