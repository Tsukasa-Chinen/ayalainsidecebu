//
//  mapViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/11/24.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class mapViewController: UIViewController, UIWebViewDelegate {

    // appDeligateをインスタンス化
    let appDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var mapWebView: UIWebView!
    
    /* whereページのフォームからの値を変数に代入するため予め変数を定義しておく */
    var getStart:String = "none"
    var getGoal:String  = "none"

	/* 他のページのフォームからの値を変数に代入するため予め変数を定義しておく */
	var selectedID:String = "none"
	var selectedFloor:String  = "none"
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

		/* Delegate */
		mapWebView.delegate = self

		/* Load File */
		appDeligate.loadFile(webViewName:mapWebView, resource: "functions", type: "js")
        appDeligate.loadFile(webViewName:mapWebView, resource: "map", type: "html")
		
        /* ayaladate.json内のデータとフォームに入力された値で検索
         ---------------------------------------------------------------------*/
        var shopStartID:String = "none"
        var shopGoalID:String  = "none"

		let filePath = Bundle.main.path(forResource: "ayaladate", ofType: "json") // ayaladate.jsonを読み込む
		let jsondata = NSData(contentsOfFile: filePath!) // Data型（人が読めない形式）でデータを取得
		let jsonArray = (try! JSONSerialization.jsonObject(with: Data.init(referencing: jsondata!))) as! NSArray // 配列データに変換

		for date in jsonArray {
			var values = date as! Dictionary<String, Any>

			//var category = values["category"] as! String
			let shopsInfo = values["shopinfo"] as! NSArray
			let shopsCount = shopsInfo.count
			
			var num:Int = 0
			for i in 0..<shopsCount{
				num += i
				let shopInfo = shopsInfo[num] as! NSDictionary
				
				let getShopName = shopInfo["name"] as! String
				let shopName = getShopName.lowercased().replacingOccurrences(of: " ", with: "-")
				let shopID = shopInfo["shopID"] as! String

				// whereからの処理
				// Start
				if (shopName == getStart) {
					shopStartID = shopID
					//print(shopStartID)
				}
				// Goal
				if (shopName == getGoal) {
					shopGoalID = shopID
					//print(shopGoalID)
				}
			}

		}
			let start = "var $startShopName = (function(){return \"\(shopStartID)\";})();"
			let goal  = "var $goalShopName = (function(){return \"\(shopGoalID)\";})();"
			let scriptStartGoal = start + goal
			mapWebView.stringByEvaluatingJavaScript(from: scriptStartGoal)

			//print(selectedID)
			//print(selectedFloor)
			let scriptSelectedShop = "var $selectedShopID = (function(){return \"\(selectedID)\";})();"
			mapWebView.stringByEvaluatingJavaScript(from: scriptSelectedShop)
	}
	/* END viewDidLoad */

	/* CREATE: Get Data from JS Function */
	var selectedPageSegue:String = "none"
	
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		if(request.url!.scheme == "scheme") {
			let components: NSURLComponents? = NSURLComponents(string: request.url!.absoluteString)
			for i in 0 ..< (components?.queryItems?.count)! {
				let page = (components?.queryItems?[i])! as URLQueryItem
				
				/* Get Page Type */
				if(page.name == "page"){
					// print(page.value!)
					/* Set Segure */
					switch page.value! {
						case "history":
							selectedPageSegue = "segueMapToHistory"
						case "search":
							selectedPageSegue = "segueMapToSearch"
						case "shop":
							selectedPageSegue = "segueMapToShop"
						case "where":
							selectedPageSegue = "segueMapToWhere"
						default:
							selectedPageSegue = ""
					}
					// print(selectedPageSegue)
					
					/* Segure */
					if(selectedPageSegue != ""){
						performSegue(withIdentifier: selectedPageSegue, sender: nil)
					}
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
