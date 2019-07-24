//
//  PageContentViewController.swift
//  PageViewZoomedDemo
//
//  Created by BJIT LTD on 3/15/19.
//  Copyright © 2019 BJIT LTD. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    open var pageIndex : Int!
    open var titleText : String?
    open var imageFile : String?

    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageTitleLabel.text = titleText
        pageImageView.image = UIImage(named: imageFile!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
