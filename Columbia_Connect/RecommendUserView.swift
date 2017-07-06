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
        self.backgroundColor = UIColor(hex: 0xE2E9F1)
    }
    
    
    
}
