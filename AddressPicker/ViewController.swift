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
    let showBtn = UIButton.init(frame: CGRect(x: 100, y: 150, width: 100, height: 40))
    let resultLabel = UILabel.init(frame: CGRect(x: 0, y: 400, width: UIScreen.main.bounds.width, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(showBtn)
        showBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        showBtn.setTitle("点击选择地址", for: .normal)
        showBtn.setTitleColor(UIColor.darkGray, for: .normal)
        showBtn.layer.cornerRadius = 5
        showBtn.layer.masksToBounds = true
        showBtn.layer.borderColor = UIColor.darkGray.cgColor
        showBtn.layer.borderWidth = 1
        showBtn.addTarget(self, action: #selector(showPickerAction), for: .touchUpInside)
        
        
        resultLabel.font = UIFont.systemFont(ofSize: 14)
        resultLabel.textColor = UIColor.gray
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
        
        picker.selectValue = { (p, c, a) in
            self.resultLabel.text = p + c + a
        }
    }
    
    @objc func showPickerAction() {
        picker.show()
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
