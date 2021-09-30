//
//  AuthError.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 19.09.2021.
//

import Foundation


enum AuthError {
    case notFilled
    case invalidEmail
    case UnknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Неверный формат почты", comment: "")
        case .UnknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка подключения к серверу", comment: "")
        }
    }
}
