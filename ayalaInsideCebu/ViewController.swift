//
//  ViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/11/17.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var whereWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Delegate */
        whereWebView.delegate = self

        /* Load File */
        loadFile(resource: "functions", type: "js")
        loadFile(resource: "where", type: "html")
    }
    
    /* CREATE: HTML or JS Load Function */
    func loadFile(resource: String, type: String){
        let filePath = Bundle.main.path(forResource: resource, ofType: type)
        if(type == "js"){
            let scriptContents = try! String(contentsOfFile: filePath!, encoding:String.Encoding.utf8)
            whereWebView.stringByEvaluatingJavaScript(from: scriptContents)
        }else if(type == "html"){
            let url = URL(fileURLWithPath:filePath!)
            let urlRequest = URLRequest(url: url)
            whereWebView.loadRequest(urlRequest)
        }
    }
    
    /* CREATE: Get Data from JS Function */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if(request.url!.scheme == "scheme") {
            let components: NSURLComponents? = NSURLComponents(string: request.url!.absoluteString)
            for i in 0 ..< (components?.queryItems?.count)! {
                let item = (components?.queryItems?[i])! as URLQueryItem
                print("キー：\(item.name)→値：\(String(describing: item.value))\n")
            }
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

