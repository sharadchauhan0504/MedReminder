//
//  DashboardController.swift
//  MedReminder
//
//  Created by Sharad on 01/10/20.
//

import UIKit

class DashboardController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel! {
        didSet {
            scoreValueLabel.textColor = .warmPink
        }
    }
    @IBOutlet weak var takeMedicineButton: UIButton! {
        didSet {
            takeMedicineButton.accessibilityIdentifier = "controller--takeMedicineButton"
            takeMedicineButton.backgroundColor         = .warmPink
            takeMedicineButton.addCornerRadius(radius: 12.0)
        }
    }
    @IBOutlet weak var instructionLabel: UILabel!
    
    //MARK:- Private variables
    private let viewModel = DashboardViewModel()
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // accessibilityIdentifier for UI testing
        view.accessibilityIdentifier = "controller--DashboardController"
        
        askForNotificationPermissions()
        initialSetup()
        calculateTodayScore()
    }

    //MARK:- Private methods
    private func initialSetup() {
        if viewModel.isTimeForMedicine().0 {
            takeMedicineButton.isEnabled = true
            takeMedicineButton.alpha     = 1.0
        } else {
            takeMedicineButton.isEnabled = false
            takeMedicineButton.alpha     = 0.5
        }
    }
    
    private func calculateTodayScore() {
        scoreValueLabel.text = viewModel.getTodaysScore()
    }
    
    private func askForNotificationPermissions() {
        viewModel.askForNotificationPermission { [weak self] (granted) in
            guard let strongSelf = self else {return}
            if !granted {
                DispatchQueue.main.async {
                    strongSelf.showAlert(title: "Permission Required", message: "Notification permission is required to remind you about the medicine time", actionTitle: "Okay", completion: nil)
                }
            }
        }
    }
    
    //MARK:- Button action
    @IBAction func takeMedicineButtonAction(_ sender: UIButton) {
        sender.bounceEffect()
        guard let keyPath = viewModel.isTimeForMedicine().1 else {return}
        NotificationManager.shared.removeRecentNotification()
        CoreDataManager.sharedManager.insertMedicineInformation(Date().getConvertedDateString("yyyy-MM-dd"), keyPath)
    }
}
