//
//  ItemViewController.swift
//  FinalProjectmdj0025Su21
//
//  Created by Michael Johnson on 7/30/21.
//

import Foundation
import UIKit
import FloatingPanel

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var data: MapItem?
    var floatingPanelController : FloatingPanelController?
    
    var weekdays : [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    var parentVC : ViewController? = ViewController()

    @IBAction func destroyView(_ sender: Any) {
        let parent = self.parentVC
        
        self.removeFromParent()
        self.view.removeFromSuperview()
        self.floatingPanelController?.removeFromParent()
        self.floatingPanelController?.view.removeFromSuperview()
        parent?.readdFloatingPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = data?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.hours.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cellId")
        let key : String = weekdays[indexPath.row]
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = data?.hours[key]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}
