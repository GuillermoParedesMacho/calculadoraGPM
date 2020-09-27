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
            inNumsArray.append((button as NSString).floatValue);
            viewUpdate();
            break;
            
        }
            
    }
    //convertir numeros sueltos a un solo valor y añadir el operador
    func addOperador(opr: String){
        var oprd = "";
        switch opr{
        case "mul":
            oprd = "*";
            break;
        case "div":
            oprd = "/";
            break;
        case "rest":
            oprd = "%";
            break;
        default:
            oprd = opr;
            break;
        }
        operadArray.append(oprd);
        numArray.append(numProcess(res: true));
        viewUpdate();
    }
    
    //num1 opr1 num2 = res1 // res1 opr2 num3 = res2 ... // resx oprx+1 numin = res final
    func operar (){
        
    }
    
    //procesar el nuevo numero que se encuentra separado een numeros diferentes
    //nums:1,2,3,4 -> num = 1*1000+2*100+3*10+4*1
    func numProcess(res:Bool) -> Float{
        var newNum: Float = 0;
        if(inNumsArray.count > 0){
            
            var x = inNumsArray.count
            repeat{
                var y = inNumsArray.count - x;
                x = x - 1;
                var numpos: Float = 1;
       	         while (y > 0){
                    numpos = numpos * 10;
                    y = y-1;
                }
                newNum = newNum + inNumsArray[x] * numpos;
            }while x > 0
            
            if(res){
                inNumsArray = [Float] ();
            }
            
        }
        return newNum;
    }
    
    //num0,oper0,num1,oper1... numx,operx,newnum
    func viewUpdate(){
        var x = 0;
        var text:String = "";
        while x < numArray.count{
            text = text + numArray[x].description + " " + operadArray[x].description + " ";
            x = x + 1;
        }
        text = text + numProcess(res: false).description;
        pantallaTw.text = text;
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
