
import UIKit

extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}

class A8ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        self.title = "Image Gallary"
        
        var tag = 1
        
        let imageView1 = UIImageView(image: UIImage(named: "kitchen"))
        let imageView2 = UIImageView(image: UIImage(named: "bathroom"))
        let imageView3 = UIImageView(image: UIImage(named: "library"))
        
        
        [imageView1, imageView2, imageView3].forEach {
            
            $0.frame = CGRect.zero
            $0.tag = tag
            $0.isUserInteractionEnabled = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            
//            self.view.addSubview($0)
            self.scrollView.addSubview($0)
            
            tag += 1
        }
        

        // こうすると、ナビゲーションバーのbottomを基準に制約をかけられる
        // (=ナビゲーションバーがあると、topLayoutGuide がせり下がってくる)
        imageView1.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        imageView1.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        imageView1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        imageView1.heightAnchor.constraint(equalTo: imageView1.widthAnchor, multiplier: 1).isActive = true
        
        imageView1.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true

        
        
        imageView2.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        imageView2.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor).isActive = true
        imageView2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        imageView2.heightAnchor.constraint(equalTo: imageView2.widthAnchor, multiplier: 1).isActive = true
        
        imageView2.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true


        
        imageView3.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        imageView3.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor).isActive = true
        imageView3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        imageView3.heightAnchor.constraint(equalTo: imageView3.widthAnchor, multiplier: 1).isActive = true
        
        
        imageView3.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        imageView3.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        
        if let _ = touch.view as? UIImageView {
            move(tag: (touch.view?.tag)!)
        }
    }
    
    
    func move(tag: Int) {
        let paths = ["kitchen", "bathroom", "library"]
        performSegue(withIdentifier: "ImageTapped", sender: paths[tag-1])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! DetailViewController
        
        if let imagePath = sender as? String {
            vc.imagePath = imagePath
        }
    }
}

