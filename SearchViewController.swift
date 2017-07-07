//
//  SearchViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/6/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UIToolbarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var profilePicPath = UIBezierPath(svgPath: "M83.9372351,92.7269901 C96.028676,83.2253729 103.795088,68.4684299 103.795088,51.897544 C103.795088,23.2353219 80.5597662,0 51.897544,0 C23.2353219,0 0,23.2353219 0,51.897544 C0,80.5597662 23.2353219,103.795088 51.897544,103.795088 C57.1941788,103.795088 62.3054894,103.001621 67.119094,101.527068 C66.5565735,100.313644 66.2426268,98.9615201 66.2426268,97.5360704 C66.2426268,92.2893653 70.4959217,88.0360704 75.7426268,88.0360704 C79.234525,88.0360704 82.2863971,89.9200463 83.9372351,92.7269901 Z")
    
    var mainCardPath = UIBezierPath(svgPath: "M62.8822483,67 L279,67 C281.761424,67 284,64.7614237 284,62 L284,10 C284,7.23857625 281.761424,5 279,5 L279,5 L61.458244,5 C69.7624511,12.3294445 75,23.0530747 75,35 C75,46.2725508 70.3370561,56.4560126 62.8347955,63.7267582 C62.9432575,64.3012371 63,64.8939921 63,65.5 C63,66.0104015 62.9597491,66.5114018 62.8822483,67 Z")

    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.searchBarStyle = .minimal
        
        self.navigationItem.titleView = searchBar
        
        toolBar.delegate = self
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        

    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        //vc.fmRecordId = item["inContainerRecordId"]! //this is the data which will be passed to the new vc
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let userCell = UITableViewCell()
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: userCell.frame.height)
        
        
        let profileImageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 80, height: 80))
        profileImageView.image = UIImage(named: "lahav")
        profileImageView.alpha = 1
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
       
        view.addSubview(profileImageView)
        
        let mainCardView = UIView(frame: CGRect(x: 90, y: 15.5, width: self.view.frame.width-90-30, height: 70))
            mainCardView.alpha = 1
        mainCardView.backgroundColor = UIColor(hex: 0xEFEFEF)
        //mainCardView.layer.cornerRadius = 15
        let path = UIBezierPath()
        let cornerRadius: CGFloat = 15
        let frame = mainCardView.frame
        path.move(to: CGPoint(x: frame.width-cornerRadius, y: 0))
        path.addLine(to: CGPoint.zero)
        let center = CGPoint(x: -30, y: frame.height/2)
        let radius = sqrt(pow(center.x, 2) + pow(center.y, 2))
        let theta = asin((frame.height)/(2*radius))
        path.addArc(withCenter: center, radius: radius, startAngle: -theta, endAngle: theta, clockwise: true)
        path.addLine(to: CGPoint(x: frame.width-cornerRadius, y: frame.height))
        path.addArc(withCenter: CGPoint(x: frame.width-cornerRadius, y: frame.height-cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi/2, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: frame.width, y: cornerRadius))
         path.addArc(withCenter: CGPoint(x: frame.width-cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: -CGFloat.pi/2, clockwise: false)
        path.close()
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mainCardView.layer.mask = mask
        mask.strokeColor = UIColor.black.cgColor
        mask.lineWidth = 1.0
            
        let nameLabel = UILabel(frame: CGRect(x: 30, y: 0, width: frame.width-40, height: 40))
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        nameLabel.text = "Lahav Lipson"
        mainCardView.addSubview(nameLabel)
        
            
            
            
        view.addSubview(mainCardView)
        
        
        

        
//        let profileImageViewC1 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 80)
//        let profileImageViewC2 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: profileImageView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
//        let profileImageViewC3 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 20)
//        let profileImageViewC4 = NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 20)
//        view.addConstraints([profileImageViewC1,profileImageViewC2,profileImageViewC3,profileImageViewC4])
        
        
        
        
        
        
        
        
        userCell.backgroundView = view
        return userCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dtr(d: CGFloat) -> CGFloat {
        return CGFloat(Double(d)*Double.pi/180)
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
