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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        
        
        let circleWidth:CGFloat = 150
        
        self.backgroundColor = UIColor(hex: 0xE2E9F1)
        
        let shadowPath = UIBezierPath(arcCenter: CGPoint(x: circleWidth/2+15, y: circleWidth/2+15), radius: circleWidth/2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)

        let shadowView = UIView()
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowPath = shadowPath.cgPath
        self.addSubview(shadowView)
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "lahav")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = circleWidth/2
        print(profileImageView.frame.width/2)
        profileImageView.layer.masksToBounds = true
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
        
        let classLabel = UILabel()
        classLabel.numberOfLines = 2
        classLabel.textAlignment = .center
        classLabel.text = "Class of \n2019"
        classLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(classLabel)
        
        // CONSTRAINTS
        
        let profileImageViewC1 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: circleWidth)
        let profileImageViewC2 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        let profileImageViewC3 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 15)
        let profileImageViewC4 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 15)
        self.addConstraints([profileImageViewC1,profileImageViewC2,profileImageViewC3,profileImageViewC4])
        
        let studyingLabelC1 = NSLayoutConstraint(item: studyingLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let studyingLabelC2 = NSLayoutConstraint(item: studyingLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 15)
        self.addConstraints([studyingLabelC1,studyingLabelC2])
        
        let nameLabelC1 = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 20)
        let nameLabelC2 = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -10)
        let nameLabelC3 = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: schoolIcon, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        self.addConstraints([nameLabelC1,nameLabelC2,nameLabelC3])
        
        let schoolIconC1 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        let schoolIconC2 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: schoolIcon, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let schoolIconC3 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 10)
        let schoolIconC4 = NSLayoutConstraint(item: schoolIcon, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: nameLabel, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        self.addConstraints([schoolIconC1,schoolIconC2,schoolIconC3,schoolIconC4])
        
        let classLabelC1 = NSLayoutConstraint(item: classLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -10)
        let classLabelC2 = NSLayoutConstraint(item: classLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let classLabelC3 = NSLayoutConstraint(item: classLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: schoolIcon, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10)
        let classLabelC4 = NSLayoutConstraint(item: classLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: schoolIcon, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 10)
        self.addConstraints([classLabelC1,classLabelC2,classLabelC3,classLabelC4])
        
        let mutualFriendsC1 = NSLayoutConstraint(item: mutualFriends, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let mutualFriendsC2 = NSLayoutConstraint(item: mutualFriends, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: studyingLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 30)
        self.addConstraints([mutualFriendsC1,mutualFriendsC2])
        
    }
    
    class func instanceFromNib() -> RecommendUserView {
        let v = UINib(nibName: "RecommendUserView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RecommendUserView
        v.frame.origin = CGPoint(x: 0, y: 0)
        
        return v
    }
    
}
