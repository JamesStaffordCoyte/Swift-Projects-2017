//
//  ViewController.swift
//  ScrollView
//
//  Created by James Stafford on 2017-06-09.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        var contentWidth: CGFloat = 0.0
        
        super.viewDidLoad()
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x)")
            let imageView = UIImageView(image: image)
            images.append(imageView)
           
            let size = CGSize(width: 150, height: 150)
            let point = CGPoint(x: (scrollView.bounds.midX + scrollView.bounds.size.width * CGFloat(x)) - (size.width / 2), y: (scrollView.bounds.size.height / 2) - (size.height / 2))
            scrollView.addSubview(imageView)
            
            contentWidth = point.x + (size.width * 2)
            
            imageView.frame = CGRect(origin: point, size: size)
            
        }
        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }
    
    @IBAction func detectSwipe(_ sender: UISwipeGestureRecognizer) {
        if (currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left) {
            moveScrollView(direction: 1)
            
        }
        
        if (currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScrollView(direction: -1)
        }
    }
    func moveScrollView(direction: Int){
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        // Create a animation to increase the actual icon on screen
        UIView.animate(withDuration: 0.4){
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            // Revert icon size of the non-active pages
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    
}

