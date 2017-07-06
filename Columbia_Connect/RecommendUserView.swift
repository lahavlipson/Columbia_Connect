//
//  ProfileFirstPage.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/5/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import Foundation
import UIKit

class RecommendUserView: UIView {
    
    var profilePicPath = UIBezierPath(svgPath: "M83.9372351,92.7269901 C96.028676,83.2253729 103.795088,68.4684299 103.795088,51.897544 C103.795088,23.2353219 80.5597662,0 51.897544,0 C23.2353219,0 0,23.2353219 0,51.897544 C0,80.5597662 23.2353219,103.795088 51.897544,103.795088 C57.1941788,103.795088 62.3054894,103.001621 67.119094,101.527068 C66.5565735,100.313644 66.2426268,98.9615201 66.2426268,97.5360704 C66.2426268,92.2893653 70.4959217,88.0360704 75.7426268,88.0360704 C79.234525,88.0360704 82.2863971,89.9200463 83.9372351,92.7269901 Z")
    
    let classCirclePath = UIBezierPath(arcCenter: CGPoint(x: 134, y: 167), radius: 11, startAngle: 0, endAngle: 360, clockwise: true)
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        
        let path = profilePicPath
        let scale = CGFloat(1.5)
        path.apply(CGAffineTransform(scaleX: scale, y: scale))
        profilePicPath = path
        
        
        addShadows()
        
        self.backgroundColor = UIColor(hex: 0xE2E9F1)
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "lahav")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        let maskForYourPath = CAShapeLayer()
        maskForYourPath.path = profilePicPath.cgPath
        profileImageView.layer.mask = maskForYourPath
        
        let ageCircle = UILabel(frame: CGRect(x: 123, y: 155, width: 22, height: 22))
        ageCircle.layer.cornerRadius = ageCircle.frame.width/2
        ageCircle.clipsToBounds = true
        ageCircle.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        ageCircle.textAlignment = .center
        ageCircle.backgroundColor = UIColor(hex: 0x7ED321)
        ageCircle.text = "'20 "
        self.addSubview(ageCircle)
        self.addSubview(profileImageView)

        let nameLabel = UILabel()
        nameLabel.numberOfLines = 3
        nameLabel.textAlignment = .left
        //nameLabel.backgroundColor = .green
        nameLabel.text = "Felix Fernandez Penny, 20"
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        
        let studyingLabel = UILabel()
        studyingLabel.numberOfLines = 3
        studyingLabel.textAlignment = .center
        //studyingLabel.backgroundColor = .green
        studyingLabel.text = "Studying\n Computer Science"
        studyingLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        studyingLabel.addTextSpacing(val: 3)
        studyingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(studyingLabel)
        
        let schoolIcon = UIImageView(image: UIImage(named: "SEAS logo"))
        schoolIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(schoolIcon)
        
        let mutualFriends = UILabel()
        mutualFriends.numberOfLines = 1
        mutualFriends.textAlignment = .center
        mutualFriends.text = "43 Mutual Friends"
        mutualFriends.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        mutualFriends.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mutualFriends)
        
        
        // CONSTRAINTS
        
        let profileImageViewC1 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 170)
        let profileImageViewC2 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        let profileImageViewC3 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 20)
        let profileImageViewC4 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 20)
        self.addConstraints([profileImageViewC1,profileImageViewC2,profileImageViewC3,profileImageViewC4])
        
        let studyingLabelC1 = NSLayoutConstraint(item: studyingLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let studyingLabelC2 = NSLayoutConstraint(item: studyingLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        self.addConstraints([studyingLabelC1,studyingLabelC2])
        
        let schoolIconC1 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        let schoolIconC2 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: schoolIcon, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let schoolIconC3 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 10)
        let schoolIconC4 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        self.addConstraints([schoolIconC1,schoolIconC2,schoolIconC3,schoolIconC4])
        
        let nameLabelC1 = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let nameLabelC2 = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -10)
        let nameLabelC3 = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: schoolIcon, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        self.addConstraints([nameLabelC1,nameLabelC2,nameLabelC3])
        
        let mutualFriendsC1 = NSLayoutConstraint(item: mutualFriends, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let mutualFriendsC2 = NSLayoutConstraint(item: mutualFriends, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: studyingLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 30)
        self.addConstraints([mutualFriendsC1,mutualFriendsC2])
        
    }
    
    func addShadows(){
        let translatedPath = profilePicPath.copy(with: nil) as! UIBezierPath
        let translation = CGSize(width: 15, height: 15)
        translatedPath.apply(CGAffineTransform(translationX: translation.width, y: translation.height))
        
        
        let profilePicShadow = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        profilePicShadow.layer.shadowColor = UIColor.black.cgColor
        profilePicShadow.layer.shadowOpacity = 1
        profilePicShadow.layer.shadowOffset = CGSize(width: 7, height: 7)
        profilePicShadow.layer.shadowRadius = 5
        profilePicShadow.layer.shadowPath = translatedPath.cgPath
        self.addSubview(profilePicShadow)
        
        
        let classCircleShadow = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        classCircleShadow.layer.shadowColor = UIColor.black.cgColor
        classCircleShadow.layer.shadowOpacity = 1
        classCircleShadow.layer.shadowOffset = CGSize.zero
        classCircleShadow.layer.shadowRadius = 10
        classCircleShadow.layer.shadowPath = classCirclePath.cgPath
        self.addSubview(classCircleShadow)
    }
    
    class func instanceFromNib() -> RecommendUserView {
        let v = UINib(nibName: "RecommendUserView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RecommendUserView
        v.frame.origin = CGPoint(x: 0, y: 0)
        
        return v
    }
    
}
