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
    private var sliderLable = UILabel()
    private var tableView = UITableView()

    private var uniqueIdentifier = 0
    private let pickerViewComponents = 1
    private let tableViewElements = 1

    weak var delegate: HomeViewControllerOptionsDelegate?

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
        configureUI()
    }

    private func configureUI() {
        configurePickers()
        configureTableView()
        configureSwitch()
        configureSlider()
    }

    private func setStackViewConstraints() {
        let yIndent = (view.frame.maxY - 450) / 2
        let xIndent = CGFloat(40)
        stackView.setConstraints(xIndent: xIndent, yIndent: yIndent, to: view)
    }

    private func setOptions() {
        let country = requestOptions.country
        let media = requestOptions.media
        let limit = requestOptions.limit
        let expl = requestOptions.explisit

        setPicker(mediaPicker, ofType: MediaType.self, textField: mediaTextField, to: media)
        setPicker(countryPicker, ofType: Country.self, textField: countryTextField, to: country)

        explicitSwitch.isOn = expl == .yes
        limitSlider.value = Float(limit)
        sliderLable.text = String(Int(limitSlider.value))
    }

    private func setPicker<T: GenericPickerProtocol>(_ picker: UIPickerView,
                                                     ofType type: T.Type,
                                                     textField: UITextField,
                                                     to value: T) {
        let items = T.allCases.map { $0.description }
        if let index = items.firstIndex(of: value.description) {
            picker.selectRow(index, inComponent: .zero, animated: false)
            textField.text = value.description
        }
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
    private func applyOptions() {
        navigationController?.popViewController(animated: true)
        delegate?.setOptions(requestOptions)
        dismiss(animated: true, completion: nil)
    }

    @objc
    private func cancelOptions() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    private func configureSlider() {

        let limitMaxValue = Float(200)
        let limitMinValue = Float(0)
        let limitDefaultValue = Float(50)

        limitSlider.minimumValue = limitMinValue
        limitSlider.maximumValue = limitMaxValue
        limitSlider.value = limitDefaultValue
        stackView.addArrangedSubview(limitSlider)

        limitSlider.addTarget(self, action: #selector(changeSliderLable), for: .valueChanged)

        configureSliderLabel()
    }

    private func configureSliderLabel() {
        sliderLable.textAlignment = .center
        sliderLable.font = UIFont.smallFont
        stackView.addArrangedSubview(sliderLable)
    }

    @objc
    private func changeSliderLable() {
        let sliderValue = Int(limitSlider.value)
        sliderLable.text = String(sliderValue)
        requestOptions.limit = sliderValue
    }

    private func configureTableView() {
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        setTableViewDelegates()
    }

    // MARK: Make this more flexible
    private func configureSwitch() {
        explicitSwitch.frame = .zero
        explicitSwitch.addTarget(self, action: #selector(switchTriggered), for: .valueChanged)
        stackView.addArrangedSubview(tableView)
    }

    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configurePickers() {
        setUp(textField: countryTextField,
              name: "Country",
              with: countryPicker)
        setUp(textField: mediaTextField,
              name: "media type",
              with: mediaPicker)
    }

    private func setUp(textField: UITextField, name: String, with pickerView: UIPickerView) {
        let tag = getUniqueIdentifier()
        textField.placeholder = "Choose \(name)"
        textField.font = UIFont.smallFont
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView
        textField.textAlignment = .center
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = tag
        stackView.addArrangedSubview(textField)
    }

    private func getUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }

    @objc
    private func switchTriggered(sender: AnyObject) {
        if requestOptions.explisit == .yes {
            requestOptions.explisit = .no
        } else {
            requestOptions.explisit = .yes
        }
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewComponents
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setPickerNumebreOfRows(pickerView)
    }
    
    private func setPickerNumebreOfRows(_ pickerView: UIPickerView) -> Int {
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
        return configureTitles(of: pickerView, at: row)
    }

    private func configureTitles(of pickerView: UIPickerView, at row: Int) -> String {
        switch pickerView.tag {
        case countryPicker.tag:
            return setTitleForRow(row, type: Country.self)
        case mediaPicker.tag:
            return setTitleForRow(row, type: MediaType.self)
        default:
            return "Not Found"
        }
    }

    private func setTitleForRow<T: GenericPickerProtocol>(_ row: Int, type: T.Type) -> String {
        let items = T.allCases.map { $0.description }
        return items[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        configureRow(of: pickerView, at: row)
    }

    private func configureRow(of pickerView: UIPickerView, at row: Int) {
        switch pickerView.tag {
        case countryPicker.tag:
            selectRow(row, ofType: Country.self, on: countryTextField)
            requestOptions.country = Country.allCases[row]
        case mediaPicker.tag:
            selectRow(row, ofType: MediaType.self, on: mediaTextField)
            requestOptions.media = MediaType.allCases[row]
        default:
            return
        }
    }

    private func selectRow<T: GenericPickerProtocol>(_ row: Int, ofType type: T.Type, on textField: UITextField) {
        let items = T.allCases.map { $0.description }
        textField.text = items[row]
        textField.resignFirstResponder()
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewElements
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")

        cell.textLabel?.text = "Allow Explisit Tracks"
        cell.backgroundColor = .clear
        cell.accessoryView = explicitSwitch
        return cell
    }
}
