//
//  WebView.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import SwiftUI
import WebKit

struct SafariWebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
}
