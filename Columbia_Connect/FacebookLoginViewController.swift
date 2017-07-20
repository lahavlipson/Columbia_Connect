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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func fbLoginButtonPressed(_ sender: Any) {
        
        //loginButtonClicked()
        self.userProfile.facebookID = "password"
        checkAccountStatus()
    }
    
    @IBOutlet weak var fbLoginButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
    
    func loginButtonClicked() {
        messageLabel.text = ""
        print("#-2")
        let loginManager = LoginManager()
        print("#-1")
        loginManager.logOut()
        print("#0")
        loginManager.logIn([.publicProfile, .userFriends], viewController: self) { loginResult in
            print("#1")
            self.activityIndicator.isHidden = false
            switch loginResult {
            case .failed(let error):
                self.messageLabel.text = "There is an error: \(error)"
                print(error)
                self.activityIndicator.isHidden = true
            case .cancelled:
                print("User cancelled login.")
                self.activityIndicator.isHidden = true
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("#2")
                print("Facebook logged in!")
                //print(accessToken.userId)
                print(AccessToken.current?.userId)
                
                let params = ["fields" : "name, id, gender"]
                let graphRequest = GraphRequest(graphPath: "me", parameters: params)
                graphRequest.start {
                    (urlResponse, requestResult) in
                    switch requestResult {
                    case .failed(let error):
                        print("error in graph request:", error)
                        self.activityIndicator.isHidden = true
                        break
                    case .success(let graphResponse):
                        if let responseDictionary = graphResponse.dictionaryValue {
                            print(responseDictionary)
                            self.userProfile.gender = responseDictionary["gender"] as? NSString as String?
                            self.userProfile.name = responseDictionary["name"] as! NSString as String
                            let userID = (responseDictionary["id"] as! NSString) as String
                            self.userProfile.facebookID = userID
                            let facebookProfileUrl = URL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
                            print(facebookProfileUrl)
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
                                        self.activityIndicator.isHidden = true
                                    default:
                                        print("Sign In User Error: \(error!)")
                                        self.activityIndicator.isHidden = true
                                    }
                                }
                            } else {
                                print("User Succesfully signed in!")
                                self.activityIndicator.isHidden = true
                                self.performSegue(withIdentifier: "signedInSegue", sender: nil)
                            }
                        }
                        
                        
                    default:
                        print("Create User Error: \(error!)")
                        self.activityIndicator.isHidden = true
                    }
                }
            } else {
                print("Successfuly created user!")
                self.userProfile.writeData()
                //self.performSegue(withIdentifier: "toVerifySegue", sender: nil) WILL UNCOMMENT LATER
                self.performSegue(withIdentifier: "skipVerification", sender: nil)
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
        } else if let destinationVC = segue.destination as? StudentTypeViewController {
            destinationVC.userProfile = self.userProfile
        }
    }
    
    
}

