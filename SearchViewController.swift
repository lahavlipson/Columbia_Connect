//
//  SearchViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/6/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UIToolbarDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var shouldLoadProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        searchBar.searchBarStyle = .minimal
        
        self.navigationItem.titleView = searchBar
        
        toolBar.delegate = self
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func handlePress(pressGesture: MyPanRecognizer) {
        let data = pressGesture.gestureData as! [String:Any]
        let shadowView1 = data["shadow1"] as! UIView
        let shadowView2 = data["shadow2"] as! UIView
        if pressGesture.state == .began {
            shouldLoadProfile = true
            shadowView1.alpha = 0
            shadowView2.alpha = 0
        }
        if pressGesture.state == .ended {
            shadowView1.alpha = 1
            shadowView2.alpha = 1
            if shouldLoadProfile {
                shouldLoadProfile = false
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shouldLoadProfile = false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uniToUse = ""//Will fill in later
        
        let view = UITableViewCell()
        view.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: view.frame.height)
        
        
        let profileImageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 80, height: 80))
        profileImageView.image = UIImage(named: "lahav")
        profileImageView.alpha = 1
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        let mainCardView = UIView(frame: CGRect(x: 90, y: 15.5, width: self.view.frame.width-90-30, height: 70))
        mainCardView.alpha = 1
        mainCardView.backgroundColor = UIColor(hex: 0xEFEFEF)
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
        
        var translation = CGAffineTransform(translationX: 90, y: 15.5);
        let cardShadowPath = path.cgPath.copy(using: &translation);        
        
        let cardShadowView = UIView()
        cardShadowView.layer.shadowColor = UIColor.black.cgColor
        cardShadowView.layer.shadowOpacity = 0.5
        cardShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardShadowView.layer.shadowRadius = 2
        cardShadowView.layer.shadowPath = cardShadowPath
        view.addSubview(cardShadowView)
        
        
        let picShadowPath = UIBezierPath(arcCenter: CGPoint(x: 60, y: 50), radius: 40, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true).cgPath
        let picShadowView = UIView()
        picShadowView.layer.shadowColor = UIColor.black.cgColor
        picShadowView.layer.shadowOpacity = 0.5
        picShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        picShadowView.layer.shadowRadius = 2
        picShadowView.layer.shadowPath = picShadowPath
        view.addSubview(picShadowView)
        
        
        view.addSubview(profileImageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 30, y: 0, width: frame.width-40, height: 40))
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        nameLabel.text = "Lahav Lipson"
        mainCardView.addSubview(nameLabel)
        
        view.addSubview(mainCardView)
        
        let pressRecognizer = MyPressRecognizer(target: self, action:#selector(self.handlePress(pressGesture:)))
        pressRecognizer.gestureData = ["uni":uniToUse, "shadow1":cardShadowView, "shadow2":picShadowView]
        pressRecognizer.minimumPressDuration = 0.0
        pressRecognizer.delegate = self
        view.addGestureRecognizer(pressRecognizer)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
