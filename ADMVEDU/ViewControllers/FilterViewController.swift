//
//  FilterViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 6.05.21.
//

import UIKit

class FilterViewController: UIViewController {

    var requestOptions = RequestOptions()
    private var stackView = UIStackView()
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
        configureStackView()
        configureNavigationController()
        setOptions()
    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        setStackViewConstraints()
        configurePeakers()
        configureSwitch()
        configureSlider()

    }

    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 120).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -350).isActive = true
    }

    private func setOptions() {
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

        if let index = items.firstIndex(of: media.rawValue) {
            mediaPicker.selectRow(index, inComponent: 0, animated: false)
            mediaTextField.text = media.rawValue
        }

        explicitSwitch.isOn = (expl == .yes)
        limitSlider.value = Float(limit)
        sliderLable.text = String(Int(limitSlider.value))
    }

    private func configureNavigationController() {
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
        delegate?.setOptions(requestOptions)
        dismiss(animated: true, completion: nil)
    }

    @objc
    func cancelOptions() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    private func configureSlider() {
        limitSlider.minimumValue = 0
        limitSlider.maximumValue = 200
        limitSlider.value = 50
        stackView.addArrangedSubview(limitSlider)

        limitSlider.addTarget(self, action: #selector(changeSliderLable), for: .valueChanged)

        sliderLable.textAlignment = .center
        sliderLable.font = UIFont.smallFont
        stackView.addArrangedSubview(sliderLable)
    }

    @objc
    func changeSliderLable() {
        let sliderValue = Int(limitSlider.value)
        sliderLable.text = String(sliderValue)
        requestOptions.limit = sliderValue
    }

    private func configureSwitch() {
        stackView.addArrangedSubview(tableView)
        setTableViewDelegates()
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configurePeakers() {
        setUp(textField: countryTextField,
              named: "Country",
              with: countryPicker)
        setUp(textField: mediaTextField,
              named: "media type",
              with: mediaPicker)
    }

    private func setUp(textField: UITextField, named: String, with pickerView: UIPickerView) {
        let tag = getUniqueIdentifier()
        textField.placeholder = "Choose \(named)"
        textField.font = UIFont.smallFont
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.inputView = pickerView
        textField.textAlignment = .center
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = tag
        stackView.addArrangedSubview(textField)
    }

    private func getCountryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_us")
        return current.localizedString(forRegionCode: countryCode)
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
        explicitSwitch.addTarget(self, action: #selector(switchTriggered), for: .valueChanged)
        cell.accessoryView = explicitSwitch
        return cell
    }
}
