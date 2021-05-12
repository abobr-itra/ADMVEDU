//
//  FilterViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 6.05.21.
//

import UIKit

class FilterViewController: UIViewController {

    var requestOptions = RequestOptions()

    private var countryPicker = UIPickerView()
    private var mediaPicker = UIPickerView()

    private var countryTextField = UITextField()
    private var mediaTextField = UITextField()

    private var explicitSwitch = UISwitch()
    private var limitSlider = UISlider()
    let sliderLable = UILabel()
    private var tableView = UITableView()

    private var uniqueIdentifier = 0

    weak var delegate: OptionsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePeakers()
        configureSwitch()
        configureSlider()
        configureNavController()
        setOptions()
    }

    func setOptions() {
        let country = requestOptions.country
        let media = requestOptions.media
        let limit = requestOptions.limit
        let expl = requestOptions.explisit

        var items = Country.allCases.map { $0.rawValue }
        if let index = items.firstIndex(of: country) {
            countryPicker.selectRow(index, inComponent: 0, animated: false)
            countryTextField.text = getCountryName(countryCode: country)
        }

        items = MediaType.allCases.map { $0.rawValue }
        if let index = items.firstIndex(of: country) {
            mediaPicker.selectRow(index, inComponent: 0, animated: false)
            mediaTextField.text = media.rawValue
        }

        explicitSwitch.isOn = (expl == .yes)

        limitSlider.value = Float(limit)
        sliderLable.text = String(Int(limitSlider.value))
    }

    func configureNavController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(applyOptions))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self, action: #selector(cancelOptions))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc
    func applyOptions() {
        navigationController?.popViewController(animated: true)
        delegate?.setOptions(with: requestOptions)
        dismiss(animated: true, completion: nil)
    }

    @objc
    func cancelOptions() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    func configureSlider() {
        let tag = getUniqueIdentifier()
        limitSlider.frame = calcFrame(by: tag)
        limitSlider.minimumValue = 0
        limitSlider.maximumValue = 200
        limitSlider.value = 50
        self.view.addSubview(limitSlider)

        limitSlider.addTarget(self, action: #selector(changeSliderLable), for: .valueChanged)

        sliderLable.frame = CGRect(x: Int(view.center.x) - 150,
                                   y: 120 + 60 * tag,
                                   width: 300, height: 40)
        sliderLable.textAlignment = .center
        sliderLable.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(sliderLable)
    }

    @objc
    func changeSliderLable() {
        let sliderValue = Int(limitSlider.value)
        sliderLable.text = String(sliderValue)
        requestOptions.limit = sliderValue
    }

    func configureSwitch() {
        let tag = getUniqueIdentifier()
        tableView.frame = calcFrame(by: tag)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configurePeakers() {
        setUp(textField: countryTextField, named: "Country", with: countryPicker)
        setUp(textField: mediaTextField, named: "media type", with: mediaPicker)
    }

    func setUp(textField: UITextField, named: String, with pickerView: UIPickerView) {
        let tag = getUniqueIdentifier()
        textField.frame = calcFrame(by: tag)
        textField.placeholder = "Choose \(named)"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self

        textField.inputView = pickerView
        textField.textAlignment = .center

        self.view.addSubview(textField)

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = tag
    }

    func getCountryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_us")
        return current.localizedString(forRegionCode: countryCode)
    }

    func calcFrame(by tag: Int) -> CGRect {

        let elementWidth = CGFloat(300)
        let elementHeith = CGFloat(40)
        let xPoint = view.center.x - elementWidth/2
        let yPoint = 100 + 60 * CGFloat(tag)
        return CGRect(x: xPoint, y: yPoint, width: elementWidth, height: elementHeith)
    }

    private func getUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }

    @objc
    func switchTriggered(sender: AnyObject) {
        if requestOptions.explisit == .yes {
            requestOptions.explisit = .no
        } else {
            requestOptions.explisit = .yes
        }
    }
}

extension FilterViewController: UITextFieldDelegate {

}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case countryPicker.tag:
            return Country.allCases.count
        case mediaPicker.tag:
            return MediaType.allCases.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case countryPicker.tag:
            let items = Country.allCases.map { $0.rawValue }
            return getCountryName(countryCode: items[row])
        case mediaPicker.tag:
            let items = MediaType.allCases.map { $0.rawValue }
            return items[row]
        default:
            return "Not Found"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case countryPicker.tag:
            let items = Country.allCases.map { $0.rawValue }
            countryTextField.text = getCountryName(countryCode: items[row])
            countryTextField.resignFirstResponder()
            requestOptions.country = items[row]
        case mediaPicker.tag:
            let items = MediaType.allCases.map { $0.rawValue }
            mediaTextField.text = items[row]
            mediaTextField.resignFirstResponder()
            requestOptions.media = MediaType.allCases[row]

        default:
            return
        }
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")

        cell.textLabel?.text = "Allow Explisit Tracks"
        cell.backgroundColor = .clear

        explicitSwitch.frame = .zero
        explicitSwitch.addTarget(self, action: #selector(switchTriggered),
                                 for: .valueChanged)
        explicitSwitch.tag = getUniqueIdentifier()

        cell.accessoryView = explicitSwitch

        return cell
    }
}
