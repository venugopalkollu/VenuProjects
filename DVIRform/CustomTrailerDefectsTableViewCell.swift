//
//  CustomTrailerDefectsTableViewCell.swift
//  DVIRform
//
//  Created by Lirctek on 12/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit
@objc protocol TrailerCheckBoxSelectded{
    func isCheckBoxSelectedForTrailer(index:Int)
}

class CustomTrailerDefectsTableViewCell: UITableViewCell {

    @IBOutlet weak var trailerCheckBoxButton: UIButton!
    @IBOutlet weak var trailerDefectsLabel: UILabel!
    
    @IBOutlet weak var txtTrailerComments: UITextField!
    
    @IBOutlet weak var lblTrailerComments: UILabel!
     var checkBoxDelegateForTrailer:TrailerCheckBoxSelectded?
    
    var checkBox = UIImage(named: "checkBox-Checked.png")
    var uncheckBox = UIImage(named: "checkbox-unchecked.png")
    var isboxClicked:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        isboxClicked = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func trailerCheckBoxButtonClicked(_ sender: Any) {
         let button = sender as! UIButton
            self.checkBoxDelegateForTrailer?.isCheckBoxSelectedForTrailer(index: button.tag)
    }
}
