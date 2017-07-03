//
//  UniLoginViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/3/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class UniLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(doesUniExist(uni: "hl2891"))
        
        
        
        
        
    }
    
    func doesUniExist(uni: String) -> Bool?{
        if let url = URL(string: "https://directory.columbia.edu/people/uni?code=" + uni) {
            do {
                let contents = try String(contentsOf: url)
                if contents.lowercased().range(of:"title:") != nil {
                    return true
                } else {
                    return false
                }
            } catch {
                return nil
            }
        } else {
            return nil
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
