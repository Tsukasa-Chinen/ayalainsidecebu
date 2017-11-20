//
//  ViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/11/17.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Load: Local HTML */
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let uri = URL(fileURLWithPath:htmlPath!)
        let uriRequest = URLRequest(url: uri)
        myWebView.load(uriRequest)
        
    } /* END override */

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } /* END didReceiveMemoryWarning */


}

