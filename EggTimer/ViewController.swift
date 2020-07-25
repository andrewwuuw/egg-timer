//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

var counter = 0
var originCount = 0
var progress: Float = 0
var timerTest: Timer?
let eggTimes = [
    "Soft": 5,
    "Medium": 8,
    "Hard": 12
]

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        progressBarView.alpha = 0
    }
    
    //MARK: - UI
    @IBOutlet weak var remainningTimeLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    //MARK: - Actions
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle,
            let eggTime = eggTimes[senderTitle] else { return }
        
        counter = eggTime
        originCount = counter
        progressBarView.alpha = 1
        startTimer()
    }

    //MARK: - private methods
    private func startTimer() {
        NSLog("* Time Start")
        remainningTimeLabel.text = "Remainning Time: \(counter)s"
        guard timerTest == nil else { return }
        timerTest = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(costDownCounter),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func stopTimer() {
        NSLog("* Time Stop")
        timerTest?.invalidate()
        timerTest = nil
        remainningTimeLabel.text = "Time out!"
        progressBarView.alpha = 0
    }
    
    //MARK: - @objc methods
    @objc func costDownCounter() {
        if counter > 0 {
            print("\(counter)s to the end of the world")
            remainningTimeLabel.text = "Remainning Time: \(counter)s"
            progressBarView.progress = 1 - Float(counter) / Float(originCount)
            counter -= 1
        } else {
            stopTimer()
        }
    }
}
