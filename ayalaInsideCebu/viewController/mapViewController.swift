//
//  mapViewController.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/11/24.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import WebKit

class mapViewController: UIViewController, UIWebViewDelegate {

    // appDeligateをインスタンス化
    let appDeligate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var mapWebView: UIWebView!
    
    /* フォームからの値を変数に代入するため予め変数を定義しておく */
    var getStart:String = "none"
    var getGoal:String  = "none"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        /* Load File */
        appDeligate.loadFile(webViewName:mapWebView, resource: "map", type: "html")

        /* ayaladate.json内のデータをフォームに入力された値で検索
         ---------------------------------------------------------------------*/
        var shopStartID:String = "none"
        var shopGoalID:String  = "none"

		var filePath = Bundle.main.path(forResource: "ayaladate", ofType: "json") // ayaladate.jsonを読み込む
		var jsondata = NSData(contentsOfFile: filePath!) // Data型（人が読めない形式）でデータを取得
		var jsonArray = (try! JSONSerialization.jsonObject(with: Data.init(referencing: jsondata!))) as! NSArray // 配列データに変換

		for date in jsonArray {
			var values = date as! Dictionary<String, Any>

			//var category = values["category"] as! String
			var shopsInfo = values["shopinfo"] as! NSArray
			var shopsCount = shopsInfo.count
			
			var num:Int = 0
			for i in 0..<shopsCount{
				num += i
				var shopInfo = shopsInfo[num] as! NSDictionary
				//print("店名：\(shopInfo["name"])、ID：\(shopInfo["id"])、フロアー：\(shopInfo["floor"])")
				
				var shopName = shopInfo["name"] as! String
				var shopID = shopInfo["id"] as! String

				// Start
				if shopName == getStart {
					shopStartID = shopID
				}
				// Goal
				if shopName == getGoal {
					shopGoalID = shopID
				}
			}
			let scriptStart = "var $startShopName = (function(){return \"\(shopStartID)\";})();"
			let scriptGoal  = "var $goalShopName = (function(){return \"\(shopGoalID)\";})();"
			let script = scriptStart + scriptGoal
			mapWebView.stringByEvaluatingJavaScript(from: script)
		}
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
