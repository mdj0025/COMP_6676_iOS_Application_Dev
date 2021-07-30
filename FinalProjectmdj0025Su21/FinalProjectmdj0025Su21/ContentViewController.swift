//
//  ContentViewController.swift
//  FinalProjectmdj0025Su21
//
//  Created by Michael Johnson on 7/26/21.
//

import UIKit
import FloatingPanel

class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var data: [MapItem] = []
    
    var parentVC : ViewController? = ViewController()
    
    var floatingPanelController : FloatingPanelController?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        
        parentVC?.highlightMapItem(item: item)
    }

    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}
