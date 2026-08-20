import UIKit

final class SplashViewController: UIViewController, WebViewViewControllerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if OAuth2Service.shared.authToken != nil {
            switchToTabBarController()
        } else if presentedViewController == nil {
            performSegue(withIdentifier: "ShowAuthenticationScreen", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? UINavigationController)?
            .viewControllers.first
            .flatMap { $0 as? AuthViewController }?
            .delegate = self
    }
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetchOAuthToken(code) { [weak self] result in
            if case .success = result { self?.switchToTabBarController() }
        }
    }
    
    private func switchToTabBarController() {
        guard let window = view.window else { return }
        window.rootViewController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
    }
}
