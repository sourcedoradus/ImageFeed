import UIKit

final class SingleImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    
    var image: UIImage? { didSet { if isViewLoaded { applyImage() } } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        applyImage()
    }
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @IBAction private func didTapShareButton(_ sender: UIButton) {
        guard let image else { return }
        present(UIActivityViewController(activityItems: [image], applicationActivities: nil), animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { imageView }
    
    private func applyImage() {
        guard let image else { return }
        imageView.image = image
        imageView.frame.size = image.size
        view.layoutIfNeeded()
        
        let visible = scrollView.bounds.size
        let scale = min(
            scrollView.maximumZoomScale,
            max(
                scrollView.minimumZoomScale,
                min(visible.width / image.size.width, visible.height / image.size.height)
            )
        )
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        
        let size = scrollView.contentSize
        scrollView.setContentOffset(
            CGPoint(x: (size.width - visible.width) / 2, y: (size.height - visible.height) / 2),
            animated: false
        )
    }
}
