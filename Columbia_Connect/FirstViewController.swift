//
//  FirstViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/2/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import FacebookLogin

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

