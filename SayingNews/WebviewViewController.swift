//
//  WebViewController.swift
//  SayingNews
//
//  Created by duoda james on 2018/9/20.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import UIKit

class WebviewViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webURL = URL(string: url!)
        let webRequest = URLRequest(url: webURL!)
        self.webView.loadRequest(webRequest)
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
