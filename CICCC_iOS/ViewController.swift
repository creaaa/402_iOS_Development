
import UIKit

class ViewController: UIViewController {

    enum ViewMode: Int {
        case portlait, landscape, square
    }
    
    var greenView:    UIView!
    var toggleButton: UIButton!
    var viewMode:     ViewMode  = .square
    
    // 再利用する制約
    var constraints: [NSLayoutConstraint] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
        
        // 1. 緑ビュー定義 + addSubView
        self.greenView = yieldGreenView()
        self.view.addSubview(self.greenView)

        
        // 2. トグルボタン定義 + addSubView
        self.toggleButton = yieldToggleButton()
        self.view.addSubview(self.toggleButton)
        
        
        // 3. 制約を付加
        self.yieldGreenViewConstraint()
        self.yieldToggleButtonConstraint()

    }
    
    
    func yieldGreenView() -> UIView {
        
        let greenView = UIView().apply {
            $0.frame = CGRect.zero
            $0.backgroundColor = UIColor.green
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return greenView
        
    }
    
    
    func yieldToggleButton() -> UIButton {
        
        let toggleButton = UIButton().apply {
            $0.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
            $0.setTitle("landscape", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTarget(self,
                         action: #selector(ViewController.toggleButtonTapped(sender:)),
                         for: .touchUpInside
                        )
        }
        
        return toggleButton
        
    }
    
    
    func yieldGreenViewConstraint() {
        
        // Way 1
        
        // self.view.removeConstraints(self.constraints)
        
        // 本来これ書かないといけないっぽいのに、なくても動いてるんだけど。なんでや。↑のメソッドよくわからん...
        // self.constraints = []
        
        
        // Way 2. ↑に比べ、こっちのほうが直感的ではある。ただ、constraintsに無限に要素が増えてくが...
        self.constraints.forEach{ $0.isActive = false }
        
        
                     /* P    L    S*/
        let marginX = [350, 100, 325]
        let width   = [350, 815, 400]
        
        let marginY = [50,  200, 100]
        let height  = [600, 250, 400]

        
        // 左マージン
        let leadingConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: CGFloat(marginX[self.viewMode.rawValue])
        )
        
        
        // 幅
        let widthConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: CGFloat(width[self.viewMode.rawValue])
        )
        
        
        // 上マージン
        let topConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: CGFloat(marginY[self.viewMode.rawValue])
        )
        
        
        // 高さ
        let heightConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: CGFloat(height[self.viewMode.rawValue])
        )
        
        let constraints = [leadingConstraint, widthConstraint, topConstraint, heightConstraint]
        
        self.constraints.append(contentsOf: constraints)
        
        self.view.addConstraints(constraints)
        
    }
    
    
    func yieldToggleButtonConstraint() {
        
        // 左マージン
        let leadingConstraint = NSLayoutConstraint(
            item: self.toggleButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
    
        // 上マージン
        let topConstraint = NSLayoutConstraint(
            item: self.toggleButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 680
        )
        
        self.view.addConstraints([leadingConstraint, topConstraint])
        
    }
    
    
    func toggleButtonTapped(sender: UIButton) {
        
        // まず、ステートを変えて...
        self.viewMode = ViewMode(rawValue: (self.viewMode.rawValue + 1) % 3)!
        
        print("現在のモード: \(viewMode)")
        
        // ほんで、緑のビューを更新
        self.yieldGreenViewConstraint()
        
        // ついでにボタンのラベルも変えとくね
        switch viewMode {
            case .portlait:
                sender.setTitle("landscape", for: .normal)
            case .landscape:
                sender.setTitle("square",    for: .normal)
            case .square:
                sender.setTitle("portlait",  for: .normal)
        }
    
    }
}

