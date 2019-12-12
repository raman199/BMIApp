//
//  ViewController.swift
//  BMIApp
//
//  Created by mac on 2019-12-11.
//  Copyright © 2019 Centennial College. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    var dict = [String:AnyObject]()
    
    var db:Firestore?
    
    private var bmiValue: Double = 0.0
    private var height1: Double = 0.0
    private var weight1: Double = 0.0
    private var result = ""


    @IBOutlet weak var bmi: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
    
        height1 = Double(height.text!) as! Double
        weight1 = Double(weight.text!) as! Double

        bmiValue = weight1/(height1*height1)
        
        if(bmiValue < 16 )
        {
            result = "Severe Thinness" ;
        }
        if(bmiValue >= 16 && bmiValue < 17 )
        {
            result = "Moderate Thinness" ;
        }
        if(bmiValue >= 17 && bmiValue < 18.5 )
        {
            result = "Mild Thinness" ;
        }
        if(bmiValue >= 18.8 && bmiValue < 25 )
        {
            result = "Normal" ;
        }
        if(bmiValue >= 25 && bmiValue < 30 )
        {
            result = "Over Weight" ;
        }
        if(bmiValue >= 30 && bmiValue < 35 )
        {
            result = "Obese Class1" ;
        }
        if(bmiValue >= 35 && bmiValue <= 40 )
        {
            result = "Obese Class2" ;
        }
        if(bmiValue > 40 )
        {
            result = "Obese Class3" ;
        }
        
        bmi.text = String(bmiValue)
        msg.text = result
        let Id = db?.collection("bmi").document().documentID
        
        let parameters = ["name":name.text!,"age":age.text!,"gender":gender.text!,"weight":weight.text!,"height":height.text!,"date": Date(),"bmi": bmiValue,"Id":Id!] as [String : Any]

        db?.collection("bmi").document(Id!).setData(parameters as [String : Any]){
            err in
            if let error = err{
                print(error.localizedDescription)
                
            }else{
                let alert = UIAlertController(title: "Message", message: "BMI added", preferredStyle: .alert)
                let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    //       self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }

}

