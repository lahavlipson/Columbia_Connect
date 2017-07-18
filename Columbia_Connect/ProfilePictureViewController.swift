//
//  ProfilePictureViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/17/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import RSKImageCropper

class ProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate {
    
    var userProfile = Profile()
    var imagePickerController: UIImagePickerController?

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toDateChooser", sender: nil)
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func photoButtonPressed(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        
        imagePickerController?.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "You need a profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Facebook Profile Picture", style: .default, handler: { (action:UIAlertAction) in
            if let pic = self.userProfile.profilePic {
                self.photoButton.setBackgroundImage(pic, for: .normal)
                self.nextButton.isEnabled = true
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePickerController?.sourceType = .camera
                self.present(self.imagePickerController!, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            self.imagePickerController?.sourceType = .photoLibrary
            self.present(self.imagePickerController!, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "camera")
        photoButton.setBackgroundImage(image, for: .normal)
        photoButton.layer.cornerRadius = photoButton.frame.height/2
        photoButton.layer.masksToBounds = true
        
        self.nextButton.isEnabled = false
    }
    
    // MARK: - Image Cropper
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        controller.dismiss(animated: true, completion: nil)
        if imagePickerController != nil && imagePickerController!.sourceType == .camera{
            imagePickerController?.dismiss(animated: true, completion: nil)
            imagePickerController = nil
        }
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        self.photoButton.setBackgroundImage(croppedImage, for: .normal)
        controller.dismiss(animated: true, completion: nil)
        if imagePickerController != nil {
            imagePickerController?.dismiss(animated: true, completion: nil)
            imagePickerController = nil
        }
        self.nextButton.isEnabled = true
    }
    
    // MARK: - Image Picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Gonna use this one!")
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            let imageCropVC = RSKImageCropViewController(image: editedImage, cropMode: .circle)
            imageCropVC.delegate = self
            picker.present(imageCropVC, animated: true, completion: nil)
            
            /// else if you could't find the edited image that means user select original image same is it without editing .
        } else if let orginalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            /// if user update it and already got it , just return it to 'self.imgView.image'.
            let imageCropVC = RSKImageCropViewController(image: orginalImage, cropMode: .circle)
            imageCropVC.delegate = self
            picker.present(imageCropVC, animated: true, completion: nil)
        } 
        else { print ("error") }
        
        
        
        //let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePickerController = nil
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BirthdayViewController
        destinationVC.userProfile = self.userProfile
    }
 

}
