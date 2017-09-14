//
//  TCCalendarVC.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift

private let reuseIdentifier = "Cell"

class TCCalendarVC: UICollectionViewController {

    
    var calendar: ToDoCalendar = [:]
    var dates: [TCCalendarDay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(TCCalendarCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //setup gesture recognizer
        let backgroundView = UIView(frame: self.collectionView!.bounds)
        self.collectionView!.backgroundView = backgroundView
        let popOverTap = UITapGestureRecognizer(target: self, action: #selector(showPopOver(_:)))
        self.collectionView!.backgroundView?.addGestureRecognizer(popOverTap)
        popOverTap.numberOfTapsRequired = 2
        
        let getNew = NSNotification.Name(rawValue: "GetNewData")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadWithNewData), name: getNew, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendar = RealmQuery.toDosByDate(filter: nil, forCalendar: .due)
        sortOutDates()
        self.collectionView?.reloadData()
    }
    
    

    func showPopOver(_ sender: UITapGestureRecognizer) {
        //create popover at location where touch occurred (this is a bit inaccurate)
        let point = sender.location(in: sender.view)
        let frame = CGRect(origin: point, size: CGSize(width: 10, height: 10))
        //use choice to segue into create or filter todo view
        FTPopOverMenu.showFromSenderFrame(senderFrame: frame, with: ["New ToDo","Filter ToDos"], done: {option in
            switch option {
            case 0:
                self.performSegue(withIdentifier: "createSegue", sender: nil)
            case 1:
                self.performSegue(withIdentifier: "filterSegue", sender: nil)
            default:
                break
            }
        }, cancel: {})
    }
    
    //this gets data from the filter and new todo VCs
    func reloadWithNewData(notification: Notification) {
        var filter: ToDoFilter? = nil
        if let userInfo = notification.userInfo{
            filter = userInfo["filter"] as? ToDoFilter
        }
        
        calendar = RealmQuery.toDosByDate(filter: filter, forCalendar: .due)
        sortOutDates()
        collectionView?.reloadData()
    }
    
    func sortOutDates() {
        //this will extract dates from the dictionary keys then sort by date
        dates = calendar.keys.sorted(by: {dateTuple in
            return dateTuple.0.date < dateTuple.1.date
        })
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dateSegue",
            let destination = segue.destination as? TCToDoListVC,
            let date = sender as? TCCalendarDay,
            let toDos = calendar[date]{
            destination.notes = toDos
        }
    }
 
}

extension TCCalendarVC {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if dates.isEmpty { return 1 }
        return dates.count
    }

    // uses the dates index to determine number of items and dequeue because it is ordered
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TCCalendarCell
        if calendar.isEmpty {
            cell.monthLabel.text = "double"
            cell.dayLabel.text = "tap"
            cell.weekdayLabel.text = "outside"
            return cell
        }
        let myDate = dates[indexPath.item]
        cell.dayLabel.text = myDate.day
        cell.monthLabel.text = myDate.month
        cell.weekdayLabel.text = myDate.weekday
        cell.notesLabel.text = "\(calendar[myDate]?.count ?? 0) 📌"
        return cell
    }
    
}

extension TCCalendarVC {
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dates = Array(calendar.keys)
        let myDate = dates[indexPath.item]
        performSegue(withIdentifier: "dateSegue", sender: myDate)
    }

}
