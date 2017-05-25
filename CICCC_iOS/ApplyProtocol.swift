
import UIKit

protocol ApplyProtocol {}

extension ApplyProtocol {
    func apply(closure: (_ this: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: ApplyProtocol {}
