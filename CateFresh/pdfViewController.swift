//
//  pdfViewController.swift
//  CateFresh
//
//  Created by Connor Pan on 10/27/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit

class pdfViewController: UIViewController{
    
    @IBOutlet weak var webView: UIWebView!

    var file = File()
    
    override func viewDidLoad() {
        
        let fileMgr = FileManager.default
        
        if !fileMgr.fileExists(atPath: file.name) {
            let shortFileName = file.name.components(separatedBy: "/")
            
            let alertController = UIAlertController(title: "Missing Data File", message: "\"" + shortFileName[shortFileName.count - 1] + "\" is missing", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Create an NSURL object based on the file path.
            let url = NSURL.fileURL(withPath: file.name)

            // Create an NSURLRequest object.
            let request = NSURLRequest(url: url)
            
            // Load the web viewer using the request object.
            webView.loadRequest(request as URLRequest)
        }
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
