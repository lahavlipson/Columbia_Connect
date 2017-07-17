//
//  ProfilePictureViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/17/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class ProfilePictureViewController: UIViewController {
    
    var userProfile = Profile()

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func photoButtonPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // photoButton.setImage(UIImage(named: "camera"), for: .normal)
        photoButton.setBackgroundImage(UIImage(named: "camera"), for: .normal)
        photoButton.layer.cornerRadius = photoButton.frame.height/2
        photoButton.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

}
