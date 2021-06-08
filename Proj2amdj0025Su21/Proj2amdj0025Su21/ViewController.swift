//
//  ViewController.swift
//  programming_assignment_2_a
//
//  Created by Michael Johnson on 6/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image_outlet: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        image_outlet.image = UIImage(named: "sec_logo")!
    }

    @IBAction func auburn_button_action(_ sender: Any) {
        image_outlet.image = UIImage(named: "auburn_logo")!
    }
    @IBAction func sec_button_action(_ sender: Any) {
        image_outlet.image = UIImage(named: "sec_logo")!
    }
    @IBAction func alabama_button_action(_ sender: Any) {
        image_outlet.image = UIImage(named: "alabama_logo")!
    }
}

