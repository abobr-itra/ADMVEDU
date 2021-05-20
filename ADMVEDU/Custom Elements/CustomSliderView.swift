//
//  CustomSliderView.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 18.05.21.
//

import UIKit

class CustomSliderView: UIView {

    private var slider = UISlider()
    private var sliderLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView(maxValue: Float, minValue: Float, defaultValue: Float) {
        configureSlider(maxValue: maxValue, minValue: minValue, defaultValue: defaultValue)
        configureLabel()
    }

    private func configureSlider(maxValue: Float, minValue: Float, defaultValue: Float) {
        slider.maximumValue = maxValue
        slider.minimumValue = minValue
        slider.value = defaultValue
        slider.frame = CGRect(x: .zero, y: frame.midY - 10, width: frame.width, height: 5)
        slider.center.x = center.x

        slider.addTarget(self, action: #selector(changeSliderLable), for: .valueChanged)
        addSubview(slider)
    }

    private func configureLabel() {
        sliderLabel.textAlignment = .center
        sliderLabel.font = UIFont.smallFont
        sliderLabel.textColor = .black
        sliderLabel.frame = CGRect(x: frame.midX, y: frame.midY, width: 150, height: 20)
        sliderLabel.center.x = center.x

        addSubview(sliderLabel)
    }

    func getSliderValue() -> Int {
        return Int(slider.value)
    }

    func setSliderValue(_ value: Float) {
        slider.value = value
        sliderLabel.text = String(Int(value))
    }

    @objc
    private func changeSliderLable() {
        let sliderValue = Int(slider.value)
        sliderLabel.text = String(sliderValue)
    }
}
