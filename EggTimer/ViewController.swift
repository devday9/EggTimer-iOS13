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
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //MARK: - Properties
    // 300, 420, 720
    let eggTimes = ["Soft" : 5, "Medium" : 6, "Hard" : 7]
    var timer = Timer()
    var player: AVAudioPlayer?
    var isPlaying = false
    var totalTime = 0
    var secondsPassed = 0
    
    //MARK: - Actions
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBar.progress = 1.0
        
        timer.invalidate()
        
        guard  let hardness = sender.currentTitle else { return }
        
        totalTime = eggTimes[hardness] ?? 0
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //MARK: - Helper Functions
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        }
    }
}//END OF CLASS
