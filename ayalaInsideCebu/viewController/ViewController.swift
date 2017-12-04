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

    // appDeligateをインスタンス化
    let appDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var whereWebView: UIWebView!

    var sendStart:String = "none"
    var sendGoal:String = "none"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Delegate */
        whereWebView.delegate = self

        /* Load File */
        appDeligate.loadFile(webViewName:whereWebView, resource: "functions", type: "js")
        appDeligate.loadFile(webViewName:whereWebView, resource: "where", type: "html")
    }
        
    /* CREATE: Get Data from JS Function */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if(request.url!.scheme == "scheme") {
            let components: NSURLComponents? = NSURLComponents(string: request.url!.absoluteString)
            for i in 0 ..< (components?.queryItems?.count)! {
                let item = (components?.queryItems?[i])! as URLQueryItem
                // print("キー：\(item.name)→値：\(item.value!)\n")
                
                if(item.name == "start"){
                    sendStart = item.value!
                }else if(item.name == "goal"){
                    sendGoal = item.value!
                }
            }
            
            /* Segure */
            performSegue(withIdentifier: "segueWhereToMap", sender: nil)
            return false
        }
        return true
    }

    /* OVERRIDE: prepare */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // mapViewController.getStartに選択された番号を渡す
        let map:mapViewController = segue.destination as! mapViewController
        map.getStart = sendStart
        map.getGoal = sendGoal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
