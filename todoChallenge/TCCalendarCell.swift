//
//  TCCalendarCell.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import UIKit

class TCCalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("TCCalendarCell", owner: self, options: nil)
        self.contentView.addSubview(container)
    }
}
