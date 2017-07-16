import Look
import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.states.forEach({ view.look.prepare(state: $0, change: Style.background(state: $0)) })
        view.look.state = UIView.State.initial.rawValue
    }
}

fileprivate extension UIView {
    
    enum State: String {
        
        case banned = "banned"
        case disabled = "disabled"
        case enabled = "enabled"
        case initial = "initial"
    }
    
    static var states: [UIView.State] {
        return [UIView.State.banned, .disabled, .enabled, .initial]
    }
}

fileprivate struct Style {
    
    static func background(state: UIView.State) -> Change<UIView> {
        return UIView.change(closure: { [state] (view) in
            view.layer.borderWidth = 1.0
            switch state  {
            case .banned:
                view.backgroundColor = UIColor.gray
                view.layer.borderColor = UIColor.red.cgColor
            case .disabled:
                view.backgroundColor = UIColor.gray
                view.layer.borderColor = UIColor.black.cgColor
            case .enabled:
                view.backgroundColor = UIColor.white
                view.layer.borderColor = UIColor.white.cgColor
            case .initial:
                view.backgroundColor = UIColor.lightGray
                view.layer.borderColor = UIColor.lightGray.cgColor
            }
        })
    }
}
