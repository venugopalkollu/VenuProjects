//
//  ViewController.swift
//  DVIRform
//
//  Created by Lirctek on 29/05/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIScrollViewDelegate,DefectsTableView,AnotherDefectsTableView {
    
    @IBAction func getDataForDate(_ sender: Any) {
        dateSelected = "2017-05-26"

    }
    
    @IBAction func clearDataForAnotherDate(_ sender: Any) {
        dateSelected = "2017-06-28"

    }
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var dvirView: UIView!
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var vehicleButton: UIButton!
    @IBOutlet weak var signatureButton: UIButton!
    
    var elogDate:NSArray = []
    var isDataExistForTheDate:Bool =  false;
    var dateSelected:String = ""
    var view1:View1?
    var view2:View2?
    var view3:View3?
    var trailerValues:NSMutableArray = []
    var truckValues:NSMutableArray = []
    private var dvirItems:NSArray = []
    
    
    
    @IBAction func generalButtonClicked(_ sender: UIButton) {
        for tempView in self.dvirView.subviews{
            let view = tempView as UIView;
            view.removeFromSuperview();
        }
         view1  = View1.instanceFromNib() as? View1
        view1?.tag = 1
        self.dvirView.addSubview(view1!)
        
        self.view1?.completionHandler = {
            (selecetdValue) -> Void in
            self.saveDataFromView(selectedIndex: selecetdValue)
        }
        
    }
    
    @IBAction func vehicleButtonClicked(_ sender: Any) {
        for tempView in self.dvirView.subviews{
            let view = tempView as UIView;
            view.removeFromSuperview();
        }
         view2  = View2.instanceFromNib() as? View2
        view2?.setDelegates()
        view2?.truckDelegate = self as DefectsTableView;
        view2?.trailerDelegate = self as AnotherDefectsTableView;

        self.view2?.completionHandler = {
            (selecetdValue) -> Void in
            self.saveDataFromView(selectedIndex: selecetdValue)
        }

        view2?.tag = 2
        self.dvirView.addSubview(view2!)
    }
    @IBAction func signatureButtonClicked(_ sender: Any) {
        for tempView in self.dvirView.subviews{
            let view = tempView as UIView;
            view.removeFromSuperview();
        }
        view3  = View3.instanceFromNib() as? View3
        self.dvirView.addSubview(view3!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for tempView in self.dvirView.subviews{
            let view = tempView as UIView;
            view.removeFromSuperview();
        }
        let view1  = View1.instanceFromNib()
        self.dvirView.addSubview(view1)
        
    //    self.navigationController?.navigationBar.isTranslucent = false;

    }
    func showDefectesTableView(){
            let tableView = TruckDefectTableViewController()
        tableView.complertionHandler = {
            (valuesArray) -> Void in
            self.truckValues = valuesArray
            
            let separator = ","
            
            let formattedArray = (valuesArray.map{String(describing: $0)}).joined(separator: ",")
            self.view2?.txtAddRemoveTruckDefects.text = formattedArray
            
        }

        self.navigationController?.pushViewController(tableView, animated: true)
    }
    
    func showAnotherDefectsTableView() {
            let tableView = TrailerDefectTableViewController()
        tableView.complertionHandler = {
            (valuesArray) -> Void in
            self.trailerValues = valuesArray
            
            let separator = ","
            
            let formattedArray = (valuesArray.map{String(describing: $0)}).joined(separator: ",")
            self.view2?.txtAddRemoveTrailerDefects.text = formattedArray
            
        }
        //.instanceFromNib() as! TrailerDefectsTableView;
               self.navigationController?.pushViewController(tableView, animated: true)
                   }


    func saveDataFromView(selectedIndex:Int){
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        if(selectedIndex == 1){
            let view1Items = NSEntityDescription.insertNewObject(forEntityName: "Dvir", into: managedObjectContext) as! Dvir
            view1Items.carrier = view1?.txtCarrier.text
            view1Items.location = view1?.txtLocation.text
            view1Items.odometer = Int16((view1?.txtOdometer.text!)!)!
            
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            view1Items.setValue(date, forKey: "elogDate")
            view1Items.elogDate = date;
            do{
                try managedObjectContext.save()
                print ("Saved")
            }
            catch{
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            
        }
        else if(selectedIndex == 2){
            let view2Items = NSEntityDescription.insertNewObject(forEntityName: "Dvir", into: managedObjectContext) as! Dvir
            let view2TruckComments = NSEntityDescription.insertNewObject(forEntityName: "DvirTruckDefectMapping", into: managedObjectContext) as! DvirTruckDefectMapping
            let view2TrailerComments = NSEntityDescription.insertNewObject(forEntityName: "DvirTrailerDefectMapping", into: managedObjectContext) as! DvirTrailerDefectMapping
            let view2TruckItems = NSEntityDescription.insertNewObject(forEntityName: "TruckDefect", into: managedObjectContext) as! TruckDefect
            let  view2TrailerItems  = NSEntityDescription.insertNewObject(forEntityName: "TrailerDefects", into: managedObjectContext) as! TrailerDefect
            
            view2Items.truckNumber = view2?.txtTruckNumber.text
            view2Items.trailerNumber = view2?.txtTrailerNumber.text
//          view2TruckComments.comment = TruckDefectTableViewController?.txtcomments.text
            
            
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            view2Items.setValue(date, forKey: "elogDate")
            view2Items.elogDate = date;
            do{
                try managedObjectContext.save()
                print ("Saved")
            }
            catch{
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }

            
                   }
        else if(selectedIndex == 3){
            
        }
        
    }
    
    func getDataFromView(selectedIndex:Int, date:String) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if (selectedIndex == 1){
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dvir")
            do {
                fetchRequest.predicate = NSPredicate(format: "elogDate == %@",date as NSDate)
                dvirItems = try managedObjectContext.fetch(fetchRequest) as NSArray
                print("venu", dvirItems.count)
                
                if dvirItems.count > 0{
                    displayDataForTheDateSelected(selectedIndex: 1, dvirItems: dvirItems)
                }else{
                    isDataExistForTheDate = false;
                //    clearExistingDataWhenAnotherDateSelected(dvirItems: [])
                }
            }
            catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        else if (selectedIndex == 2){
            
        }
        else if (selectedIndex == 3){
            
        }
    }
    
    func displayDataForTheDateSelected(selectedIndex:Int, dvirItems:NSArray) {
        isDataExistForTheDate = true;
        if (selectedIndex == 1) {
            let obj1 = dvirItems.object(at: 0) as! Dvir
            view1?.txtCarrier.text = obj1.carrier;
            view1?.txtLocation.text = obj1.location;
            view1?.txtOdometer.text = String(obj1.odometer);

        }
        else if(selectedIndex == 2){
            
        }
        else if(selectedIndex == 3){
            
        }
        
        
    }
    func updateCoreDataValues(selectedIndex:Int){
        if (selectedIndex == 1 ){
            let obj1 = dvirItems.object(at: 0) as! Dvir
            obj1.carrier = view1?.txtCarrier.text
            obj1.location = view1?.txtLocation.text
            obj1.odometer = Int16((view1?.txtOdometer.text!)!)!
            do{
                try obj1.managedObjectContext?.save()
                print("chinna", dvirItems.count)
            }
                
            catch{
                print("Failed to retrieve record")
            }

            
        }
        else if(selectedIndex == 2){
            
        }
        else if(selectedIndex == 3){
            
        }
    }
    
    
    
    func dateFromString(date: String, format: String) -> NSDate {
        let formatter = DateFormatter()
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.locale = locale as Locale!
        formatter.dateFormat = format
        
        return formatter.date(from: date)! as NSDate    }
  
}


