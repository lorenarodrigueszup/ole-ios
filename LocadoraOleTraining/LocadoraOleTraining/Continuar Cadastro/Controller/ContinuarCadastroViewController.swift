//
//  ContinuarCadastroViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 15/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ContinuarCadastroViewController: UIViewController {

    @IBOutlet weak var LabelTitulo: UILabel!
    @IBOutlet weak var LabelEmail: UILabel!
    @IBOutlet weak var TextFieldCodigo: UITextField!
    @IBOutlet weak var LabelNaoRecebeu: UILabel!
    @IBOutlet weak var ButtonEnviar: UIButton!
    @IBOutlet weak var ButtonValidar: UIButton!
    @IBOutlet weak var stackCodigoInvalido: UIStackView!
    
    var emailUsuario: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Atributos.setaAtributosLabel(label: LabelTitulo, labelText: "IDENTIFICAMOS QUE VOCÊ JÁ INICIOU UM CADASTRO, PARA CONCLUIRMOS, INFORME O CÓDIGO ENVIADO PARA O SEU E-MAIL    :", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        let emailColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        if let email = emailUsuario {
            Atributos.setaAtributosLabel(label: LabelEmail, labelText: email, size: 12, fontFamily: "Roboto-Bold", spaceLine: 0.6, textColor: emailColor)
        }
        Atributos.setaAtributosLabel(label: LabelNaoRecebeu, labelText: "Não recebeu o código?", size: 12, fontFamily: "Roboto-Regular", spaceLine: 0.5, textColor: textColor)
        Atributos.setaAtributosButton(button: ButtonValidar)
        
        stackCodigoInvalido.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ButtonValidar(_ sender: UIButton) {
        guard let codigo = TextFieldCodigo.text else { return }
        if ValidaFormulario.verificaCodigo(codigo) {
            Atributos.setaAtributosIniciais(textField: TextFieldCodigo, stackView: stackCodigoInvalido)
            vaiParaTelaLogin()
            
        } else {
            Atributos.setaAtributosCampoInvalido(textField: TextFieldCodigo, stackView: stackCodigoInvalido)
        }

    }
}

extension ContinuarCadastroViewController {
    func vaiParaTelaLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = LabelEmail.text {
            controller.emailUsuario = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
