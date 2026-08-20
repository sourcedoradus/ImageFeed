import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avatar = UIImageView(image: UIImage(named: "Avatar"))
        let name = label("Екатерина Новикова", 23, .semibold, .white)
        let login = label("@ekaterina_nov", 13, .regular, UIColor(named: "YP Gray"))
        let bio = label("Hello, World!", 13, .regular, .white)
        let logout = UIButton(type: .system)
        logout.setImage(UIImage(named: "LogoutButton"), for: .normal)
        logout.tintColor = UIColor(named: "YP Red")
        logout.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        
        [avatar, name, login, bio, logout].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 70),
            avatar.heightAnchor.constraint(equalToConstant: 70),
            avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            avatar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            login.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            login.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            bio.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 8),
            bio.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            logout.widthAnchor.constraint(equalToConstant: 44),
            logout.heightAnchor.constraint(equalToConstant: 44),
            logout.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            logout.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapLogoutButton() {}
    
    private func label(_ text: String, _ size: CGFloat, _ weight: UIFont.Weight, _ color: UIColor?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textColor = color
        return label
    }
}
