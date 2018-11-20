//
//  ViewController.swift
//  AddressPicker
//
//  Created by Cavan on 2018/11/18.
//  Copyright © 2018 cavanlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let picker = AddressPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.show()
        view.addSubview(picker)
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
