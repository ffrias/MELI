//
//  MLCuotasTableViewController.swift
//  meliChallenge
//
//  Created by Federico Frias on 5/3/16.
//  Copyright © 2016 Ffrias. All rights reserved.
//

import UIKit

class MLCuotasTableViewController: UITableViewController {
    
    var cuotasTableDataSource : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getCuotas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCuotas(){
       
        var parameters = [String:String]()
        parameters["public_key"] = Constants.public_key
        parameters["payment_method_id"] = MLPaymentInfoModel.sharedInstance.mp_id
        parameters["amount"] = String(MLPaymentInfoModel.sharedInstance.monto)
        parameters["payment_method_id"] = MLPaymentInfoModel.sharedInstance.mp_id
        parameters["issuer.id"] = MLPaymentInfoModel.sharedInstance.banco_id
        
        APICli.sharedInstance.getDataMercadolibre(Constants.base_url, urn: Constants.cuotas_urn, params: parameters){(result)->Void in

            for results in result[0]["payer_costs"].arrayValue{
                let recommededMessage = results["recommended_message"].stringValue
                self.cuotasTableDataSource.append(recommededMessage)
            }
            self.tableView.reloadData()
            self.tableView.hidden = false
        }
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = MLCuotasTableViewCell()
        cell = tableView.dequeueReusableCellWithIdentifier("MLCuotasTableViewCell", forIndexPath: indexPath) as! MLCuotasTableViewCell
        cell.messageLabel.text = cuotasTableDataSource[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return cuotasTableDataSource.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MLPaymentInfoModel.sharedInstance.cuotas = cuotasTableDataSource[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("MLMontoViewController") as! MLMontoViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.setAlert()
    }
}