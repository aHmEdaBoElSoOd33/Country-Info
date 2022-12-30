//
//  GoogleMapsVC.swift
//  Country Info
//
//  Created by Ahmed on 30/12/2022.
//

import UIKit
import WebKit
class GoogleMapsVC: UIViewController , WKNavigationDelegate, UIWebViewDelegate {

    //MARK: - IBOutlets
    
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var ActIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Variables
    
    var mapLink = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLink()
    }
    

    //MARK: - Functions
    
    func getLink() {
        let url = URL(string: mapLink )
        let request = URLRequest(url: url!)
        webview.loadRequest(request)
        webview.addSubview(ActIndicator)
        webview.delegate = self
    }
    
    
    //MARK: - IBActions
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        ActIndicator.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        ActIndicator.stopAnimating()
        ActIndicator.hidesWhenStopped = true
    }

}
