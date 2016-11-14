//
//  pdfViewController.swift
//  CateFresh
//
//  Created by Jeff Pan on 10/27/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit
import WebKit

class pdfViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    var file = File()
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the document's file path.
        let path = Bundle.main.path(forResource: file.name, ofType: nil)
        
        // Create an NSURL object based on the file path.
        let url = NSURL.fileURL(withPath: path!)
        
        // Create an NSURLRequest object.
        let request = NSURLRequest(url: url)
        
        // Load the web viewer using the request object.
        webView.load(request as URLRequest)
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
