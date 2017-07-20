//
//  StudentTypeViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/3/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//





import UIKit

class StudentTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var typePickerView: UIPickerView!
    
    var userProfile = Profile()
    
    var choice = 0
    
    var school = School.seas

    let typeArray = ["SEAS (Engineering)", "Columbia College", "Barnard College", "General Studies", "Columbia Business School", "Columbia Law School", "International & Public Affairs", "Columbia Journalism School", "Architecture, Planning & Preservation", "School of the Arts", "Graduate School of Arts & Sciences", "College of Physicians and Surgeons", "College of Dental Medicine", "Jewish Theological Seminary", "Teachers College", "School of Nursing", "Professional Studies", "Public Health", "School of Social Work", "Union Theological Seminary"]
    
    var graduate = Array(repeating: true, count: 20)
    
    
    @IBOutlet weak var graduateSwitch: BetterSegmentedControl!
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true) { 
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if graduate[choice] {
            performSegue(withIdentifier: "toCourseChooserSegue", sender: self)
        } else {
           performSegue(withIdentifier: "toGradClassSegue", sender: self)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePickerView.dataSource = self
        typePickerView.delegate = self
        
        typePickerView.selectRow(choice, inComponent: 0, animated: false)
        
        graduateSwitch.titles = ["Undergrad","Graduate"]
        graduateSwitch.backgroundColor = UIColor.clear
        graduateSwitch.indicatorViewBackgroundColor = UIColor(white: 1, alpha: 0.75)
        graduateSwitch.indicatorViewBorderWidth = 4
        graduateSwitch.indicatorViewBorderColor = UIColor.clear.cgColor
        graduateSwitch.cornerRadius = graduateSwitch.frame.height/2
        graduateSwitch.titleColor = UIColor(white: 0.75, alpha: 1)
        graduateSwitch.selectedTitleColor = UIColor(white: 75/255, alpha: 1)
        graduateSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)!
        graduateSwitch.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)!
        graduateSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        graduateSwitch.layer.borderWidth = 1
        graduateSwitch.layer.borderColor = UIColor(hex: 0x979797).cgColor

        graduate[0] = false
        graduate[1] = false
        graduate[2] = false
        graduate[3] = false
        graduate[13] = false
        
    }
    
    // MARK: - Graduate Switch
    
    func switchValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Undergrad")
        }
        else {
            print("Graduate")
        }
        graduate[typePickerView.selectedRow(inComponent: 0)] = sender.index == 1
    }
    
    func graduateSwitch(shouldBeVisible: Bool){
        if shouldBeVisible && self.graduateSwitch.isUserInteractionEnabled {
            graduateSwitch.setIndex(UInt(graduate[self.choice]), animated: true)
        } else if shouldBeVisible && !self.graduateSwitch.isUserInteractionEnabled {
            graduateSwitch.setIndex(UInt(graduate[self.choice]), animated: false)
            UIView.animate(withDuration: 0.2, animations: {
                self.graduateSwitch.alpha = 1
            }, completion: { (true) in
                self.graduateSwitch.isUserInteractionEnabled = true
            })
        } else if !shouldBeVisible && self.graduateSwitch.isUserInteractionEnabled {
            self.graduateSwitch.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2, animations: {
                self.graduateSwitch.alpha = 0
            })
        }
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choice = row
        if choice == 0 || choice == 13 {
            graduateSwitch(shouldBeVisible: true)
        } else {
            graduateSwitch(shouldBeVisible: false)
        }
        switch choice {
        case 0:
            school = .seas
        case 1:
            school = .columbiaCollege
        case 2:
            school = .barnard
        case 3:
            school = .generalStudies
        case 4:
            school = .business
        case 5:
            school = .law
        case 6:
            school = .sipa
        case 7:
            school = .journalism
        case 8:
            school = .gsapp
        case 9:
            school = .schoolOfArts
        case 10:
            school = .gsas
        case 11:
            school = .colOfPhysAndSurg
        case 12:
            school = .dentalMed
        case 13:
            school = .jewishTS
        case 14:
            school = .teachersCollege
        case 15:
            school = .nursing
        case 16:
            school = .profStudies
        case 17:
            school = .pubHealth
        case 18:
            school = .socialWork
        case 19:
            school = .uts
        default: break
        }
        self.userProfile.school = self.school
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        let yourAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light",size: 20.0)!]
        
        let attributedString = NSMutableAttributedString(string: typeArray[row], attributes: yourAttributes)
        label.attributedText = attributedString
        label.textAlignment = .center
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.userProfile.graduatingClass = nil
        print(self.userProfile.uni)
        self.userProfile.writeData()
        if let destinationVC = segue.destination as? GradClassViewController {
            destinationVC.userProfile = self.userProfile
        } else {
            let destinationVC = segue.destination as! ChooseCoursesViewController
            destinationVC.userProfile = self.userProfile
        }
    }
 

}

// MARK: - Extensions and More

extension UInt {
    init(_ bool:Bool) {
        self = bool ? 1 : 0
    }
}

struct Course {
    var id = ""
    var professor = ""
    var time = NSDateInterval()
    var description = ""
}

enum School {
    case seas, columbiaCollege, barnard, generalStudies, gsapp, schoolOfArts, gsas, business, colOfPhysAndSurg, law, uts
    case dentalMed, sipa, journalism, profStudies, pubHealth, socialWork, nursing, teachersCollege, jewishTS, other, none
}

//GSAS (logo)
//barnard
//business
//colOfPhysAndSurg
//columbiaCollege
//SEAS
//GS
//jts



