//
//  ViewController.swift
//  calculadoraGPM
//
//  Created by Apps2t on 25/09/2020.
//  Copyright © 2020 Apps2t. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CalculadoraProtocol {
    
    var numArray = [Float] ();
    var inNumsArray = [Float] ();
    var operadArray = [String] ();
    
    @IBOutlet weak var pantallaTw: UILabel!
    
    @IBAction func touched(sender:UIButton){
        //pantallaTw.text = sender.restorationIdentifier;
        let button: String = sender.restorationIdentifier ?? "";
        
        switch button{
        case "+","-","mul","div","rest":
            addOperador(opr: button);
            break;
        case "=":
            break;
        default:
            break;
            
        }
            
    }
    
    //convertir numeros sueltos a un solo valor y añadir el operador
    func addOperador(opr: String){
        operadArray[operadArray.count] = opr;
        numArray[numArray.count] = numProcess();
        
    }
    
    //procesar el nuevo numero que se encuentra separado een numeros diferentes
    func numProcess() -> Float{
        var newNum: Float = 0;
        if(inNumsArray.count > 0){
            //proceso de numeros a numero solitario
            inNumsArray = [Float] ();
        }
        return newNum;
    }
    
    func viewUpdate(){
        
    }
    
    func suma(num1: Int, num2: Int)  -> Int {
        return num1 + num2;
    }
    
    func resta(num1: Int, num2: Int) -> Int {
        return num1 - num2;
    }
    
    func division(num1: Int, num2: Int) -> Int {
        return num1 / num2;
    }
    
    func multiplicacion(num1: Int, num2: Int) -> Int {
        return num1 / num2;
    }
    
    func modulo(num1: Int, num2: Int) -> Int {
        return num1 % num2;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

protocol CalculadoraProtocol {
    func suma(num1: Int, num2: Int) -> Int
    func resta(num1: Int, num2: Int) -> Int
    func division(num1: Int, num2: Int) -> Int
    func multiplicacion(num1: Int, num2: Int) -> Int
    func modulo(num1: Int, num2: Int) -> Int
}
