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
    
    @IBAction func fbLoginButtonPressed(_ sender: Any) {
        //performSegue(withIdentifier: "fromFBConnect", sender: nil)
        loginButtonClicked()
        print()
    }
    
    @IBOutlet weak var fbLoginButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.fbLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
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
                print(accessToken.userId)
                print(AccessToken.current?.userId)
                
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
                            //print(responseDictionary)
                            print(responseDictionary)
                            let userID = responseDictionary["id"] as! NSString
                            var facebookProfileUrl = URL(string: "https://graph.facebook.com/1550731278316708/picture?type=large")
                            let data = try? Data(contentsOf: facebookProfileUrl!)
                            let img = UIImage(data: data!)
                            print(facebookProfileUrl)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
