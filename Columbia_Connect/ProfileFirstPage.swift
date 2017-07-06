//
//  ProfileFirstPage.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/5/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import Foundation
import UIKit

class ProfileFirstPage: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup(){
        //nameLabel.addTextSpacing(val: 4)
    }
    
    class func instanceFromNib() -> ProfileFirstPage {
        let v = UINib(nibName: "ProfileFirstPage", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ProfileFirstPage
        v.frame.origin = CGPoint(x: 0, y: 0)
        
        return v
    }
    
}
