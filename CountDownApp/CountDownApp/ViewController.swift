//
//  ViewController.swift
//  CountDownApp
//
//  Created by 山本竜也 on 2019/1/5.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CountLabel: UILabel!
    
    var count:Double = 180.00
    var timer = Foundation.Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CountLabel.text = "03:00:00"
    }
    
    
    @IBAction func didTouchedSettingButton(_ sender: Any) {
//        guard let input = CountLabel.text else {
//            return
//        }
//        guard let changeDouble = Double(input) else{
//            return
//        }
//        self.count = changeDouble
    }
    
    @IBAction func didTouchedPlayButton(_ sender: Any) {
        
        timer = Foundation.Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    @objc func update(){
        count -= 0.01
        calcAndShowResult()

    }
    
    func calcAndShowResult(){
        let t = count
        let min = Int(t/60)
        let sec = Int(t)%60
        let msec =  Int(count * 100) - (Int(count) * 100)
        self.CountLabel.text = String(format:"%02d:%02d:%02d", min, sec, msec)
    }
    
    @IBAction func didTouchedPauseButton(_ sender: Any) {
        self.timer.invalidate()
    }
    
    @IBAction func didTouchedResetButton(_ sender: Any) {
        count = 0.00
        calcAndShowResult()
    }
}

