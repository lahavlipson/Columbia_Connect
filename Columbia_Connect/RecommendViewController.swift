//
//  RecommendViewController.swift
//  Columbia_Connect
//
//  Created by Lahav Lipson on 7/5/17.
//  Copyright © 2017 Lahav Lipson. All rights reserved.
//

import UIKit
import iCarousel

class RecommendViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var carousel: iCarousel!
    
    var startPanLocation: CGPoint?
    var currentPanLocation: CGPoint?
    var startCardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Started")
        
        carousel.isPagingEnabled = true
        carousel.type = .coverFlow
        carousel.dataSource = self
        carousel.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 15
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame.size = CGSize(width: 250, height: 250)
        view.backgroundColor = UIColor.red
        let panGestureRecognizer = MyPanRecognizer(target: self, action:#selector(self.handlePan(panGesture:)))
        panGestureRecognizer.onsetView = view
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
        return view
    }
    
    func handlePan(panGesture: MyPanRecognizer) {
        let v = panGesture.onsetView!
        let panVelocity = panGesture.velocity(in: carousel)
        let currentIndex = carousel.index(ofItemView: v)
        if currentIndex == carousel.currentItemIndex {
            
            if panGesture.state == UIGestureRecognizerState.began {
                startPanLocation = panGesture.location(in: self.carousel)
                startCardHeight = v.frame.origin.y
            } else if panGesture.state == UIGestureRecognizerState.changed && startCardHeight != nil && startPanLocation != nil {
                currentPanLocation = panGesture.location(in: self.carousel)
                let yPanDiff = (currentPanLocation?.y)! - (startPanLocation?.y)!
                v.frame.origin.y = startCardHeight! + yPanDiff
                if v.frame.origin.y > 50{
                    performSegue(withIdentifier: "toProfile", sender: nil)
                    UIView.animate(withDuration: 0.1, animations: { 
                        v.frame.origin.y = self.startCardHeight!
                    })
                }
            } else if panGesture.state == .ended && startCardHeight != nil {
                print("velocity: \(panVelocity.y)")
                print("origin-y: \(v.frame.origin.y)")
                if panVelocity.y < -500 || v.frame.origin.y < -120{
                    UIView.animate(withDuration: 0.4, animations: {
                        if panVelocity.y < -1600 {
                            v.frame.origin.y = v.frame.origin.y + panVelocity.y*0.4
                        } else {
                            v.frame.origin.y = v.frame.origin.y - 800
                        }
                    }, completion: { (true) in
                        self.carousel.removeItem(at: currentIndex, animated: true)
                    })
                   
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        v.frame.origin.y = self.startCardHeight!
                    }, completion: nil)
                }
                startPanLocation = nil
                startCardHeight = nil
            }
        }
    }
    

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let recognizer = gestureRecognizer as! MyPanRecognizer
        let translation = recognizer.translation(in: recognizer.onsetView)
        return fabs(translation.y) > fabs(translation.x)
    }
    
    func carouselDidEndDecelerating(_ carousel: iCarousel) {
        print("Stopped accelerating!")
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

class MyPanRecognizer: UIPanGestureRecognizer {
    var onsetView: UIView?
}


