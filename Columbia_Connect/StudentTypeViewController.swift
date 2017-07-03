//
//  StudentTypeViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/3/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//





import UIKit

class StudentTypeViewController: UIViewController, PickerViewDelegate, PickerViewDataSource {
    
    @IBOutlet weak var studentTypePicker: PickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        studentTypePicker.delegate = self
        studentTypePicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        let choices = ["2017","2018","2019","2020","Masters Student","PHD Student"]
        return choices[index]
    }
    
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 40
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
