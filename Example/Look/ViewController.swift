import Look
import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let change = UIView.change { (view) in
//            view.alpha = 0.5
//            view.backgroundColor = UIColor.white
//        }
//        let view = UIView()
//        change(view)
        
        let changeAlpha = UIView.change { (view) in
            view.alpha = 0.5
        }
        let changeColor = UIView.change { (view) in
            view.backgroundColor = UIColor.white
        }
        let change = changeAlpha + changeColor
//        let change2 = UIView.change { (view) in
//            view.alpha = 0.5
//            view.backgroundColor = UIColor.orange
//        }
//        change1(view)
//        change2(view)
    }
}
