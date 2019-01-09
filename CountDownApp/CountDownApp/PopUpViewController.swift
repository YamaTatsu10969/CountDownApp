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
    
    //Todo
    func showError(){
        let aleatController = UIAlertController(title: "Error", message: "Please enter the correct number", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        aleatController.addAction(defaultAction)
        self.present(aleatController,animated: true, completion: nil)
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
        // 以下の条件の時は遷移させない、入力されていない時か、無効な文字が入っている時
        if sendNumber == 0.00 {
            showError()
            return false
        }
        return true
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
            let view = segue.destination as! ViewController
            view.receivedNumber = sendNumber
        }
    }
    
}
