//
//  CapitalInfoViewController.swift
//  Capital-Cities-P16
//
//  Created by Łukasz Nycz on 08/08/2021.
//

import UIKit
import WebKit

class CapitalInfoViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var detailInfo: Capital?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            }

}
