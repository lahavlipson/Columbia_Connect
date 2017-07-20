//
//  ChooseCoursesViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/17/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class ChooseCoursesViewController: UIViewController {
    
    var userProfile = Profile()

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toProfilePicSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.userProfile.writeData()
        let destinationVC = segue.destination as! ProfilePictureViewController
        destinationVC.userProfile = self.userProfile
    }
 

}
