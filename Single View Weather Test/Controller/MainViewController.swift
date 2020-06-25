//
//  ViewController.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 24/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var PressureLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeCityBttn(_ sender: Any) {
    }
    @IBAction func changeDegree(_ sender: Any) {
    }
    
}

