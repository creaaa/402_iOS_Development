
import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    var imagePath = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView:  UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.imageView.alpha = 0
        self.imageView.image = UIImage(named: imagePath)
        
        scrollView.delegate = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        scrollView.contentInset.top =
            (scrollView.bounds.size.height - imageView.bounds.size.height) / 2.0
        
        scrollView.contentInset.bottom =
            (scrollView.bounds.size.height - imageView.bounds.size.height) / 2.0
        
        scrollView.setZoomScale(1, animated: false)
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        
//        view.layoutIfNeeded()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 1
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
}


