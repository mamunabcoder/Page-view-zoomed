//
//  ViewController.swift
//  PageViewZoomedDemo
//
//  Created by BJIT LTD on 3/15/19.
//  Copyright © 2019 BJIT LTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
    var pageImages : Array<String> = ["page1.png", "page2.png", "page3.png"]
    var currentIndex : Int = 0
    var pinchRecognizer : UIPinchGestureRecognizer?
    var lastScale : CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "pageViewControllerId") as? UIPageViewController
        pageViewController?.dataSource = self

        let startingViewController : PageContentViewController = viewControllerAtIndex(index: 0)!
        let viewControllers = [startingViewController]
        pageViewController?.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        
        addChild(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
        
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler))
        view.addGestureRecognizer(pinchRecognizer!)
        pinchRecognizer!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private extension ViewController {
    @objc func pinchHandler(recognizer : UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            lastScale = (pinchRecognizer?.scale)!
        }
        
        if (recognizer.state == .began) || (recognizer.state == .changed) {
            let currentScale = recognizer.view?.layer.value(forKeyPath: "transform.scale") as! CGFloat
            // Constants to adjust the max/min values of zoom
            let maxScale : CGFloat = 4.0;
            let minScale : CGFloat = 1.0;
            
            var newScale : CGFloat = 1 -  (lastScale - recognizer.scale)
            
            newScale = min(newScale, maxScale/currentScale)
            newScale = max(newScale, minScale/currentScale)
            pageViewController?.view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            lastScale = (pinchRecognizer?.scale)!
        }
    }

    func viewControllerAtIndex(index: Int) -> PageContentViewController?
    {
        if self.pageTitles.count == 0 || index >= self.pageTitles.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "pageContentViewControllerId") as! PageContentViewController
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.titleText = pageTitles[index]
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
}

extension ViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PageContentViewController,
            let index = viewController.pageIndex,
            index > 0 {
            return viewControllerAtIndex(index: index - 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PageContentViewController,
            let index = viewController.pageIndex,
            (index + 1) < pageImages.count {
            return viewControllerAtIndex(index: index + 1)
        }

        return nil
    }
}

extension ViewController : UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

