
import UIKit

class ColorPallet: UIView {

    var isSelected = false
    
    static let notificationName = Notification.Name("ColorChanged")
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        post()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    func post() {
        NotificationCenter.default.post(name: ColorPallet.notificationName, object: self, userInfo: ["sender": self])
    }
    
    func addBorderWidth() {
        if self.isSelected {
            self.layer.borderWidth = 3
        } else {
            self.layer.borderWidth = 0
        }
    }
    
    

}
