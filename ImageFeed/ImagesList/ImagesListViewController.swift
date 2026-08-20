import UIKit

final class ImagesListCell: UITableViewCell {
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    
    func show(_ image: UIImage, _ date: String, liked: Bool) {
        (cellImage.image, dateLabel.text) = (image, date)
        likeButton.setImage(UIImage(named: liked ? "LikeButtonON" : "LikeButtonOFF"), for: .normal)
    }
}

final class ImagesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!
    private let photos = (0..<20).map(String.init)
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = sender as? IndexPath else { return }
        (segue.destination as? SingleImageViewController)?.image = UIImage(named: photos[index.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { photos.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesListCell", for: indexPath) as! ImagesListCell
        UIImage(named: photos[indexPath.row]).map {
            cell.show($0, formatter.string(from: Date()), liked: indexPath.row.isMultiple(of: 2))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSingleImage", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photos[indexPath.row]) else { return 0 }
        let width = tableView.bounds.width - 32
        return image.size.height * (width / image.size.width) + 8
    }
}
