
import UIKit

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
            
            self.view.addSubview($0)
            
            tag += 1
        }
        

        // こうすると、ナビゲーションバーのbottomを基準に制約をかけられる
        // (=ナビゲーションバーがあると、topLayoutGuide がせり下がってくる)
        imageView1.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        imageView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        imageView1.heightAnchor.constraint(equalTo: imageView1.widthAnchor, multiplier: 1).isActive = true
        
        
        imageView2.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        imageView2.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor).isActive = true
        imageView2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        imageView2.heightAnchor.constraint(equalTo: imageView2.widthAnchor, multiplier: 1).isActive = true
        
        
        imageView3.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        imageView3.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor).isActive = true
        imageView3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        imageView3.heightAnchor.constraint(equalTo: imageView3.widthAnchor, multiplier: 1).isActive = true
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        move(tag: (touches.first?.view?.tag)!)
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

