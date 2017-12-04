//
//  searchViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/12/03.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit

class searchViewController: UIViewController, UIWebViewDelegate {

	// appDeligateをインスタンス化
	let appDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

	@IBOutlet weak var searchWebView: UIWebView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

		/* Delegate */
		searchWebView.delegate = self

		/* Load File */
		appDeligate.loadFile(webViewName:searchWebView, resource: "functions", type: "js")
		appDeligate.loadFile(webViewName:searchWebView, resource: "search", type: "html")

    }

	/* CREATE: Get Data from JS Function */
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		if(request.url!.scheme == "scheme") {
			let components: NSURLComponents? = NSURLComponents(string: request.url!.absoluteString)
			for i in 0 ..< (components?.queryItems?.count)! {
				let page = (components?.queryItems?[i])! as URLQueryItem
				
				/* Get Page Type */
				if(page.name == "page"){
					/* Segure */
					performSegue(withIdentifier: "segueSearchToMap", sender: nil)
				}
			}
			return false
		}
		return true
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
