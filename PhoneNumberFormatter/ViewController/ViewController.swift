//
//  ViewController.swift
//  PhoneNumberFormatter
//
//  Created by Mayank juyal on 07/03/18.
//  Copyright © 2018 abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewModel: ViewModel = {
        return ViewModel()
    }()
    
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    fileprivate var countryList = CountryListController()
    
    fileprivate var countryCode: String {
        return countryCodeTextField.text ?? ""
    }
    
    // MARK: - VIEW Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        initView()
        
    }
    
    //MARK: - INITIALISE View
    
    private func initView() {
        let locale = Locale.current
        let countryPhoneCode = viewModel.getCountryPhoneCode(locale.regionCode ?? "")
        let flag = viewModel.flag(country: locale.regionCode ?? "")
        
        flagLabel.text = flag
        countryCodeTextField.text = "+"+countryPhoneCode
    }
    
    //MARK: - Touch Method
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - TextField Delegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryCodeTextField {
            let navController = UINavigationController(rootViewController: countryList)
            self.present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        viewModel.textField(textField, shouldChangeCharactersIn: range, replacementString: string, countryCode: countryCode)
        
        return false
    }
}

// MARK: - ViewController Country List Delegate
extension ViewController: CountryListDelegate {
    func selectedCountry(country: Country) {
        flagLabel.text = country.flag
        countryCodeTextField.text = "+"+country.phoneExtension
    }
}
