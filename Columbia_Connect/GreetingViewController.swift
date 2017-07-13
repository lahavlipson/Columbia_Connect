//
//  GreetingViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/2/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var connectLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var uniTextField: UITextField!
        
    @IBAction func loginButtonPressed(_ sender: Any) {
        let enteredUni = uniTextField.text!
        if let uniIsValid = doesUniExist(uni: enteredUni){
            if enteredUni == ""{
                messageLabel.text = "Please enter your uni"
            } else if !uniIsValid {
                messageLabel.text = "The uni is invalid"
            } else {
               performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        } else {
            messageLabel.text = "An error occured when trying to connect"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //WILL REMOVE
        uniTextField.text = "lol2107"
        //WILL REMOVE
        
        messageLabel.text = ""
        
        connectLabel.addTextSpacing(val: 3)
        uniTextField.delegate = self
        //uniTextField.tag = 1
        uniTextField.backgroundColor = UIColor.clear
        uniTextField.borderStyle = UITextBorderStyle.none
        uniTextField.placeholderColor = UIColor(white: 1, alpha: 0.6)

        
        
        // Do any additional setup after loading the view.
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
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

extension UILabel {
    func addTextSpacing(val: CGFloat) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: val, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSForegroundColorAttributeName : newValue]
            
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}

extension UIView {
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func unbindFromKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc
    func keyboardWillChange(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        })
    }  
}
