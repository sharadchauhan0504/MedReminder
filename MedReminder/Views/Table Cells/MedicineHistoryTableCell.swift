//
//  MedicineHistoryTableCell.swift
//  MedReminder
//
//  Created by Sharad on 01/10/20.
//

import UIKit

class MedicineHistoryTableCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var backgrooundShadowView: UIView! {
        didSet {
            backgrooundShadowView.addShadow(radius: 4.0, height: 0.0, opacity: 0.4, shadowColor: .white)
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.addCornerRadius(radius: 12.0)
        }
    }
    @IBOutlet weak var morningCheckLabel: UILabel!
    @IBOutlet weak var afternoonCheckLabel: UILabel!
    @IBOutlet weak var eveningCheckLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.textColor = .warmPink
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK:- Property observer
    var history: MedicineHistory? = nil {
        didSet {
            setHistoryData()
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- Private methods
    private func setHistoryData() {
        guard let data = history else {return}
        
        var score = 0
        dateLabel.text = data.currentDate
        
        if let morningTime = data.morningTime {
            score += 30
            let time = morningTime.getConvertedDateString("HH:mm")
            morningCheckLabel.text = "Morning, at \(time)"
        } else {
            morningCheckLabel.text = "Morning"
            morningCheckLabel.textColor = .darkGray
        }
        
        if let afternoonTime = data.afternoonTime {
            score += 30
            let time = afternoonTime.getConvertedDateString("HH:mm")
            afternoonCheckLabel.text = "Afternoon, at \(time)"
        } else {
            afternoonCheckLabel.text = "Missed afternoon"
            afternoonCheckLabel.textColor = .darkGray
        }
        
        if let eveningTime = data.eveningTime {
            score += 40
            let time = eveningTime.getConvertedDateString("HH:mm")
            eveningCheckLabel.text = "Evening, at \(time)"
        } else {
            eveningCheckLabel.text = "Evening"
            eveningCheckLabel.textColor = .darkGray
        }
        
        scoreLabel.text = "\(score)"
    }
}
