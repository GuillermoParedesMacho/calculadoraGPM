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
            operarTodo();
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
    
    //num1 opr1 num2 = res1 // res1 opr2 num3 = res2 .. // resx oprx+1 numin = res final
    func operarTodo (){
        var res:Float = 0;
        if(operadArray.count > 0){
            viewUpdate();
            numArray.append(numProcess(res: true));
            res = operacion(num1: numArray[0], num2: numArray[1], opr: operadArray[0]);
            var y = 1;
            while (y < operadArray.count){
                res = operacion(num1: res, num2: numArray[y+1], opr: operadArray[y]);
                y = y+1;	
            }
            let text = pantallaTw.text?.description;
            pantallaTw.text = text! + " = " + res.description;
        }
        
        numArray = [Float] ();
        inNumsArray = [Float] ();
        operadArray = [String] ();
    }
    
    func operacion (num1: Float, num2: Float, opr: String) -> Float{
        var resultado:Float = 0;
        
        switch opr {
        case "+":
            resultado = suma(num1: num1, num2: num2);
            break;
        case "-":
            resultado = resta(num1: num1, num2: num2);
            break;
        case "*":
            resultado = multiplicacion(num1: num1, num2: num2);
            break;
        case "/":
            resultado = division(num1: num1, num2: num2);
            break;
        case "%":
            resultado = modulo(num1: num1, num2: num2);
            break;
        default:
            break;
        }
        
        return resultado;
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
    
    func suma(num1: Float, num2: Float)  -> Float {
        return num1 + num2;
    }
    
    func resta(num1: Float, num2: Float) -> Float {
        return num1 - num2;
    }
    
    func division(num1: Float, num2: Float) -> Float {
        return num1 / num2;
    }
    
    func multiplicacion(num1: Float, num2: Float) -> Float {
        return num1 * num2;
    }
    
    func modulo(num1: Float, num2: Float) -> Float {
        return num1.truncatingRemainder(dividingBy: num2);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

protocol CalculadoraProtocol {
    func suma(num1: Float, num2: Float) -> Float
    func resta(num1: Float, num2: Float) -> Float
    func division(num1: Float, num2: Float) -> Float
    func multiplicacion(num1: Float, num2: Float) -> Float
    func modulo(num1: Float, num2: Float) -> Float
}
