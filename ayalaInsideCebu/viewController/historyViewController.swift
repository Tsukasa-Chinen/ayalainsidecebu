//
//  historyViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/12/04.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit
import CoreData
import Foundation

class historyViewController: UIViewController, UIWebViewDelegate {

	// appDeligateをインスタンス化
	let appDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

	@IBOutlet weak var historyWebView: UIWebView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		/* Delegate */
		historyWebView.delegate = self
		
		/* Load File */
		appDeligate.loadFile(webViewName:historyWebView, resource: "functions", type: "js")
		appDeligate.loadFile(webViewName:historyWebView, resource: "history", type: "html")
		
		var coreDataDic:[NSDictionary] = []
		
		// AppDelegateを使う用意をしておく
		let letAppDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
		
		// エンティティを操作するためのオブジェクト作成
		let letViewContext = letAppDeligate.persistentContainer.viewContext
		
		// どのエンティティからデータを取得してくるかを設定（Historyエンティティ）
		let letQuery:NSFetchRequest<History> = History.fetchRequest()
		
		// きちんと保存できてるか、1行ずつ表示（デバッグエリア）
		do {
			let fetchResults = try letViewContext.fetch(letQuery)
			for result: AnyObject in fetchResults {
				let letShopID: String = result.value(forKey: "shopID") as! String
				let letShopName: String = result.value(forKey: "shopName") as! String
				let letShopFloor: String = result.value(forKey: "shopFloor") as! String
				let letDate: Date = result.value(forKey: "date") as! Date

				let df = DateFormatter();
				df.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "en_PH"))
				df.dateStyle = .medium
				
				var dic = ["shopID": letShopID, "shopName": letShopName, "shopFloor": letShopFloor, "date": df.string(from: letDate)] as! [String:Any]
				coreDataDic.append(dic as NSDictionary)
			}
			
			// DictionaryをJSONデータに変換
			let jsonData = try JSONSerialization.data(withJSONObject: coreDataDic)
			// JSONデータを文字列に変換
			let jsonStr = String(bytes: jsonData, encoding: .utf8)!
			print(jsonStr)
			
			let scriptCoreDataJSON = "var $scriptCoreDataJSON = \(jsonStr);"
			historyWebView.stringByEvaluatingJavaScript(from: scriptCoreDataJSON)
		}
		catch {
		}
	}

	/* CREATE: Get Data from JS Function */
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		if(request.url!.scheme == "scheme") {
			let components: NSURLComponents? = NSURLComponents(string: request.url!.absoluteString)
			for i in 0 ..< (components?.queryItems?.count)! {
				let page = (components?.queryItems?[i])! as URLQueryItem
				
				/* Segure */
				performSegue(withIdentifier: "segueHistoryToMap", sender: nil)
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
