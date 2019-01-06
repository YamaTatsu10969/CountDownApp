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
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var setButton: UIButton!
    
    var count:Double = 0.00
    var timer = Foundation.Timer()
    var inputNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let num = self.inputNumber{
            if let doubleNum = Double(num){
                self.count = doubleNum
            }
        }else{
            //initilal setting
            self.CountLabel.text = "03:00:00"
            self.count = 180
        }
        
        calcAndShowResult()
        setButtonEnabled(start: true, stop: false, reset: false, set: true)
    }
    
    func setButtonEnabled(start: Bool, stop:Bool,reset:Bool,set:Bool){
        self.playButton.isEnabled = start
        self.pauseButton.isEnabled = stop
        self.resetButton.isEnabled = reset
        self.setButton.isEnabled = set
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
        setButtonEnabled(start: false, stop: true, reset: false, set: false)
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
        //Intで小数点を丸める前に100をかけたものから、丸めた後を引くとmsecが出る
        let msec =  Int(count * 100) - (Int(count) * 100)
        self.CountLabel.text = String(format:"%02d:%02d:%02d", min, sec, msec)
    }
    
    @IBAction func didTouchedPauseButton(_ sender: Any) {
        setButtonEnabled(start: true, stop: false, reset: true, set: true)
        self.timer.invalidate()
    }
    
    @IBAction func didTouchedResetButton(_ sender: Any) {
        setButtonEnabled(start: true, stop: false, reset: false, set: true)
        count = 0.00
        calcAndShowResult()
    }
}

