import Look
import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let changeAlpha = UIView.change { (view) in
            view.alpha = 0.5
        }
        let changeColor = UIView.change { (view) in
            view.backgroundColor = UIColor.white
        }
        view.look + changeAlpha + changeColor
        print(view.alpha)
        print(view.backgroundColor)
    }
}
