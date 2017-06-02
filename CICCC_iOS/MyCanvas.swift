
import UIKit

extension UIView {
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}



class MyCanvas: UIView {
    
    //  ペンの色
    var penColor: UIColor = .red
    
    //  ペンの太さ
    var penWidth: CGFloat = 3
    
    //  オフスクリーン保持用
    fileprivate var canvas: UIImage?
    
    //  画面表示用オフスクリーンへの描画
    override func draw(_ rect: CGRect) {
        self.canvas?.draw(at: CGPoint.zero)  //  担当画面左上から等倍で描画
    }
    
    //  線の到達点を受け取り、canvasを更新
    func canvasImage(_ newPt: CGPoint) {
        
        //  オフスクリーン描画用CGContext作成
        UIGraphicsBeginImageContextWithOptions(
            self.bounds.size,   //  CanvasView全体の矩形サイズを指定
            true,               //  不透明に設定
            1)                  //  Retina画面へ最適化はしない
        
        //  古いオフスクリーンを今のオフスクリーンに再現。
        self.canvas?.draw(at: CGPoint.zero)
        
        //  線を赤色にする
        self.penColor.setStroke()
        
        //  線を引く
        let context = UIGraphicsGetCurrentContext() // 設定されているCGContextを取り出す
        context?.setLineWidth(self.penWidth)       //  線の太さを指定する。
        context?.move(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
        context?.addLine(to: CGPoint(x: newPt.x, y: newPt.y))
        context?.strokePath()
        
        //  canvasの交換。
        self.canvas = UIGraphicsGetImageFromCurrentImageContext() //  オフスクリーンを画像として取り出し。
        UIGraphicsEndImageContext()
    }
    
    
    /*
    override func draw(_ rect: CGRect) {
        
        /*
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
        */
        
        
        /*
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.stroke()  // 直線が引かれる
        */
        
        
        /*
        // 三角形 -------------------------------------
        // UIBezierPath のインスタンス生成
        let line = UIBezierPath()
        // 起点
        line.move(to: CGPoint(x: 50, y: 60))
        // 帰着点
        line.addLine(to: CGPoint(x: 0, y: 300))
        line.addLine(to: CGPoint(x: 100, y: 280))
        // ラインを結ぶ
        line.close()
        // 色の設定
        UIColor.red.setStroke()
        // ライン幅
        line.lineWidth = 4
        // 描画
        line.stroke()
        */
        
        
        /*
        // 楕円 -------------------------------------
        let oval = UIBezierPath(ovalIn: CGRect(x: 140, y: 90, width: 90, height: 140))
        
        // 塗りつぶし色の設定
        UIColor.gray.setFill()
        // 内側の塗りつぶし
        oval.fill()
        
        // stroke 色の設定
        UIColor.green.setStroke()
        // ライン幅
        oval.lineWidth = 2
        // 描画
        oval.stroke()
        */
        
        
        /*
        // 矩形 -------------------------------------
        let rectangle = UIBezierPath(rect: CGRect(x: 200,y: 70,width: 120,height: 100))
        // stroke 色の設定
        UIColor.blue.setStroke()
        // ライン幅
        rectangle.lineWidth = 8
        // 描画
        rectangle.stroke()
        */
        
        
        /*
        let path = UIBezierPath()
        path.move(to: self.beginPoint)
        path.addLine(to: self.endPoint)
        
        paths.append(path)
 
        // path.stroke()  // 直線が引かれる
        
        paths.forEach{ $0.stroke() }
 
        */
    }
    */
    
    var currentPoint = CGPoint.zero

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            // Canvasをローカル座標系(bounds)としたときの座標がちゃんととれてる
            currentPoint = touch.location(in: self)
            print(currentPoint.x, currentPoint.y)
        }
        
        if (self.parentViewController() as! CanvasViewController).drawmodeSegmentControl.selectedSegmentIndex == 2 {
            addTextField()
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.parentViewController() as! CanvasViewController).drawmodeSegmentControl.selectedSegmentIndex == 2 {
            return
        }
        
        strokeLine(touches)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.parentViewController() as! CanvasViewController).drawmodeSegmentControl.selectedSegmentIndex == 2 {
            return
        }
        
        strokeLine(touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    // curtPtで示される現在の指位置から、touchesに設定されている指の位置まで、オフスクリーンに線を描く
    // そして画面に反映
    func strokeLine(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let newPt = touch.location(in: self)
            self.canvasImage(newPt)     //  オフスクリーンに線を描く
            self.setNeedsDisplay()      //  画面に反映させる
            self.currentPoint = newPt         //  現在の位置を更新
        }
    }
    
    /*
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        print("きたこれ")
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(changePenColor),
        name: ColorPallet.notificationName,
        object: nil
        )
    }
    */
    
    
    //　SBで生成されたUIViewは、 init(frame_)が呼ばれず、こっちだけが呼ばれる。注意。
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true  // キャンパスからはみ出したTFは表示させないようにする
    }

    
    func addTextField() {
        
        let textField = UITextField().apply {
            
            print("current point: ", currentPoint)
            
            $0.frame = CGRect(x: currentPoint.x, y: currentPoint.y, width: 120, height: 44)
            $0.backgroundColor = .white
            $0.textColor = .black
            $0.borderStyle = .roundedRect
            $0.becomeFirstResponder()  // 生成と同時にフォーカス(=いきなり編集開始)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        let validPoint: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) =
            (textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)
        
        // この行直前まではよい
        self.addSubview(textField)
        
        // ここからおかしい
        print("Frame", textField.frame.origin.x, textField.frame.origin.y)
        
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: validPoint.x).isActive = true
        textField.topAnchor.constraint(equalTo: self.topAnchor,         constant: validPoint.y).isActive = true
        
        
        textField.widthAnchor.constraint(equalToConstant: validPoint.width).isActive = true
        textField.heightAnchor.constraint(equalToConstant: validPoint.height).isActive = true
        textField.delegate = self.parentViewController() as! CanvasViewController
    }
}

