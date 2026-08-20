import UIKit
@preconcurrency import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
}

final class WebViewViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var progressView: UIProgressView!
    
    weak var delegate: WebViewViewControllerDelegate?
    private var progressObservation: NSKeyValueObservation?
    private var didAuthenticate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        progressObservation = webView.observe(\.estimatedProgress) { [weak self] _, _ in
            self?.updateProgress()
        }
        updateProgress()
        
        if let url = Constants.url(Constants.authorizeURL, [
            "client_id": Constants.accessKey,
            "redirect_uri": Constants.redirectURI,
            "response_type": "code",
            "scope": Constants.accessScope
        ]) {
            webView.load(URLRequest(url: url))
        }
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard let code = code(from: navigationAction) else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        guard !didAuthenticate else { return }
        didAuthenticate = true
        delegate?.webViewViewController(self, didAuthenticateWithCode: code)
    }
    
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = abs(webView.estimatedProgress - 1) <= 0.0001
    }
    
    private func code(from action: WKNavigationAction) -> String? {
        guard
            let url = action.request.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            components.path == "/oauth/authorize/native"
        else { return nil }
        return components.queryItems?.first { $0.name == "code" }?.value
    }
}
