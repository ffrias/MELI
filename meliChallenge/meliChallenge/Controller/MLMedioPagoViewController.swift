//
//  MLMedioPagoViewController.swift
//  meliChallenge
//
//  Created by Federico Frias on 5/3/16.
//  Copyright © 2016 Ffrias. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class MLMedioPagoViewController: UIViewController {

    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var mediosPagoPickerView: UIPickerView!
    @IBOutlet weak var mpImage: UIImageView!
    @IBOutlet weak var mpNameLabel: UILabel!
    
    @IBOutlet weak var mpSeleccionadoLabel: UILabel!
    var mediosPagoPickerViewDataSource : [String] = []
    var mediosPago = [[String:String]]()
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMediosDePago()
        mediosPagoPickerView.dataSource = self
        mediosPagoPickerView.delegate = self
        mediosPagoPickerView.showsSelectionIndicator = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectMediosPagoButtonTouched(sender: AnyObject) {
        doneView.hidden = false
        doneButton.hidden = false
        mediosPagoPickerView.hidden = false
    }
    
    @IBAction func doneButtonTouched(sender: AnyObject) {
        MLPaymentInfoModel.sharedInstance.mp_id = self.mediosPago[index]["id"]!
        MLPaymentInfoModel.sharedInstance.mp_name = self.mediosPago[index]["name"]!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("MLBancoViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getMediosDePago(){
        let medioPagoNil = ["id": "0", "name":"Seleccione un Medio de Pago", "thumbnail":""]
        self.mediosPago.append(medioPagoNil)
        self.mediosPagoPickerViewDataSource.append("Seleccione un Medio de Pago")
        var parameters = [String:String]()
        parameters["public_key"] = Constants.public_key
    
        APICli.sharedInstance.getDataMercadolibre(Constants.base_url, urn: Constants.mp_urn, params: parameters){(result)->Void in
            
            for results in result.arrayValue{
                let id = results["id"].stringValue
                let name = results["name"].stringValue
                let thumbnail = results["thumbnail"].stringValue
                let medioPago = ["id": id, "name": name, "thumbnail": thumbnail]
                self.mediosPago.append(medioPago)
                self.mediosPagoPickerViewDataSource.append(name)
            }
            self.mediosPagoPickerView.reloadAllComponents()
        }
    }

}
//MARK - PickerViewDelegate
extension MLMedioPagoViewController:UIPickerViewDelegate{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mediosPagoPickerViewDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mediosPagoPickerViewDataSource[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
        mpSeleccionadoLabel.hidden = false
        mpNameLabel.text = self.mediosPago[row]["name"]
        mpNameLabel.hidden = false
        
        Alamofire.request(.GET, self.mediosPago[row]["thumbnail"]!)
            .responseImage { response in
                if let image = response.result.value {
                    self.mpImage.image = image
                    self.mpImage.hidden = false
                    
                }
        }
        
    }
}
//MARK - PickerViewDatasource
extension MLMedioPagoViewController:UIPickerViewDataSource{}