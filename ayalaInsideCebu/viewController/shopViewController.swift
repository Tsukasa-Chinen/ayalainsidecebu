//
//  shopViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/11/29.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class shopViewController: UIViewController, UIWebViewDelegate {

    // appDeligateをインスタンス化
    let appDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var shopWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

		/* Delegate */
		shopWebView.delegate = self

		/* Load File */
		appDeligate.loadFile(webViewName:shopWebView, resource: "functions", type: "js")
        appDeligate.loadFile(webViewName:shopWebView, resource: "shop", type: "html")
    }
	
	var selectID: String = "none"
	var selectFloor: String = "none"
	
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		if(request.url!.scheme == "scheme") {
			let selectedComponents: NSURLComponents? = NSURLComponents(string: request.url!.absoluteString)
			for i in 0 ..< (selectedComponents?.queryItems?.count)! {
				let shopInfo = (selectedComponents?.queryItems?[i])! as URLQueryItem
				
				
				if(shopInfo.name == "shop_id"){
					selectID = shopInfo.value!
				}else if(shopInfo.name == "shop_floor"){
					selectFloor = shopInfo.value!
				}
				
				
			}

			/* Save CoreData */
			appDeligate.saveCoreData (entity: "History", shopID: selectID)

			/* Segure */
			performSegue(withIdentifier: "segueShopToMap", sender: nil)
			
			return false
		}

		return true
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// mapViewController.getStartに選択された番号を渡す
		let map:mapViewController = segue.destination as! mapViewController
		map.selectedID = selectID
		map.selectedFloor = selectFloor
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
