//
//  PopUpViewController.swift
//  CountDownApp
//
//  Created by 山本竜也 on 2019/1/7.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var inputMinuteNumberText: UITextField!
    @IBOutlet weak var inputSecondNumberText: UITextField!
    
    
    var sendNumber:Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        //質問：なんでこれでreturnにならないのか
        //        guard let num = self.inputNumberText.text else {
        //            return
        //        }
        
        if identifier == "setCountNumber"{
            
            
            
            if self.sendNumber == 0.00 {
                print("error!!!")
                // TODO:error()
            }else{
                let view = segue.destination as! ViewController
                view.receivedNumber = sendNumber
            }
        }
    }
    
    //Todo
    func error(){
        
    }
    
    func calcSendNumber(){
        var tmpSecond = 0.00
        var tmpMinute = 0.00
        if let num = self.inputSecondNumberText.text {
            tmpSecond = convertToDouble(inputNum: num)
        }
        if let num = self.inputMinuteNumberText.text {
            tmpMinute = convertToDouble(inputNum: num)
        }
        sendNumber = (tmpMinute * 60) + tmpSecond
    }
    
    func convertToDouble(inputNum:String)-> Double{
        let convertNum = inputNum
        guard let doubleNum = Double(convertNum) else{
            //self.sendNumber = doubleNum
            return 0.00
        }
        return doubleNum
    }
    
    //prepareよりもこっちの方が早い
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        calcSendNumber()
        // 以下の条件の時は遷移させない
        if sendNumber == 0.00 {
            return false
        }
        return true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
