
import UIKit

extension UIAlertController {
    
    public convenience init(errorMessage: String?, title: String = "Error") {
        self.init(title: title, message: title, preferredStyle: .alert)
        self.addDismissButton()
    }
    
    /**
     Adds a button with, or without an action closure with the given title (default is Dismiss)
     
     - warning: the button's style is set to .default
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addDismissButton(title: String = "Dismiss") -> UIAlertController {
        return self.addButton(title: title, with: { _ in })
    }
    
    /**
     Add a button with a title, style, and action.
     
     - warning: style and action defaults to .default and an empty closure body
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addButton(title: String, style: UIAlertAction.Style = .default, with action: @escaping (UIAlertAction) -> () = {_ in}) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: style, handler: action))
        
        return self
    }
    
    /**
     Add a button with the style set to .cancel.
     
     the default action is an empty closure body
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addCancelButton(title: String = "Cancel", with action: @escaping (UIAlertAction) -> () = {_ in}) -> UIAlertController {
        return self.addButton(title: title, style: .cancel, with: action)
    }
    
    /**
     For the given viewController, present(..) invokes viewController.present(..)
     
     - warning: viewController.present(.., animiated: true, ..doc)
     
     - returns: Discardable UIAlertController
     */
    @discardableResult
    public func present(in viewController: UIViewController, completion: (() -> ())? = nil) -> UIAlertController {
        viewController.present(self, animated: true, completion: completion)
        
        return self
    }
    
    var inputField: UITextField {
        return self.textFields!.first!
    }
}
