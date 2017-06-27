//
//  ImageViewController.swift
//  ScannerView
//
//  Created by chinnababu kamanuri on 16/06/17.
//  Copyright © 2017 chinnababu kamanuri. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var isRetake = true
    var path:String = ""
    let sharedObj = GlobalSharedFunc.sharedManager;

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAndShowPDF(_ sender: Any) {
        let image = UIImage(contentsOfFile: path)
        sharedObj.imagePaths.append(image!)
        let date :NSDate = NSDate()
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH_mm_ss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT")! as TimeZone
        let docName = "/\(dateFormatter.string(from: date as Date))"

        showAlertView(docTitle: "Document Title", alertTitle: docName)
    }

    fileprivate func getDestinationPath(_ number: Int) -> String {
        return NSHomeDirectory() + "/sample\(number).pdf"
    }

    fileprivate func getImagePath(_ number: Int) -> String {
        return Bundle.main.path(forResource: "sample_\(number)", ofType: "jpg")!
    }

    func dismissPreview(_ dismissTap: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = UIImage(contentsOfFile: path)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }

    @IBAction func DoneButtonSelection(_ sender: Any) {
        
        isRetake = false;
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if(!isRetake){
            let image = UIImage(contentsOfFile: path)
            sharedObj.imagePaths.append(image!)
        }
    }

    func showAlertView(docTitle:String,alertTitle:String){
        let alertController = UIAlertController(title: docTitle, message: "", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in

            let firstTextField = alertController.textFields![0] as UITextField
            self.savePDFFile(forTheTitle: firstTextField.text!)

        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
        })

        alertController.addTextField { (textField : UITextField!) -> Void in

            textField.text = alertTitle
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    func savePDFFile(forTheTitle:String){

        let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // your destination file url
        let destination = documentsUrl.appendingPathComponent(forTheTitle+".pdf")
        if FileManager().fileExists(atPath: destination.path) {

            showAlertView(docTitle: "File AlredayExist choose another name", alertTitle: forTheTitle)
        } else{
            do {

                try PDFGenerator.generate(sharedObj.imagePaths, to: destination);

                let obj = PDFWebViewController()
                obj.pdfPath = destination
                obj.remoteName = forTheTitle+".pdf"
                self.navigationController?.pushViewController(obj, animated: true);

            } catch (let e) {
                print(e)
            }
        }

    }

    
}
