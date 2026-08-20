import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        func text(_ value: String, _ size: CGFloat, _ weight: UIFont.Weight, _ color: UIColor?) -> UILabel {
            let label = UILabel()
            label.text = value
            label.font = .systemFont(ofSize: size, weight: weight)
            label.textColor = color
            return label
        }
        let avatar = UIImageView(image: UIImage(named: "Avatar"))
        let stack = UIStackView(arrangedSubviews: [
            avatar,
            text("Екатерина Новикова", 23, .semibold, .white),
            text("@ekaterina_nov", 13, .regular, UIColor(named: "YP Gray")),
            text("Hello, World!", 13, .regular, .white)
        ])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        let logout = UIButton(type: .system)
        logout.setImage(UIImage(named: "LogoutButton"), for: .normal)
        logout.tintColor = UIColor(named: "YP Red")
        logout.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        [stack, logout].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 70),
            avatar.heightAnchor.constraint(equalToConstant: 70),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            stack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            logout.widthAnchor.constraint(equalToConstant: 44),
            logout.heightAnchor.constraint(equalToConstant: 44),
            logout.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            logout.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapLogoutButton() {}
}
