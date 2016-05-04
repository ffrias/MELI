//
//  MLBancoViewController.swift
//  meliChallenge
//
//  Created by Federico Frias on 5/3/16.
//  Copyright © 2016 Ffrias. All rights reserved.
//

import UIKit
import Alamofire

class MLBancoViewController: UIViewController {
    
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var bancosPickerView: UIPickerView!
    @IBOutlet weak var bancoImage: UIImageView!
    @IBOutlet weak var bancoNameLabel: UILabel!
    
    @IBOutlet weak var bancoSeleccionadoLabel: UILabel!
    var bancosPickerViewDataSource : [String] = []
    var bancos = [[String:String]]()
    var index:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        getBancos()
        bancosPickerView.dataSource = self
        bancosPickerView.delegate = self
        bancosPickerView.showsSelectionIndicator = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectBancosButtonTouched(sender: AnyObject) {
        doneView.hidden = false
        doneButton.hidden = false
        bancosPickerView.hidden = false
    }
    
    @IBAction func doneButtonTouched(sender: AnyObject) {
        MLPaymentInfoModel.sharedInstance.banco_id = self.bancos[index]["id"]!
        MLPaymentInfoModel.sharedInstance.banco_name = self.bancos[index]["name"]!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("MLCuotasTableViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func getBancos(){
        let bancoNil = ["id": "0", "name":"Seleccione un Banco", "thumbnail":""]
        self.bancos.append(bancoNil)
        self.bancosPickerViewDataSource.append("Seleccione un Banco")
        var parameters = [String:String]()
        parameters["public_key"] = Constants.public_key
        parameters["payment_method_id"] = MLPaymentInfoModel.sharedInstance.mp_id
        
        APICli.sharedInstance.getDataMercadolibre(Constants.base_url, urn: Constants.banco_urn, params: parameters){(result)->Void in
            
            for results in result.arrayValue{
                let id = results["id"].stringValue
                let name = results["name"].stringValue
                let thumbnail = results["thumbnail"].stringValue
                let medioPago = ["id": id, "name": name, "thumbnail": thumbnail]
                self.bancos.append(medioPago)
               self.bancosPickerViewDataSource.append(name)
            }
            self.bancosPickerView.reloadAllComponents()
        }
    }
}


//MARK - PickerViewDelegate
extension MLBancoViewController:UIPickerViewDelegate{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bancosPickerViewDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bancosPickerViewDataSource[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
        bancoSeleccionadoLabel.hidden = false
        bancoNameLabel.text = self.bancos[row]["name"]
        bancoNameLabel.hidden = false
        
        Alamofire.request(.GET, self.bancos[row]["thumbnail"]!)
            .responseImage { response in
                if let image = response.result.value {
                    self.bancoImage.image = image
                    self.bancoImage.hidden = false
                    
                }
        }
        
    }
}
//MARK - PickerViewDatasource
extension MLBancoViewController:UIPickerViewDataSource{}
