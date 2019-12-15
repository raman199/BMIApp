//
//  BmiViewController.swift
//  BMIApp
//
//  Created by mac on 2019-12-11.
//  Copyright © 2019 Centennial College. All rights reserved.
// File name   BmiViewController.swift
//  Author's name   Ramandeep Kaur
//  Student ID : 301088232
//  Date 14 dec 2019

import UIKit
import Firebase

class BmiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    var db:Firestore?
    
    var dictionary = [[String:AnyObject]]()
    var indexDict = [String:AnyObject]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    retrieveData()
        // Do any additional setup after loading the view.
    }
    // function to retrieve data from firebase
    func retrieveData(){
        
        db = Firestore.firestore()
        db?.collection("bmi").getDocuments(completion: { (snap, err) in
            
            for i in snap!.documents{
                self.dictionary.append(i.data() as [String : AnyObject])
                
            }
            print("dict is",self.dictionary)
            self.table.reloadData()
            
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        return dictionary.count
    }
    
    // Row height of table cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let index = dictionary[indexPath.row]
        print("index",index)
        
        // assigning name of task to table cell
        if let x = cell.viewWithTag(1) as? UILabel{
            x.text = index["weight"] as? String
        }
        // assigning BMI of task to table cell
        if let y = cell.viewWithTag(2) as? UILabel{
            y.text = index["bmi"] as? String
        }
        
        return cell
        
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
