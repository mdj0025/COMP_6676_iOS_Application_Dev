//
//  DetailViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextView!
    var titleText: String?
    var detailText : String?
    public var masterViewController : UIViewController!
    var didClickSave = false
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = titleTextField {
                label.text = detailItem
                detailsTextField.text = detailText
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCell))
    }

    override func viewWillDisappear(_ animated: Bool) {
        let mvc = masterViewController as! MasterViewController
        mvc.titleText = titleTextField.text!
        mvc.detailText = detailsTextField.text!
        if (didClickSave)
        {
            mvc.didClickSave = true
            mvc.titleText = titleTextField.text ?? "default"
            mvc.detailText = detailsTextField.text ?? "noDetails"
        }
        didClickSave = false
    }
    
    @IBAction func titleFieldEditingChanged(_ sender: UITextField) {
        titleText = titleTextField.text!
    }
    
    @objc func saveCell()
    {
        didClickSave = true
        let navC = navigationController?.navigationController
        navC?.popViewController(animated: true)
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

