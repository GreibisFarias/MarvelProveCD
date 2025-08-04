//
//  LoginView.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 8/1/25.
//

import Foundation
import UIKit

//Generamos la Ui por codigo
class LoginView: UIView{
    //registro
    public let messageLbl = {
        let message = UILabel()
        message.text = "Ya tienes cuenta?"
        message.textColor = .red.withAlphaComponent(0.7)
        message.translatesAutoresizingMaskIntoConstraints = false
        return message
    }()
    
    public let resgisterLbl = {
        let message = UIButton()
        message.setTitle( "registrate", for: .normal)
        message.setTitleColor(.blue, for: .normal)
        message.backgroundColor = .clear
        message.translatesAutoresizingMaskIntoConstraints = false
        return message
    }()
    
    
    //Logo
    public let imageLogo = {
        let image = UIImageView(image: UIImage(named: "title2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //Usuario
    public let emailTextFiled = {
        let textfield = UITextField()
        textfield.backgroundColor = .red.withAlphaComponent(0.6)
        textfield.textColor = .white
        textfield.font = UIFont.systemFont(ofSize: 18)
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocapitalizationType = .none
//        textfield.placeholder = NSLocalizedString("Email", comment: "Es el email")
        textfield.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true //Sin esto no se ve el corner radius
        return textfield
    }()
    
    //Clave
    public let passwordTextField = {
        
        let textfield = UITextField()
        textfield.backgroundColor = .red.withAlphaComponent(0.6)
        textfield.textColor = .white
        textfield.font = UIFont.systemFont(ofSize: 18)
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocapitalizationType = .none
//        textfield.placeholder = NSLocalizedString("Password", comment: "The Password Text")
        textfield.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.placeholder = "Clave"
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true //Sin esto no se ve el corner radius
        textfield.isSecureTextEntry = true //Para que no se vea la clase
        
        return textfield
    }()
    
    //boton
    public let buttonLogin = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.setTitleColor(.cyan, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init coder no ha sido complementado")
    }
    
    func setupViews() {
        // 1. Crear imagen de fondo como UIImageView
        let backImage = UIImageView(image: UIImage(named: "newBaxk"))
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.contentMode = .scaleAspectFill // Puedes usar .scaleToFill si lo prefieres
        addSubview(backImage)
        sendSubviewToBack(backImage) // Asegura que esté detrás de los demás elementos

        // 2. Agregar los otros elementos
        addSubview(imageLogo)
        addSubview(emailTextFiled)
        addSubview(passwordTextField)
        addSubview(buttonLogin)
        addSubview(messageLbl)
        addSubview(resgisterLbl)
        
        // 3. Activar constraints
        NSLayoutConstraint.activate([
            // Imagen de fondo (toda la vista)
            backImage.topAnchor.constraint(equalTo: topAnchor),
            backImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Logo
            imageLogo.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            imageLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageLogo.heightAnchor.constraint(equalToConstant: 100),
            
            // Email
            emailTextFiled.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 100),
            emailTextFiled.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            emailTextFiled.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            emailTextFiled.heightAnchor.constraint(equalToConstant: 50),
            
            // Password
            passwordTextField.topAnchor.constraint(equalTo: emailTextFiled.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Botón
            buttonLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 75),
            buttonLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            buttonLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            
            //message
            messageLbl.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 10),
            messageLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            
            
            resgisterLbl.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 5),
            resgisterLbl.leadingAnchor.constraint(equalTo: messageLbl.leadingAnchor, constant: 150)
        ])
    }
    
    func getEmailView() -> UITextField{
        emailTextFiled
    }
    func getPassworfView() -> UITextField{
        passwordTextField
    }
    func getLogoImageView() -> UIImageView{
        imageLogo
    }
    func getButtonLoginView() -> UIButton{
        buttonLogin
    }
    
    func getMessageLvl() -> UILabel{
        messageLbl
    }
    
    func getRegister() -> UIButton{
        resgisterLbl
    }
}
