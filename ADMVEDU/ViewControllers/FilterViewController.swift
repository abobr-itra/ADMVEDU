import UIKit

class FilterViewController: UIViewController {
	var requestOptions = RequestOptions()
	private var stackView = UIStackView()
	private var countryPicker = UIPickerView()
	private var mediaPicker = UIPickerView()

	private var countryTextField = UITextField()
	private var mediaTextField = UITextField()

    private var switchView = CustomSwitchView()
    private var sliderView = CustomSliderView()

	private var uniqueIdentifier = 0

	private struct Constants {
		let pickerViewComponents = 1

		let limitMaxValue = Float(200)
		let limitMinValue = Float(0)
		let limitDefaultValue = Float(50)
	}

	private let constants = Constants()

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
        configureSwitchView()
		configureSlider()
	}

    private func configureSwitchView() {
        stackView.layoutIfNeeded()
        let switchHeight = CGFloat(45)
        switchView.frame = CGRect(x: stackView.bounds.minX,
                                  y: stackView.bounds.minY,
                                  width: stackView.frame.width,
                                  height: switchHeight)
        switchView.configureView()
        switchView.setLabel("Allow explisit tracks")
        switchView.customSwitch.addTarget(self, action: #selector(switchTriggered), for: .valueChanged)
        stackView.addArrangedSubview(switchView)
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

        switchView.setSwitchValue(expl == .yes)
        sliderView.setSliderValue(Float(limit))
	}

	private func setPicker<T: GenericPickerProtocol>(_ picker: UIPickerView,
	                                                 ofType _: T.Type,
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
        requestOptions.limit = sliderView.getSliderValue()
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
        let sliderHeight = CGFloat(80)
        sliderView.frame = CGRect(x: stackView.bounds.minX,
                                  y: stackView.bounds.minY,
                                  width: stackView.frame.width,
                                  height: sliderHeight)
        sliderView.configureView(maxValue: constants.limitMaxValue,
                                 minValue: constants.limitMinValue,
                                 defaultValue: constants.limitDefaultValue)
        stackView.addArrangedSubview(sliderView)

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
	 func switchTriggered() {
		if requestOptions.explisit == .yes {
			requestOptions.explisit = .no
		} else {
			requestOptions.explisit = .yes
		}
	}
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in _: UIPickerView) -> Int {
		return constants.pickerViewComponents
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
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

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
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

	private func setTitleForRow<T: GenericPickerProtocol>(_ row: Int, type _: T.Type) -> String {
		let items = T.allCases.map { $0.description }
		return items[row]
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
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

	private func selectRow<T: GenericPickerProtocol>(_ row: Int, ofType _: T.Type, on textField: UITextField) {
		let items = T.allCases.map { $0.description }
		textField.text = items[row]
		textField.resignFirstResponder()
	}
}
