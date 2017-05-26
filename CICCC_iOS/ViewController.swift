
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
    
    var orangeView1:  UIView!
    var orangeView2:  UIView!
    var redView:      UIView!
    var blueView1:    UIView!
    var blueView2:    UIView!
    var blueView3:    UIView!
    
    
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
        self.greenView.addSubview(self.purpleView)
        
        
        /* それ以外 */
        self.redView     = self.yieldView(color: .red)
        self.orangeView1 = self.yieldView(color: .orange)
        self.orangeView2 = self.yieldView(color: .orange)
        self.blueView1   = self.yieldView(color: .blue)
        self.blueView2   = self.yieldView(color: .blue)
        self.blueView3   = self.yieldView(color: .blue)
        
        self.greenView.addSubview(redView)
        self.greenView.addSubview(orangeView1) // ここ、赤より早くaddしてたから下に潜り込んでた。くそ...
        self.greenView.addSubview(orangeView2) // ここ、赤より早くaddしてたから下に潜り込んでた。くそ...
        self.greenView.addSubview(blueView1)
        self.greenView.addSubview(blueView2)
        self.greenView.addSubview(blueView3)
        
        
        // 3. トグルボタン定義 + addSubView
        self.toggleButton = yieldToggleButton()
        self.view.addSubview(self.toggleButton)
        
        
        self.views = [greenView, purpleView, redView, orangeView1, orangeView2,
                      blueView1, blueView2, blueView3]
        
        
        // 4. 制約を付加
        self.yieldViewConstraint(viewColor: .green)  // 緑ビュー
        self.yieldViewConstraint(viewColor: .purple, isPurpleView: true) // 紫ビュー
        
        self.yieldBlueConstraint()    // 青ビュー
        self.yieldRedConstraint()     // 赤ビュー
        self.yieldOrangeConstraint()  // オレンジビュー
        
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
    
    
    // 緑＆紫ビューの制約を産出
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
    
    
    var blueView1Top: NSLayoutConstraint!
    var blueView2Top: NSLayoutConstraint!
    var blueView3Top: NSLayoutConstraint!
    
    
    func yieldBlueConstraint() {
        
        // Blue1
        self.blueView1.widthAnchor.constraint(equalToConstant: 50).isActive = true  // 幅
        self.blueView1.heightAnchor.constraint(equalToConstant: 50).isActive = true  // 高さ
        self.blueView1.centerXAnchor.constraint(equalTo: self.greenView.centerXAnchor).isActive = true // X軸中央揃え
        
        // Blue2
        self.blueView2.widthAnchor.constraint(equalToConstant: 50).isActive = true  // 幅
        self.blueView2.heightAnchor.constraint(equalToConstant: 50).isActive = true  // 高さ
        self.blueView2.centerXAnchor.constraint(equalTo: self.greenView.centerXAnchor).isActive = true // X軸中央揃え
        
        // Blue3
        self.blueView3.widthAnchor.constraint(equalToConstant: 50).isActive = true  // 幅
        self.blueView3.heightAnchor.constraint(equalToConstant: 50).isActive = true // 高さ
        self.blueView3.centerXAnchor.constraint(equalTo: self.greenView.centerXAnchor).isActive = true // X軸中央揃え
        
        // Y軸マージン: ビューモードにより可変
        
        let margin: [(CGFloat, CGFloat)] = [(100,120), (25, 25), (60,65)]
        
        self.blueView1Top = self.blueView1.topAnchor.constraint(equalTo: self.greenView.topAnchor, constant: margin[viewMode.rawValue].0)
        self.blueView1Top.isActive = true
        
        self.blueView2Top = self.blueView2.topAnchor.constraint(equalTo: self.blueView1.bottomAnchor, constant: margin[viewMode.rawValue].1)
        self.blueView2Top.isActive = true
        
        self.blueView3Top = self.blueView3.topAnchor.constraint(equalTo: self.blueView2.bottomAnchor, constant: margin[viewMode.rawValue].1)
        self.blueView3Top.isActive = true
        
    }
    
    
    func yieldRedConstraint() {
    
        self.redView.topAnchor.constraint(equalTo: self.greenView.topAnchor, constant: 20).isActive = true
        self.redView.rightAnchor.constraint(equalTo: self.greenView.rightAnchor, constant: -20).isActive = true
        self.redView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.redView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    
    func yieldOrangeConstraint() {
        
        self.orangeView1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.orangeView1.widthAnchor.constraint(equalToConstant:  70).isActive = true
        
        self.orangeView2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.orangeView2.widthAnchor.constraint(equalToConstant:  50).isActive = true
        
        // X軸
        self.orangeView1.leadingAnchor.constraint(equalTo: self.redView.leadingAnchor, constant: 10).isActive = true
        self.orangeView2.leadingAnchor.constraint(equalTo: self.orangeView1.trailingAnchor, constant: 10).isActive = true

        
        // Y軸
        self.orangeView1.topAnchor.constraint(equalTo: self.redView.topAnchor, constant: 10).isActive = true
        self.orangeView2.topAnchor.constraint(equalTo: self.redView.topAnchor, constant: 10).isActive = true
        
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
        
        // ほんで、緑＆紫ビューの制約を更新
        self.yieldViewConstraint(viewColor: .green)
        self.yieldViewConstraint(viewColor: .purple, isPurpleView: true)
        
        // 青の更新
        let margin: [(CGFloat, CGFloat)] = [(100,120), (25, 25), (60,65)]
        
        blueView1Top.constant = margin[viewMode.rawValue].0
        blueView2Top.constant = margin[viewMode.rawValue].1
        blueView3Top.constant = margin[viewMode.rawValue].1
        
        /* 赤、オレンジはビューモードにより制約は変化しないため、何もせずに平気 */
        
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

