//
//  MasterViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var objectsDictionary : [String : String] = [:]
    let startString: String = "New Item"
    var titleText = ""
    var detailText = ""
    var didClickSave = false
    var newKey = false
    var oldKey = ""

    var storedDictionary: [[String: String]] = []
    func dataFileUrl() -> URL
    {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url: URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent("data.plist")
        return url!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fileURL = self.dataFileUrl()
        if (FileManager.default.fileExists(atPath: fileURL.path))
        {
            print("Found File")
            storedDictionary = (NSArray(contentsOf: fileURL as URL) as? [[String:String]])!
            for todoDictionary in storedDictionary
            {
                for (key, value) in todoDictionary
                {
                    objectsDictionary[key] = value
                    objects.append(key)
                }
            }
        }
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc  func applicationWillResignActive(notification: NSNotification)
    {
        print("saved data")
        let fileURL = self.dataFileUrl()
        storedDictionary = [[String:String]]()
        for key in objects
        {
            let value : String = objectsDictionary[key as! String]!
            storedDictionary.append([key as! String: value])
        }

        let array = (self.storedDictionary as NSArray)
        array.write(to: fileURL as URL,atomically: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        if(didClickSave)
        {
            let value = objectsDictionary[titleText]
            if (value == nil)
            {
                if (newKey)
                {
                    objects.insert(titleText, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
                else
                {
                    objectsDictionary[oldKey] = nil
                    let index = objects.firstIndex(where: {$0 as! String == oldKey})
                    objects.remove(at: index!)
                    objects.insert(titleText, at: 0)
                }
            }
            objectsDictionary[titleText] = detailText
            didClickSave = false
            newKey = false
        }
        tableView.reloadData()
    }

    @objc
    func insertNewObject(_ sender: Any) {
        newKey = true
        performSegue(withIdentifier: "showDetail", sender: self)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.masterViewController = self
            detailViewController = controller
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! String
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.detailText = objectsDictionary[object]
                oldKey = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] as! String
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = objects[sourceIndexPath.row]
        objects.remove(at: sourceIndexPath.row)
        objects.insert(item, at: destinationIndexPath.row)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key : String = objects[indexPath.row] as! String
            objects.remove(at: indexPath.row)
            objectsDictionary[key] = nil
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

