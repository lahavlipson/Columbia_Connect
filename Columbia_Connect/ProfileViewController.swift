//
//  ProfileViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/5/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var profilePictureView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var segmentedControl: BetterSegmentedControl!

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet weak var tableDistFromTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableDistFromTopConstraint: NSLayoutConstraint!
    
    let maxHeaderHeight: CGFloat = 0;
    var minHeaderHeight: CGFloat = 44 - 370;
    
    var previousScrollOffset: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableDistFromTopConstraint.constant = self.maxHeaderHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minHeaderHeight = -1*(self.mainScrollView.frame.height + self.profilePictureView.frame.height/2) + 20
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        segmentedControl.titles = ["Profile","Classes"]
        segmentedControl.backgroundColor = UIColor(white: 0.85, alpha: 1)
        segmentedControl.indicatorViewBackgroundColor = UIColor.white
        segmentedControl.cornerRadius = segmentedControl.frame.height/2
        segmentedControl.titleColor = UIColor(white: 0.44, alpha: 1)
        segmentedControl.selectedTitleColor = UIColor(white: 0.29, alpha: 1)
        segmentedControl.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        segmentedControl.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)!
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
     
        mainScrollView.delegate = self
        mainScrollView.contentSize = CGSize(width: self.view.frame.width*3, height: self.segmentedControl.frame.height)
        
        pageControl.pageIndicatorTintColor = UIColor(hex: 0xA7B6C6)
        
        let v = ProfileFirstPage.instanceFromNib()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: mainScrollView.frame.height)
        mainScrollView.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        let c1 = NSLayoutConstraint(item: v, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: mainScrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: v, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: mainScrollView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        let c3 = NSLayoutConstraint(item: v, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: mainScrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let c4 = NSLayoutConstraint(item: v, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mainScrollView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        self.view.addConstraints([c1,c2,c3,c4])
        
        let w = UIView()
        w.backgroundColor = .blue
        w.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: mainScrollView.frame.height)
        mainScrollView.addSubview(w)
        
        profilePictureView.layer.cornerRadius = profilePictureView.frame.height/2
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Turning lights on.")
        }
        else {
            print("Turning lights off.")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isPagingEnabled == true {
            if scrollView.contentOffset.x == 0{
                pageControl.currentPage = 0
            } else if scrollView.contentOffset.x == self.view.frame.width{
                pageControl.currentPage = 1
            } else if scrollView.contentOffset.x == self.view.frame.width*2{
                pageControl.currentPage = 2
            }
        }
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

        
        var newHeight = self.tableDistFromTopConstraint.constant
        if isScrollingDown {
            newHeight = max(self.minHeaderHeight, self.tableDistFromTopConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp && scrollView.contentOffset.y <= 0 {
            newHeight = min(self.maxHeaderHeight, self.tableDistFromTopConstraint.constant + abs(scrollDiff))
        }
        
        if newHeight != self.tableDistFromTopConstraint.constant {
            self.tableDistFromTopConstraint.constant = newHeight
            self.setScrollPosition(position: self.previousScrollOffset)
        }
        
        self.previousScrollOffset = scrollView.contentOffset.y
    }
    
    func setScrollPosition(position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
}

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}
