import UIKit
@preconcurrency import WebKit

private enum Unsplash {
    static let id = "8OMU9ECyFHx2_Qd3IJW0ktB0HClKluwTonyQhvt2pS4"
    static let secret = "LFzxiUqTOYsWW1RI7Sy4_hGE6sLGZQe1BMzAGuBfX6Y"
    static let redirect = "urn:ietf:wg:oauth:2.0:oob"
    
    static func url(_ string: String, _ query: [String: String]) -> URL? {
        var components = URLComponents(string: string)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}

final class OAuth2Service {
    static let shared = OAuth2Service()
    private var task: URLSessionTask?
    private init() {}
    private struct Token: Decodable { let access_token: String }
    
    var token: String? {
        get { UserDefaults.standard.string(forKey: "token") }
        set { UserDefaults.standard.set(newValue, forKey: "token") }
    }
    
    func fetch(_ code: String, done: @escaping (Bool) -> Void) {
        guard task == nil,
              let url = Unsplash.url("https://unsplash.com/oauth/token", [
                "client_id": Unsplash.id,
                "client_secret": Unsplash.secret,
                "redirect_uri": Unsplash.redirect,
                "code": code,
                "grant_type": "authorization_code"
              ]) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        task = URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
            let token = (200..<300).contains((response as? HTTPURLResponse)?.statusCode ?? 0)
                ? data.flatMap { try? JSONDecoder().decode(Token.self, from: $0).access_token }
                : nil
            DispatchQueue.main.async {
                self?.task = nil
                if let token { self?.token = token }
                done(token != nil)
            }
        }
        task?.resume()
    }
}

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    weak var delegate: WebViewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = navigationController?.navigationBar
        let back = UIImage(named: "nav_back_button")
        nav?.backIndicatorImage = back
        nav?.backIndicatorTransitionMaskImage = back
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? WebViewViewController)?.delegate = delegate
    }
}

final class WebViewViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var progressView: UIProgressView!
    weak var delegate: WebViewViewControllerDelegate?
    private var observation: NSKeyValueObservation?
    private var finished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        observation = webView.observe(\.estimatedProgress) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
            self?.progressView.isHidden = webView.estimatedProgress >= 1
        }
        Unsplash.url("https://unsplash.com/oauth/authorize", [
            "client_id": Unsplash.id,
            "redirect_uri": Unsplash.redirect,
            "response_type": "code",
            "scope": "public read_user write_likes"
        ]).map { webView.load(URLRequest(url: $0)) }
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let url = navigationAction.request.url,
           let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           components.path == "/oauth/authorize/native",
           let code = components.queryItems?.first(where: { $0.name == "code" })?.value {
            decisionHandler(.cancel)
            guard !finished else { return }
            finished = true
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
        } else {
            decisionHandler(.allow)
        }
    }
}

final class SplashViewController: UIViewController, WebViewViewControllerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if OAuth2Service.shared.token != nil {
            showTabBar()
        } else if presentedViewController == nil {
            performSegue(withIdentifier: "ShowAuthenticationScreen", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ((segue.destination as? UINavigationController)?.viewControllers.first as? AuthViewController)?.delegate = self
    }
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetch(code) { [weak self] in if $0 { self?.showTabBar() } }
    }
    
    private func showTabBar() {
        view.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TabBarViewController")
    }
}
