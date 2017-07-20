//
//  VerifyViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/13/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import Firebase

class VerifyViewController: UIViewController {
    
    var userProfile = Profile()
    
    var timer = Timer()
    
    @IBOutlet weak var verifiedLabel: UILabel!

    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "verifiedSegue", sender: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.isEnabled = false
        
        print("Uni: \(self.userProfile.uni)")
        print("FacebookID: \(self.userProfile.facebookID)")
        
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.userProfile.name
        changeRequest?.commitChanges { (error) in
            if error != nil {
                print("Error setting display name")
            } else {
                print("Successfully set display name to: \(self.userProfile.name)")
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    if error != nil {
                        print("Error sending verification email")
                    } else {
                        print("Successfully sent verification email")
                    }
                }
            }
        }
        
    }
    
    func update(){
        let enteredEmail = self.userProfile.uni + "@columbia.edu"
        let password = self.userProfile.facebookID
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Auth.auth().signIn(withEmail: enteredEmail, password: password) { (user, error) in
                if error != nil {
                    print("Sign In User Error: \(error!)")
                } else {
                    if (Auth.auth().currentUser?.isEmailVerified)! {
                        self.userProfile.verified = true
                        self.userProfile.writeData()
                        self.continueButton.isEnabled = true
                        self.verifiedLabel.text = "Verified"
                        self.verifiedLabel.textColor = UIColor(hex: 0x31FF54)
                        self.timer.invalidate()
                    }
                }
            }
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StudyingViewController
        destinationVC.userProfile = self.userProfile
    }
 

}
