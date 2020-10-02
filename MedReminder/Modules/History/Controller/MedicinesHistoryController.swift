//
//  MedicinesHistoryController.swift
//  MedReminder
//
//  Created by Sharad on 01/10/20.
//

import UIKit

class MedicinesHistoryController: UIViewController {
    
    //MARK:- IBoutlets
    @IBOutlet weak var medicineHistoryTableView: UITableView! {
        didSet {
            medicineHistoryTableView.accessibilityIdentifier = "controller--medicineHistoryTableView"
            medicineHistoryTableView.registerNib(type: MedicineHistoryTableCell.self)
        }
    }
    
    //MARK:- Private variables
    private var animatedIndexPaths = [IndexPath]()
    private var medicineHistory = [MedicineHistory]()
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // accessibilityIdentifier for UI testing
        view.accessibilityIdentifier = "controller--MedicinesHistoryController"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let history = CoreDataManager.sharedManager.fetchMedicineHistory() else {return}
        medicineHistory = history
        medicineHistoryTableView.reloadData()
    }
}

//MARK:- Extensions
extension MedicinesHistoryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        cell.bounceEffect()
    }
}

extension MedicinesHistoryController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineHistoryTableCell", for: indexPath) as! MedicineHistoryTableCell
        cell.history = medicineHistory[indexPath.row]
        return cell
    }
}
