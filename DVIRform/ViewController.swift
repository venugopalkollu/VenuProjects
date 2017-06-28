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
       getDataFromView(selectedIndex: 1, date:"2017-05-26")
        getDataFromView(selectedIndex: 2, date:"2017-05-26")
 
       
        
    }
    
    @IBAction func clearDataForAnotherDate(_ sender: Any) {
        dateSelected = "2017-06-28"
        getDataFromView(selectedIndex:1, date:"2017-06-28")
        getDataFromView(selectedIndex:2, date:"2017-06-28")


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
    
    var truckValuesDict = NSMutableDictionary()
    var truckCommentsDict = NSMutableDictionary()
    
    var trailerValuesDict = NSMutableDictionary()
    var trailerCommentsDict = NSMutableDictionary()
    
    var dvirIdDict = NSMutableDictionary()
    var managedObjectContext:NSManagedObjectContext?
    private var dvirItems:NSArray = []
    
    
    
    @IBAction func generalButtonClicked(_ sender: UIButton) {
        loadView1()
        
    }
    
    
    func loadView1(){
        for tempView in self.dvirView.subviews{
            let view = tempView as UIView;
            view.removeFromSuperview();
        }
        
        view1  = View1.instanceFromNib() as? View1
        view1?.tag = 1
        self.view1?.completionHandler = {
            (selecetdValue) -> Void in
            self.saveDataFromView(selectedIndex: selecetdValue)
        }
        self.dvirView.addSubview(view1!)
        
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
        view2?.tag = 2
        
        self.view2?.completionHandler = {
            (selecetdValue) -> Void in
            self.saveDataFromView(selectedIndex: selecetdValue)
        }
        
        self.dvirView.addSubview(view2!)
    }
    @IBAction func signatureButtonClicked(_ sender: Any) {
        for tempView in self.dvirView.subviews{
            let view = tempView as UIView;
            view.removeFromSuperview();
        }
        view3  = View3.instanceFromNib() as? View3
        view3?.tag = 3
        self.view3?.completionHandler = {
            (selecetdValue) -> Void in
            self.saveDataFromView(selectedIndex: selecetdValue)
        }
        
        self.dvirView.addSubview(view3!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        loadView1()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        registerKeyboardNotifications()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true;
        
    }
    
    
    
    func showDefectesTableView(){
        let tableView = TruckDefectTableViewController()
        tableView.complertionHandler = {
            (valuesDict,comments) -> Void in
            self.truckValuesDict = valuesDict
            self.truckCommentsDict = comments
            let values = valuesDict.allValues
            
            let separator = ","
            
            let formattedArray = (values.map{String(describing: $0)}).joined(separator: ",")
            self.view2?.txtAddRemoveTruckDefects.text = formattedArray
            
        }
        
        self.navigationController?.pushViewController(tableView, animated: true)
    }
    
    func showAnotherDefectsTableView() {
        let tableView = TrailerDefectTableViewController()
        tableView.complertionHandler = {
            (valuesDict,comments) -> Void in
            self.trailerValuesDict = valuesDict
            self.trailerCommentsDict = comments
            let values = valuesDict.allValues
            
            let separator = ","
            
            let formattedArray = (values.map{String(describing: $0)}).joined(separator: ",")
            self.view2?.txtAddRemoveTrailerDefects.text = formattedArray
            
        }
        self.navigationController?.pushViewController(tableView, animated: true)
    }
    
    // Save Data
    
    func saveDataFromView(selectedIndex:Int){
        
        var dvir =   checkDataExistForTheDate()
        
        if let dvir = dvir{
            
        }else{
            dvir = NSEntityDescription.insertNewObject(forEntityName: "Dvir", into: managedObjectContext!) as! Dvir
        }
        
        
        
        if(selectedIndex == 1){
            
            
            dvir?.carrier = view1?.txtCarrier.text
            dvir?.location = view1?.txtLocation.text
            dvir?.odometer = Int16((view1?.txtOdometer.text!)!)!
            
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            dvir?.setValue(date, forKey: "elogDate")
            dvir?.elogDate = date;
            
            
            
            
            let keys = self.dvirIdDict.allKeys
            for tempKey in keys{
                let dvir = NSEntityDescription.insertNewObject(forEntityName: "Dvir", into: managedObjectContext!) as! Dvir
                
                let value = self.dvirIdDict.object(forKey: tempKey);
                
                dvir.id = Int16(tempKey as! Int)
                dvir.elogDate = value as! Date as NSDate
                
                let truckComments = NSEntityDescription.insertNewObject(forEntityName: "DvirTruckDefectMapping", into: managedObjectContext!) as! DvirTruckDefectMapping
                truckComments.dvirId = Int16(tempKey as! Int)
                
                
                let trailerComments = NSEntityDescription.insertNewObject(forEntityName: "DvirTrailerDefectMapping", into: managedObjectContext!) as! DvirTrailerDefectMapping
                trailerComments.dvirId = Int16(tempKey as! Int)
            }
            
            do{
                try managedObjectContext?.save()
                print ("Saved")
            }
            catch{
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            
        }
        else if(selectedIndex == 2){
           
            
            dvir?.truckNumber = view2?.txtTruckNumber.text
            dvir?.trailerNumber = view2?.txtTrailerNumber.text
            
// mapping truckDefects with dvir
            
            let keys = self.truckValuesDict.allKeys
            for tempKey in keys{
                let truckdefects = NSEntityDescription.insertNewObject(forEntityName: "TruckDefect", into: managedObjectContext!) as! TruckDefect
                let value = self.truckValuesDict.object(forKey: tempKey);
                
                truckdefects.id = Int16(tempKey as! Int)
                truckdefects.name = value as! String
                
                let truckComments = NSEntityDescription.insertNewObject(forEntityName: "DvirTruckDefectMapping", into: managedObjectContext!) as! DvirTruckDefectMapping
                truckComments.comment = self.truckCommentsDict.object(forKey: tempKey) as! String
                truckComments.truckId = Int16(tempKey as! Int)
            
                
                
                do{
                    try managedObjectContext?.save()
                    print ("Saved")
                }
                catch{
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
                
            }
            
// mapping trailerDefects with dvir
            
            let key = self.trailerValuesDict.allKeys
            for tempKey in key{
                let trailerdefects = NSEntityDescription.insertNewObject(forEntityName: "TrailerDefect", into: managedObjectContext!) as! TrailerDefect
                let value = self.trailerValuesDict.object(forKey: tempKey);
                
                trailerdefects.id = Int16(tempKey as! Int)
                trailerdefects.name = value as! String
                
                let trailerComments = NSEntityDescription.insertNewObject(forEntityName: "DvirTrailerDefectMapping", into: managedObjectContext!) as! DvirTrailerDefectMapping
                trailerComments.comment = self.trailerCommentsDict.object(forKey: tempKey) as! String
                trailerComments.trailerDefectId = Int16(tempKey as! Int)
                
                
                do{
                    try managedObjectContext?.save()
                    print ("Saved")
                }
                catch{
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
                
            }
            
            
        }
        else if(selectedIndex == 3){
            convertImage()
            //            dvir?.driverSignature =  view3?.driverSignatureView!
            //            dvir?.mechanicSignature = view3?.mechanicSignatureView!
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            dvir?.setValue(date, forKey: "elogDate")
            dvir?.elogDate = date;
            do{
                try managedObjectContext?.save()
                print ("Saved")
            }
            catch{
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            
            
        }
        
    }
    func convertImage(){
        let image = UIImagePNGRepresentation((view3?.driverSignatureView!.image!)!) as NSData?
        view3?.driverSignatureView!.image = UIImage(data: image! as Data)
        
    }
    
    func checkDataExistForTheDate() -> Dvir?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dvir")
        
        let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
        do {
            fetchRequest.predicate = NSPredicate(format: "elogDate == %@",date as NSDate)
            dvirItems = try managedObjectContext?.fetch(fetchRequest) as! NSArray
            print("venu", dvirItems.count)
            
            if dvirItems.count > 0{
                return dvirItems.object(at: 0) as? Dvir
            }
        }
        catch {
            print("Failed to retrieve record")
            print(error)
        }
        
        return nil
    }
    
    // Retreive Data
    
    func getDataFromView(selectedIndex:Int, date:String) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dvir")
        
        if (selectedIndex == 1){
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            do {
                fetchRequest.predicate = NSPredicate(format: "elogDate == %@",date as NSDate)
                dvirItems = try managedObjectContext.fetch(fetchRequest) as NSArray
                print("venu", dvirItems.count)
                
                if dvirItems.count > 0{
                    displayDataForTheDateSelected(selectedIndex: 1, dvirItems: dvirItems)
                }else{
                    isDataExistForTheDate = false;
                    clearExistingDataWhenAnotherDateSelected(dvirItems: [])
                }
            }
            catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        else if (selectedIndex == 2){
            
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            do {
                fetchRequest.predicate = NSPredicate(format: "elogDate == %@",date as NSDate)
                dvirItems = try managedObjectContext.fetch(fetchRequest) as NSArray
                print("venu", dvirItems.count)
                
                if dvirItems.count > 0{
                    displayDataForTheDateSelected(selectedIndex: 2, dvirItems: dvirItems)
                }else{
                    isDataExistForTheDate = false;
                    clearExistingDataWhenAnotherDateSelected(dvirItems: [])
                }
            }
            catch {
                print("Failed to retrieve record")
                print(error)
            }
            
            
        }
        else if (selectedIndex == 3){
            
            let date = dateFromString(date: dateSelected, format:  "yyyy-MM-dd ")
            do {
                fetchRequest.predicate = NSPredicate(format: "elogDate == %@",date as NSDate)
                dvirItems = try managedObjectContext.fetch(fetchRequest) as NSArray
                print("venu", dvirItems.count)
                
                if dvirItems.count > 0{
                    displayDataForTheDateSelected(selectedIndex: 3, dvirItems: dvirItems)
                }else{
                    isDataExistForTheDate = false;
                    clearExistingDataWhenAnotherDateSelected(dvirItems: [])
                }
            }
            catch {
                print("Failed to retrieve record")
                print(error)
            }
            
            
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
            isDataExistForTheDate = true;
            if (selectedIndex == 2){
                let obj2 = dvirItems.object(at: 0) as! Dvir
                view2?.txtTruckNumber.text = obj2.truckNumber;
                view2?.txtTrailerNumber.text = obj2.trailerNumber;
                
               let obj3 = dvirItems.object(at: 0) as! TruckDefect
                view2?.txtAddRemoveTruckDefects.text = obj3.name;
                
                let obj4 = dvirItems.object(at: 0) as! TrailerDefect
                view2?.txtAddRemoveTrailerDefects.text = obj4.name;
                
               let obj5 = dvirItems.object(at: 0) as! DvirTruckDefectMapping
  
            }
            
        }
        else if(selectedIndex == 3){
            
        }
        
        
    }
    
 /*
    func updateCoreDataValues(selectedIndex:Int){
        if (selectedIndex == 1 ){
            if dvirItems.count>0{
                let obj1 = dvirItems.object(at: 0) as! Dvir
                obj1.carrier = view1?.txtCarrier.text
                obj1.location = view1?.txtLocation.text
                obj1.odometer = Int16((view1?.txtOdometer.text!)!)!
                do{
                    try obj1.managedObjectContext?.save()
                    print("venu", dvirItems.count)
                }
                    
                catch{
                    print("Failed to retrieve record")
                }
            }
            
        }
        else if(selectedIndex == 2){
            
        }
        else if(selectedIndex == 3){
            
        }
    }
*/
    func clearExistingDataWhenAnotherDateSelected(dvirItems:NSArray){
        for case let textField as UITextField in self.dvirView.subviews {
            textField.text = ""
        }
    }
    
    
    func dateFromString(date: String, format: String) -> NSDate {
        let formatter = DateFormatter()
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.locale = locale as Locale!
        formatter.dateFormat = format
        
        return formatter.date(from: date)! as NSDate    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardDidShow(notification: NSNotification)
    {
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 10;
        self.scrollView.contentInset = contentInset
        //if let userInfo = notification.userInfo
    }
    
    /**
     This method is fired when the keyboard is hidden.
     */
    func keyboardWillHide(notification: NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardDidShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }

    
}


