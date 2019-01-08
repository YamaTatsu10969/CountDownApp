//
//  PopUpViewController.swift
//  CountDownApp
//
//  Created by 山本竜也 on 2019/1/7.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var inputNumberText: UITextField!
    
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
            
            if let num = self.inputNumberText.text {
                convertToDouble(num: num)
            }
            
            if self.sendNumber == 0.00 {
                print("error!!!")
                error()
            }else{
                let view = segue.destination as! ViewController
                view.receivedNumber = sendNumber
            }
        }
    }
    
    func error(){
        
    }
    
    func convertToDouble(num:String){
        let convertNum = num
        if let doubleNum = Double(convertNum){
            self.sendNumber = doubleNum
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
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
