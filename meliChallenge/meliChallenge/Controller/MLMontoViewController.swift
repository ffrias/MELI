//
//  MLMontoViewController.swift
//  meliChallenge
//
//  Created by Federico Frias on 5/3/16.
//  Copyright © 2016 Ffrias. All rights reserved.
//

import UIKit

class MLMontoViewController: UIViewController {

    @IBOutlet weak var montoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButton(montoTextField)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDoneButton(textField:UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .Done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    @IBAction func nextButtonTouched(sender: AnyObject) {
        
        if((self.montoTextField.text!.isEmpty)){
            let alert = UIAlertController(title: "ADVERTENCIA", message: "El campo monto no puede estar vacio. Por favor ingrese un valor.", preferredStyle: .Alert) // 7
            let defaultAction = UIAlertAction(title: "OK", style: .Default) { (alert: UIAlertAction!) -> Void in
            print("OK pressed.")
            }
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion:nil)
        }else{
            MLPaymentInfoModel.sharedInstance.monto = Int(self.montoTextField.text!)!
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("MLMedioPagoViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func setAlert(){
        let monto = MLPaymentInfoModel.sharedInstance.monto
        let medioPago = MLPaymentInfoModel.sharedInstance.mp_name
        let banco = MLPaymentInfoModel.sharedInstance.banco_name
        let cuotas = MLPaymentInfoModel.sharedInstance.cuotas
        
        let alert = UIAlertController(title: "PAGO FINALIZADO", message: "Monto: \(monto)\nMedio de Pago:\(medioPago)\nBanco:\(banco)\nCuotas:\(cuotas)", preferredStyle: .Alert) // 7
        let defaultAction = UIAlertAction(title: "OK", style: .Default) { (alert: UIAlertAction!) -> Void in
            print("OK pressed.")
        }
        alert.addAction(defaultAction)
        presentViewController(alert, animated: true, completion:nil)
    }
}