//
//  StudyingViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/19/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import GrowingTextView

class StudyingViewController: UIViewController, UITextViewDelegate {

    var userProfile = Profile()
    
    @IBOutlet weak var textView: GrowingTextView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSchoolSegue", sender: nil)
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.textAlignment = .center
        textView.font = UIFont(name: "HelveticaNeue-Light",size: 26.0)!
        textView.textColor = UIColor.white
        textView.placeHolderColor = UIColor(white: 1, alpha: 0.6)
        textView.delegate = self
        textView.returnKeyType = .done
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("Done editing!")
        userProfile.studying = textView.text
        nextButton.isEnabled = textView.text != ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StudentTypeViewController
        destinationVC.userProfile = self.userProfile
    }
 

}
