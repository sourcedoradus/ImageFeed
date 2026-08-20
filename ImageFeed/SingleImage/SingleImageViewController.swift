import UIKit

final class SingleImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    var image: UIImage? { didSet { if isViewLoaded { apply() } } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (scrollView.minimumZoomScale, scrollView.maximumZoomScale) = (0.1, 1.25)
        apply()
    }
    
    @IBAction private func didTapBackButton() { dismiss(animated: true) }
    
    @IBAction private func didTapShareButton(_ sender: UIButton) {
        image.map { present(UIActivityViewController(activityItems: [$0], applicationActivities: nil), animated: true) }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { imageView }
    
    private func apply() {
        guard let image else { return }
        imageView.image = image
        imageView.frame.size = image.size
        view.layoutIfNeeded()
        let visible = scrollView.bounds.size
        scrollView.zoomScale = min(
            scrollView.maximumZoomScale,
            max(scrollView.minimumZoomScale, min(visible.width / image.size.width, visible.height / image.size.height))
        )
        scrollView.layoutIfNeeded()
        let size = scrollView.contentSize
        scrollView.contentOffset = CGPoint(x: (size.width - visible.width) / 2, y: (size.height - visible.height) / 2)
    }
}
