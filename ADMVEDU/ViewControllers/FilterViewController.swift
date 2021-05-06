//
//  FilterViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 6.05.21.
//

import UIKit

class FilterViewController: UIViewController {

    private var requestOptions = RequestOptions()

    private var countryPicker = UIPickerView()
    private var mediaPicker = UIPickerView()

    private var countryTextField = UITextField()
    private var mediaTextField = UITextField()
    
    private var explicitSwitch = UISwitch()
    private var tableView = UITableView()

    // Even id for pickers
    private var pickerIdentifier = 0
    // Odd id for text fields
    private var textFieldIdentifier = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePeakers()
        configureSwitch()

    }

    func configureSwitch() {
        let tag = getPickerIdentifier()
        let fieldWidth = CGFloat(300)
        let fieldHeith = CGFloat(40)
        let xPoint = view.center.x - fieldWidth/2
        let yPoint = 100 + 60 * CGFloat(tag)

        tableView.frame = CGRect(x: xPoint, y: yPoint, width: fieldWidth, height: fieldHeith)

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configurePeakers() {
        setUp(textField: countryTextField, named: "Country", with: countryPicker)
        setUp(textField: mediaTextField, named: "media type", with: mediaPicker)
    }

    func setUp(textField: UITextField, named: String, with pickerView: UIPickerView) {

        let tag = getPickerIdentifier()

        // Postion of TextField
        let fieldWidth = CGFloat(300)
        let fieldHeith = CGFloat(40)
        let xPoint = view.center.x - fieldWidth/2
        let yPoint = 100 + 60 * CGFloat(tag)

        textField.frame = CGRect(x: xPoint, y: yPoint, width: fieldWidth, height: fieldHeith)
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

    private func getPickerIdentifier() -> Int {
        pickerIdentifier += 1
        return pickerIdentifier
    }
    private func getTextIdentifier() -> Int {
        textFieldIdentifier += 1
        return textFieldIdentifier
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

        cell.textLabel?.text = "Only Explisit Tracks"
        cell.backgroundColor = .clear

        explicitSwitch.frame = .zero
        explicitSwitch.isOn = true
        explicitSwitch.addTarget(self, action: #selector(switchTriggered), for: .valueChanged );
        explicitSwitch.tag = getPickerIdentifier()

        cell.accessoryView = explicitSwitch

        return cell
    }
}
