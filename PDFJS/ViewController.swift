//
//  ViewController.swift
//  PDFJS
//
//  Created by singl on 2018/10/24.
//  Copyright © 2018年 wyzw. All rights reserved.
//


//---------分割线---------------WKWebView加载PDF------------------------

import UIKit
import WebKit
//import AFNetworking
import AFNetworking

let kBasePath = NSHomeDirectory() + "/Documents/myFolder/Files/"

class ViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {

    private let fileManager = FileManager.default

    private lazy var wkweb : WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.isUserInteractionEnabled = true
        webView.scrollView.bounces = true
        webView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        webView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        webView.isMultipleTouchEnabled  = true
        webView.scrollView.isScrollEnabled = true
        webView.contentMode = UIView.ContentMode.scaleAspectFit
        return webView
    }()
    var documnetPath:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layOutUI()
        loadUrl()
    }
   
    func layOutUI() {
        view.addSubview(wkweb)
        wkweb.frame = view.frame
    }

    func loadUrl(){
        let viwerPath: String = Bundle.main.path(forResource:"viewer", ofType: "html", inDirectory: "minified/web")!
        let pdfUrl = Bundle.main.url(forResource: "123", withExtension: "pdf")
        var urlStr: String = "file://\(viwerPath)?file=\(pdfUrl!)"
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        let pathUrl = URL(string: urlStr)
        wkweb.load(URLRequest(url: pathUrl!))
//        wkweb.load(URLRequest(url: URL(fileURLWithPath: urlStr)))
//        wkweb.loadFileURL(URL(fileURLWithPath: urlStr), allowingReadAccessTo: pathUrl!)
//        wkweb.loadHTMLString("file://\(self.documnetPath)", baseURL: pathUrl!)
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        let frameInfo = navigationAction.targetFrame
        if frameInfo?.isMainFrame ?? true{
            webView.load(navigationAction.request)
        }
        return nil
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("over")
    }

    
}
