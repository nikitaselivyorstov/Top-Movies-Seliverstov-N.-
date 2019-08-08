import UIKit

final class CornerRadiusButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 16
    }
}
