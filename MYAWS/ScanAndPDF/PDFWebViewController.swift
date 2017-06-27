//
//  PDFWebViewController.swift
//  ScannerView
//
//  Created by chinnababu kamanuri on 17/06/17.
//  Copyright © 2017 chinnababu kamanuri. All rights reserved.
//

import UIKit
import UIKit
import AWSS3
import AWSDynamoDB

class PDFWebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var pdfPath:URL!
    var remoteName :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self;
        webView.loadRequest(URLRequest(url: pdfPath))
    }

    func setupWithURL(_ url: URL) {
        self.pdfPath = url
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
    
    func loadTest(){
        
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .APSouth1, identityPoolId: "ap-south-1:d13997f9-9a1d-46ba-a329-1c17645deba0")
        let configuration = AWSServiceConfiguration(region: .APSouth1, credentialsProvider: credentialProvider)
        let cognitoId = credentialProvider.identityId
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        credentialProvider.getIdentityId().continueWith(block: { (task) -> AnyObject? in
            if (task.error != nil) {
                print("Error: " + task.error!.localizedDescription)
            }
            else {
                let cognitoId = task.result!
                print("Cognito id: \(cognitoId)")
            }
            
            let transferManager = AWSS3TransferManager.default()
            let uploadRequest = AWSS3TransferManagerUploadRequest()
            
            let remoteName = "Dashboard/Darshan_receipt7.pdf"
            let fileURL = self.pdfPath//URL(fileURLWithPath: "/Users/lirctek/Downloads/MyProject-AmazonWebService/MYAWS/Darshan_receipt.pdf")
            
            uploadRequest?.bucket = "mylirctek"
            uploadRequest?.key = remoteName
            uploadRequest?.body = fileURL!
            uploadRequest?.contentType = "text/plain"
            
            transferManager.upload(uploadRequest!).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Void in
                
                if (task.error != nil) {
                    print("Error: " + (task.error?.localizedDescription)!)
                    
                } else {
                    // the task result will contain the identity id
                    let cognitoId = task.result
                }
                
                print("chinna");
                
                return
                // Do something with the response
            })
            return task;
            
        })
        
    }

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
