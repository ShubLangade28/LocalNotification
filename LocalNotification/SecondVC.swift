//
//  SecondVC.swift
//  LocalNotification
//
//  Created by PHN Tech 2 on 08/06/23.
//

import UIKit

class SecondVC: UIViewController {
    
    var message = ""
    @IBOutlet weak var labelMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelMessage.text = message
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
