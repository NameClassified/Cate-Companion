//
//  directoryViewController.swift
//  CateFresh
//
//  Created by Connor Pan on 2/17/17.
//  Copyright © 2017 Connor Pan. All rights reserved.
//

import UIKit


class directoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var file = File()
    
    var directoryNames : [String] = ["Student","Faculty","Family"]
    
    @IBOutlet weak var webView: UIWebView!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileMgr = FileManager.default
        
        let selectedDir = directoryNames[indexPath.row]
        var url: URL
        
        if selectedDir == "Student" {
            if fileMgr.fileExists(atPath: file.name + "/studentdirectory.pdf") {
                url = NSURL.fileURL(withPath: file.name + "/studentdirectory.pdf")
                let request = NSURLRequest(url: url)
                webView.loadRequest(request as URLRequest)
            } else {
                presentDataFileMissing(fileName: "studentdirectory.pdf")
            }
        } else if selectedDir == "Faculty" {
            if fileMgr.fileExists(atPath: file.name + "/facultydirectory.pdf") {
                url = NSURL.fileURL(withPath: file.name + "/facultydirectory.pdf")
                let request = NSURLRequest(url: url)
                webView.loadRequest(request as URLRequest)
            } else {
                presentDataFileMissing(fileName: "facultydirectory.pdf")
            }
        } else {
            if fileMgr.fileExists(atPath: file.name + "/familydirectory.pdf") {
                url = NSURL.fileURL(withPath: file.name + "/familydirectory.pdf")
                let request = NSURLRequest(url: url)
                webView.loadRequest(request as URLRequest)
            } else {
                presentDataFileMissing(fileName: "familydirectory.pdf")
            }
        }        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = directoryNames[indexPath.row]
        return cell
    }

    func presentDataFileMissing(fileName: String) {
        let alertController = UIAlertController(title: "Missing Data File", message: "\"" + fileName + "\" is missing", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
