//
//  StudentTypeViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/3/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//





import UIKit

class StudentTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var typePickerView: UIPickerView!
    
    var userProfile = Profile()
    
    var choice = 3
    
    let typeArray = ["Undergrad class of 2018", "Undergrad class of 2019", "Undergrad class of 2020",
                     "Undergrad class of 2021", "Masters Student", "PHD Student"]
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true) { 
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePickerView.dataSource = self
        typePickerView.delegate = self
        
        typePickerView.selectRow(choice, inComponent: 0, animated: false)

    }

     func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choice = row
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        let yourAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light",size: 20.0)!]
        
        let attributedString = NSMutableAttributedString(string: typeArray[row], attributes: yourAttributes)
        label.attributedText = attributedString
        label.textAlignment = .center
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
