import UIKit

class CustomSwitchView: UIView {

    var customSwitch = UISwitch()
    private var switchLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        configureSwitch()
        configureLabel()
    }

    private func configureSwitch() {
        customSwitch.center.x = frame.maxX - customSwitch.frame.width / 2
        customSwitch.center.y = center.y
        customSwitch.isOn = true

        addSubview(customSwitch)
    }

    func setSwitchValue(_ isOn: Bool) {
        customSwitch.isOn = isOn
    }

    func addSwitchTarget(selector: Selector) {
        customSwitch.addTarget(self, action: selector, for: .valueChanged)
    }

    private func configureLabel() {
        switchLabel.frame = CGRect(x: frame.minX, y: .zero, width: 150, height: 40)
        switchLabel.center.y = center.y
        switchLabel.textColor = .black

        addSubview(switchLabel)
    }

    func setLabel(_ text: String) {
        switchLabel.text = text
    }
}
