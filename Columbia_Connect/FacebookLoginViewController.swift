//
//  FacebookLoginViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/13/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase

class FacebookLoginViewController: UIViewController {
    
    var userProfile = Profile()
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func fbLoginButtonPressed(_ sender: Any) {
        
        loginButtonClicked()
        print()
    }
    
    @IBOutlet weak var fbLoginButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
    }
    
    func loginButtonClicked() {
        messageLabel.text = ""
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn([.publicProfile, .userFriends], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                self.messageLabel.text = "There is an error: \(error)"
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Facebook logged in!")
                //print(accessToken.userId)
                //print(AccessToken.current?.userId)
                
                let params = ["fields" : "name, id, gender"]
                let graphRequest = GraphRequest(graphPath: "me", parameters: params)
                graphRequest.start {
                    (urlResponse, requestResult) in
                    switch requestResult {
                    case .failed(let error):
                        print("error in graph request:", error)
                        break
                    case .success(let graphResponse):
                        if let responseDictionary = graphResponse.dictionaryValue {
                            print(responseDictionary)
                            self.userProfile.gender = responseDictionary["gender"] as? NSString as String?
                            self.userProfile.name = responseDictionary["name"] as! NSString as String
                            let userID = (responseDictionary["id"] as! NSString) as String
                            self.userProfile.facebookID = userID
                            let facebookProfileUrl = URL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
                            let data = try? Data(contentsOf: facebookProfileUrl!)
                            self.userProfile.profilePic = UIImage(data: data!)
                            self.checkAccountStatus()
                            
                        }
                    }
                }
            }
        }
    }
    
    func checkAccountStatus(){
        let enteredEmail = self.userProfile.uni + "@columbia.edu"
        let password = self.userProfile.facebookID
        Auth.auth().createUser(withEmail: enteredEmail, password: password) { (user, error) in
            if (error != nil) {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        Auth.auth().signIn(withEmail: enteredEmail, password: password) { (user, error) in
                            if error != nil {
                                if let errCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errCode {
                                    case .wrongPassword:
                                        self.messageLabel.text = "The uni \(self.userProfile.uni) has already been tied to a different facebook account."
                                    default:
                                        print("Sign In User Error: \(error!)")
                                    }
                                }
                            } else {
                                print("User Succesfully signed in!")
                                self.performSegue(withIdentifier: "signedInSegue", sender: nil)
                            }
                        }
                        
                        
                    default:
                        print("Create User Error: \(error!)")
                    }
                }
            } else {
                print("Successfuly created user!")
                self.performSegue(withIdentifier: "toVerifySegue", sender: nil)
            }
        }
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VerifyViewController {
            destinationVC.userProfile = self.userProfile
        } else {
            let destinationVC = segue.destination as! StudentTypeViewController
            destinationVC.userProfile = self.userProfile
        }
    }
    
    
}


struct Course {
    var id = ""
    var professor = ""
    var time = NSDateInterval()
    var description = ""
}

enum School {
    case seas, columbiaCollege, barnard, generalStudies, gsapp, schoolOfArts, gsas, business, colOfPhysAndSurg
    case dentalMed, sipa, journalism, profStudies, pubHealth, socialWork, teachersCollege, jewishTS, other, none
}

//GSAS (logo)
//barnard
//business
//colOfPhysAndSurg
//columbiaCollege
//SEAS
//GS
//jts


