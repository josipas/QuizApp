import UIKit

extension UIViewController {

    func configureGradient() {
        if (view.layer.sublayers ?? []).contains(where: { $0.name ==  "MasterGradientLayer" }) {
            return
        }

        let gradient = CAGradientLayer()
        gradient.name = "MasterGradientLayer"
        let startColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor
        let endColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor

        gradient.frame = view.bounds
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0.75, y: 0)
        gradient.endPoint = CGPoint(x: 0.25, y: 1)

        view.layer.insertSublayer(gradient, at: 0)
    }

}
