//
//  TableViewController.swift
//  FocusStartAleshkov
//
//  Created by andrey on 10.02.17.
//  Copyright © 2017 andrey. All rights reserved.
//
//
//import UIKit
//
//class TableViewController: UITableViewController {
//    
//    
//    var data: String!
//    var titles: String!
//    var type: String!
//    var content: String?
//    var source: String?
//    var network: String?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        readJson()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }

//    private func readJson() {
//        do {
//            if let file = Bundle.main.url(forResource: "messages", withExtension: "json") {
//                let data = try Data(contentsOf: file)
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                if let object = json as? [String: Any] {
//                    // json is a dictionary
//                    print(object)
//                } else if let object = json as? [Any] {
//                    // json is an array
//                    //                    print(object)
//                    readArray(array: object)
//                } else {
//                    print("JSON is invalid")
//                }
//            } else {
//                print("no file")
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    
//    func readArray(array: [Any]) {
//        for i in 0..<array.count {
//            
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: array[i], options: JSONSerialization.WritingOptions.prettyPrinted)
//                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
//                
//            
//                data = json?["date"] as! String!
//                titles = json?["title"] as! String!
//                type = json?["type"] as! String!
////                content = json!["content"] as! String?
////                source = json?["source"] as! String?
////                network = json?["network"] as! String?
////                
////                print("======================================")
////                print(title!)
////                print(type!)
////                print(data!)
//                
//                if source == nil {
//                    print("source is nil")
//                } else {
//                    source = json?["source"] as! String?
//                }
//                
//                if network == nil {
//                    print("network is nil")
//                } else {
//                    network = json?["network"] as! String?
//                }
//                
//                if content == nil {
//                    print("content is nil")
//                } else {
//                    content = json!["content"] as! String?
//                }
//            } catch {
//                print("oops")
//            }
//        }
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source
    
    
    
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return ((readJson()) as AnyObject).count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var textCell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
//        var imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
//        var socialCell = tableView.dequeueReusableCell(withIdentifier: "socialCell", for: indexPath)
//
//        
//        
//        return socialCell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}
