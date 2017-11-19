//
//  ViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/11/17.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit

/* HTMLファイルを読み込み */
let svgPath = Bundle.main.path(forResource: "demo", ofType: "html")

/* WebViewを作成 */
var webView: UIWebView!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        /* 読み込み時にWebViewwに表示 */
        webView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        let request = URL(fileURLWithPath: svgPath!)
        let req = URLRequest(url: request)
        webView.loadRequest(req)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

