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
        super.viewDidLoad()

        dateChooser.minimumDate = Date(timeIntervalSince1970: TimeInterval(-2208970800000))
        dateChooser.maximumDate = Date()
        dateChooser.setDate(Date.init(timeIntervalSince1970: 946702800000), animated: false)
        dateChooser.addTarget(self, action: #selector(self.handleDatePicker), for: UIControlEvents.valueChanged)

        
    }
    
    func handleDatePicker(){
        userProfile.birthday = dateChooser.date
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
