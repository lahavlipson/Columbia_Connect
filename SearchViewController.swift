//
//  SearchViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/6/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UIToolbarDelegate, UITableViewDelegate, UITableViewDataSource {

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
