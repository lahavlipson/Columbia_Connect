//
//  GradClassViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/16/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import GMStepper

class GradClassViewController: UIViewController {

    @IBOutlet weak var stepper: GMStepper!
    
    var userProfile = Profile()
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "fromGradClassSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfile.graduatingClass = 2019

        stepper.value = Double(userProfile.graduatingClass!)
        stepper.minimumValue = 2017
        stepper.maximumValue = 2022
        stepper.buttonsBackgroundColor = UIColor(colorLiteralRed: 178/255, green: 204/255, blue: 233/255, alpha: 0.85)
        stepper.labelBackgroundColor = UIColor(colorLiteralRed: 178/255, green: 204/255, blue: 233/255, alpha: 0.3)
        stepper.labelFont = UIFont(name: "HelveticaNeue-Medium",size: 26.0)!
        stepper.addTarget(self, action: #selector(self.stepperValueChanged), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    func stepperValueChanged(){
        userProfile.graduatingClass = Int(stepper.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChooseCoursesViewController
        destinationVC.userProfile = self.userProfile
    }
 

}
