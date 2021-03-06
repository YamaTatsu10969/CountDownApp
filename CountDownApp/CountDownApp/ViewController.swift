//
//  ViewController.swift
//  CountDownApp
//
//  Created by 山本竜也 on 2019/1/5.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var setButton: UIButton!
    
    var player: AVAudioPlayer!
    
    var count:Double = 0.00
    var timer = Foundation.Timer()
    var receivedNumber = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This font don't shake
        CountLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 42, weight: UIFont.Weight.black)
        
        if receivedNumber == 0.00 {
            //initilal setting
            self.count = 180
        }else {
            self.count = receivedNumber
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
        
    }
    
    @IBAction func didTouchedPlayButton(_ sender: Any) {
        setButtonEnabled(start: false, stop: true, reset: false, set: false)
        timer = Foundation.Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func update(){
        count -= 0.01
        calcAndShowResult()
        judgeTimeOut()
    }
    
    func judgeTimeOut(){
        if count < 0 {
            resetCount()
            soundAlerm()
            showAlarmStop()
            setButtonEnabled(start: false, stop: false, reset: true, set: true)
        }
    }
    
    func soundAlerm(){
        audioPlayerDif()
        player.play()
    }
    
    // 音楽コントローラ AVAudioPlayerを定義(変数定義、定義実施、クリア）
    func audioPlayerDif(){
        // 音声ファイルのパスを定義 ファイル名, 拡張子を定義
        let audioPath = URL(fileURLWithPath: Bundle.main.bundlePath).appendingPathComponent("alarm.mp3")
        //ファイルが存在しない、拡張子が誤っている、などのエラーを防止するために実行テスト(try)する。
        do{
            //tryで、ファイルが問題なければ player変数にaudioPathを定義
            player = try AVAudioPlayer(contentsOf: audioPath)
        }catch{
            print("audiPath is not exist!")
        }
        
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
        resetCount()
    }
    
    func resetCount(){
        setButtonEnabled(start: true, stop: false, reset: false, set: true)
        count = 0.00
        calcAndShowResult()
        self.timer.invalidate()
    }
    
    //
    func showAlarmStop(){
        let aleatController = UIAlertController(title: "Time's Up!", message: "Please tap STOP", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "STOP", style: .default, handler: {
            (action: UIAlertAction!) in
            self.player.stop()
        })
        aleatController.addAction(defaultAction)
        self.present(aleatController,animated: true, completion: nil)
    }
}

