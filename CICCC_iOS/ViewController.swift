
import UIKit

class ViewController: UIViewController {

    enum ViewMode: Int {
        case portlait, landscape, square
    }
    
    enum ViewColor: Int {
        case green, purple
    }
    
    
    var greenView:    UIView!
    var purpleView:   UIView!
    
    var views: [UIView] = []
    
    var toggleButton: UIButton!
    var viewMode:     ViewMode = .portlait
    
    
    // 再利用する制約
    var rootViewConstraints:  [NSLayoutConstraint] = []
    var greenViewConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
        
        // 1. 緑ビュー定義 + addSubView
        self.greenView = yieldView(color: .green)
        self.view.addSubview(self.greenView)

        
        // 2. 紫ボタン定義 + addSubView
        self.purpleView = yieldView(color: .purple)
        self.greenView.addSubview(purpleView)
        
        
        // 3. トグルボタン定義 + addSubView
        self.toggleButton = yieldToggleButton()
        self.view.addSubview(self.toggleButton)
        
        
        self.views = [greenView, purpleView]
        
        
        // 4. 制約を付加
        self.yieldViewConstraint(viewColor: .green)  // 緑ビュー
        self.yieldViewConstraint(viewColor: .purple, isPurpleView: true) // 紫ビュー
        self.yieldToggleButtonConstraint()

    }
    
    
    func yieldView(color: UIColor) -> UIView {
        
        let view = UIView(frame: .zero).apply {
            $0.frame = CGRect.zero
            $0.backgroundColor = color
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return view
        
    }
    
    
    func yieldToggleButton() -> UIButton {
        
        let toggleButton = UIButton(type: .system).apply {
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
    
    
    func yieldViewConstraint(viewColor: ViewColor, isPurpleView: Bool = false) {
        
        let targetView = self.views[viewColor.rawValue]  // ローカルコピー
        
        // ビューの色 & ビューモードが既に考慮されたタプルが返ってくる
        let constraintDef = ConstraintDef.defByViewColorAndViewMode(viewColor: viewColor, viewMode: self.viewMode)
        
        // true: →と↓にマージン false: ←と↑にマージン
        let xFlag: NSLayoutAttribute = isPurpleView ? .trailing : .leading
        let yFlag: NSLayoutAttribute = isPurpleView ? .bottom   : .top
        
        // 紫ビューなら、ルートビューではなく緑ビューに対して制約をつける
        let toItem: UIView           = isPurpleView ? self.greenView : self.view
        
        
        // 左マージン
        let leadingConstraint = NSLayoutConstraint(
            item: targetView,
            attribute: xFlag,
            relatedBy: .equal,
            toItem: toItem,
            attribute: xFlag,
            multiplier: 1,
            constant: CGFloat(constraintDef.marginX)
        )
        
        
        // 幅 (紫ビューと緑ビューで定義が違う)
        
        let widthConstraint: NSLayoutConstraint
        
        if isPurpleView {  // 紫
        
            widthConstraint = NSLayoutConstraint(
                item: self.purpleView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.greenView,
                attribute: .width,
                multiplier: 305 / 500,
                constant: 0
            )

        } else {          // 緑
            
            widthConstraint = NSLayoutConstraint(
                item: targetView,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: CGFloat(constraintDef.width)
            )
        }
        
        
        // 上マージン
        let topConstraint = NSLayoutConstraint(
            item: targetView,
            attribute: yFlag,
            relatedBy: .equal,
            toItem: toItem,
            attribute: yFlag,
            multiplier: 1,
            constant: CGFloat(constraintDef.marginY)
        )
        
        
        // 高さ
        let heightConstraint = NSLayoutConstraint(
            item: targetView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: CGFloat(constraintDef.height)
        )
        
        let constraints = [leadingConstraint, widthConstraint, topConstraint, heightConstraint]
        
        if isPurpleView {
            self.greenViewConstraints.append(contentsOf: constraints)
            self.greenView.addConstraints(constraints)
        } else {
            self.rootViewConstraints.append(contentsOf: constraints)
            self.view.addConstraints(constraints)
        }
        
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
    
    
    /* Target Action */
    
    func toggleButtonTapped(sender: UIButton) {
        
        /*
        // Way 1
 
        // self.view.removeConstraints(self.constraints)
 
        // 本来これ書かないといけないっぽいのに、なくても動いてるんだけど。なんでや。↑のメソッドよくわからん...
        // self.constraints = []
        */
 
        // Way 2. ↑に比べ、こっちのほうが直感的ではある。ただ、constraintsに無限に要素が増えてくが...
        self.rootViewConstraints.forEach{  $0.isActive = false }
        self.greenViewConstraints.forEach{ $0.isActive = false }

        
        // まず、ステートを変えて...
        self.viewMode = ViewMode(rawValue: (self.viewMode.rawValue + 1) % 3)!
        
        print("現在のモード: \(viewMode)")
        
        // ほんで、緑と紫ビューの制約を更新
        self.yieldViewConstraint(viewColor: .green)
        self.yieldViewConstraint(viewColor: .purple, isPurpleView: true)
        
        
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

