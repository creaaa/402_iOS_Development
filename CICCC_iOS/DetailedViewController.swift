
import UIKit

class DetailedViewController: UIViewController {

    var no: Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // 「なんか」設定しないと、遷移時、黒い画面になりちらつく
        // SBからビューを参照しようとすることが原因だとか？
        self.view.backgroundColor = .orange
        
        let label = UILabel(frame: .zero).apply {
            $0.text = (self.no?.description)!
            $0.backgroundColor = .red
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    

}








