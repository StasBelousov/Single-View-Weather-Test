//
//  ViewController.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 24/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var changeDegreeLabel: UISegmentedControl!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mainInfoStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var networkManager = NetworkManager()
    lazy var locationManager:CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyKilometer
        location.requestWhenInUseAuthorization()
        return location
    }()
    var currentCity: CurrentWeather?
    
    var city: String? {
        get { return currentCityLabel.text}
        set { currentCityLabel.text = newValue }
    }
    var temperature:String? {
        get { return weatherTemp.text }
        set { weatherTemp.text = newValue }
    }
    var weatherDesc: String? {
        get { weatherDescription.text }
        set { weatherDescription.text = newValue }
    }
    var celsiumAndFarengeight: [String] = ["0","0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        CLLocationManager.locationServicesEnabled()
        locationManager.requestLocation()
        setupCityScreen()
        setTopStackViewElements()
        cityTextField.delegate = self
        hideKeyboard()
        
    }
    
    @IBAction func changeCityBttn(_ sender: Any) {
        cityTextField.becomeFirstResponder()
    }
    @IBAction func changeDegree(_ sender: Any) {
        let segmentIndex = changeDegreeLabel.selectedSegmentIndex
        weatherTemp.text = celsiumAndFarengeight[segmentIndex]
    }
    @IBAction func changeCityTextField(_ sender: Any) {
        guard let city = cityTextField.text else { return }
        
        if city.count != 0 {
            networkManager.fetchCurrentWeather(forRequestType:.cityName(city: city), language: "ru")
            cityTextField.text = ""
        }
    }
    
    func setupCityScreen () {
        if currentCity != nil {
            activityIndicator.isHidden = true
            currentCityLabel.text = currentCity?.cityName
            weatherTemp.text = currentCity?.temperatureString
            weatherDescription.text = currentCity?.description
        } else {
            locationManager.requestLocation()
            mainInfoStackView.isHidden = true
            windLabel.text = "-"
            humidityLabel.text = "-"
            pressureLabel.text = "-"
            rainLabel.text = "-"
            currentCityLabel.text = "-"
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }
    func setTopStackViewElements() {
        //Text Field
        cityTextField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "paperplane")
        imageView.image = image
        imageView.tintColor = UIColor.lightGray
        cityTextField.leftView = imageView
        
        //Segmented Control
        changeDegreeLabel.layer.cornerRadius = 5.0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        changeDegreeLabel.setTitleTextAttributes(titleTextAttributes, for: .normal)
        changeDegreeLabel.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cityTextField {self.cityTextField.resignFirstResponder()
        }
        return true
    }
}
extension MainViewController: NetworkManagerDelegate {
    func updateInteface(_: NetworkManager, with currentWeather: CurrentWeather) {
        print(currentWeather)
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            updateTopStackView()
            updateMainStackView()
            updateBottomStackView()
        }
        
        func updateTopStackView() {
            self.city = currentWeather.cityName
        }
        
        func updateMainStackView() {
            self.temperature = currentWeather.temperatureString
            self.weatherDesc = currentWeather.description
            self.weatherImage.image = UIImage(systemName:currentWeather.systemIconNameString)
            self.mainInfoStackView.isHidden = false
            celsiumAndFarengeight.insert(currentWeather.temperatureString, at: 0)
            celsiumAndFarengeight.insert(currentWeather.temperatureFahrenheitString, at: 1)
            changeDegreeLabel.selectedSegmentIndex = 0
        }
        func updateBottomStackView() {
            self.windLabel.text = currentWeather.windSpeedString + currentWeather.windDegreeString
            self.humidityLabel.text = currentWeather.humidityString
            self.pressureLabel.text = currentWeather.pressureHgString
            self.rainLabel.text = "0%"
        }
    }
    func updateRain(_: NetworkManager, with currentWeatherRain: CurrentWeatherRain) {
        print(currentWeatherRain)
        
        DispatchQueue.main.async {
            self.rainLabel.text = currentWeatherRain.rainString
        }
    }
}
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude), language: "ru")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
extension UIViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

