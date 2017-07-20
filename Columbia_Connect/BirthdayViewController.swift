//
//  BirthdayViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/18/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    var userProfile = Profile()
    
    @IBOutlet weak var dateChooser: UIDatePicker!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "finishedSetupSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd"
        let minDate = formatter.date(from: "1900/1/1")
        dateChooser.minimumDate = minDate
        dateChooser.maximumDate = Date()
        let setDate = formatter.date(from: "2000/1/1")
        dateChooser.setDate(setDate!, animated: false)
        dateChooser.addTarget(self, action: #selector(self.handleDatePicker), for: UIControlEvents.valueChanged)
        dateChooser.setValue(UIColor.white, forKeyPath: "textColor")
        
    }
    
    func handleDatePicker(){
        userProfile.birthday = dateChooser.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.userProfile.writeData()
    }
 

}
