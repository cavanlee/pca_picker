//
//  AddressPickerView.swift
//  AddressPicker
//
//  Created by Cavan on 2018/11/18.
//  Copyright © 2018 cavanlee. All rights reserved.
//

import UIKit

struct PcaModel {
    var code = ""
    var name = ""
    var children: [PcaModel] = []
}


class AddressPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    typealias SelectValueCallback = (String, String, String) -> Void
    
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
    
    
    lazy var pickerView = UIPickerView()
    var originSize: CGSize = .zero
    
    var pList: [PcaModel] = []
    var cList: [PcaModel] = []
    var aList: [PcaModel] = []
    
    var pResult = ""
    var cResult = ""
    var aResult = ""
    
    // 选择结果回调
    var selectValue: SelectValueCallback?
    
    
    override init(frame: CGRect) {
    super.init(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
    
    backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
    
    pickerView.backgroundColor = UIColor.white
    pickerView.delegate = self
    pickerView.dataSource = self
    originSize = pickerView.frame.size
    
    let path = Bundle.main.path(forResource: "pca-code", ofType: "json")
    let url = URL.init(fileURLWithPath: path!)
    
    do {
    
    let jsonString = try String.init(contentsOf: url, encoding: .utf8)
    
    pList = [PcaModel].deserialize(from: jsonString) as! [PcaModel]
    cList = pList[pList.count / 2].children
    aList = cList[cList.count / 2].children
    
    pickerView.selectRow(pList.count / 2, inComponent: 0, animated: true)
    pickerView.selectRow(cList.count / 2, inComponent: 1, animated: true)
    pickerView.selectRow(aList.count / 2, inComponent: 2, animated: true)
    
    } catch let error as NSError {
    print("城市列表读取失败: \(error.description)")
    }
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return frame.size.width / 3.0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
    return pList.count
    case 1:
    return cList.count
    case 2:
    return aList.count
    default:
    return 0
    }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    
    switch component {
    case 0:
    let pcaModel = pList[row]
    cList = pcaModel.children
    aList = cList[cList.count / 2].children
    pickerView.reloadComponent(1)
    pickerView.reloadComponent(2)
    pickerView.selectRow(aList.count / 2, inComponent: 2, animated: true)
    pickerView.selectRow(cList.count / 2, inComponent: 1, animated: true)
    
    pResult = "\(pList[row].name)"
    cResult = ""
    aResult = ""
    break
    case 1:
    let pcaModel = cList[row]
    aList = pcaModel.children
    pickerView.reloadComponent(2)
    pickerView.selectRow(aList.count / 2, inComponent: 2, animated: true)
    
    cResult = "\(cList[row].name)"
    aResult = ""
    break
    case 2:
    aResult = "\(aList[row].name)"
    break
    default:
    break
    }
    
    if let select = selectValue {
    select(pResult, cResult, aResult)
    }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    guard let label = view as? UILabel else {
    let rect = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width, height: pickerView.rowSize(forComponent: component).height)
    let initLabel = UILabel.init(frame: rect)
    initLabel.font = UIFont.systemFont(ofSize: 15)
    initLabel.textAlignment = .center
    initLabel.textColor = UIColor.darkGray
    
    initLabel.text = setPickerData(with: component, row)
    
    return initLabel
    }
    
    label.text = setPickerData(with: component, row)
    
    return label
    }
    
    private func setPickerData(with component: Int, _ row: Int) -> String {
    switch component {
    case 0:
    return pList[row].name
    case 1:
    return cList[row].name
    case 2:
    return aList[row].name
    default:
    return ""
    }
    }
    
    
    func show() {
    
    UIApplication.shared.keyWindow?.addSubview(self)
    
    addSubview(pickerView)
    let pickerHeight = originSize.height
    
    pickerView.frame = CGRect(x: 0, y: screenH, width: screenW, height: pickerHeight)
    UIView.animate(withDuration: 0.3) {
    self.pickerView.frame = CGRect(x: 0, y: screenH - pickerHeight, width: screenW, height: pickerHeight)
    }
    }
    
    func hide() {
    let pickerHeight = originSize.height
    
    UIView.animate(withDuration: 0.3, animations: {
    self.pickerView.frame = CGRect(x: 0, y: screenH, width: screenW, height: pickerHeight)
    
    }) { (finish) in
    self.removeFromSuperview()
    }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    hide()
    }
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
    
}
