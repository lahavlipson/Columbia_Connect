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

class FacebookLoginViewController: UIViewController {
    
    var userProfile = Profile()
    
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
        
    }
    
    // Once the button is clicked, show the login dialog
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .userFriends], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print("There as an error.")
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
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
                            let userID = (responseDictionary["id"] as! NSString) as String
                            self.userProfile.facebookID = userID
                            var facebookProfileUrl = URL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
                            let data = try? Data(contentsOf: facebookProfileUrl!)
                            self.userProfile.profilePic = UIImage(data: data!)
                            //print(facebookProfileUrl)
                            self.performSegue(withIdentifier: "fromFBConnect", sender: nil)
                        }
                    }
                }
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
        let destinationVC = segue.destination as! VerifyViewController
        destinationVC.userProfile = self.userProfile
     }
 
    
}

//enum StudentType {
//    case undergrad, graduate, masters, phd, Other
//}

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


