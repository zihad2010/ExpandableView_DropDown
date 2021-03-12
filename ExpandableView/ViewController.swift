//
//  ViewController.swift
//  ExpandableView
//
//  Created by Asraful Alam on 13/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailsExpandableView: ExpandableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsExpandableView.data = ["Long coat collar","structured fabric"," Designed for a relaxed fit","oft structured fabric"]
    }


}

