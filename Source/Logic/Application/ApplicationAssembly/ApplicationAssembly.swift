//
//  ApplicationAssembly.swift
//  Scout
//
//

import Foundation
import Alamofire
class ApplicationAssembly {
    
    // MARK: Properties
    let configuration: AppConfiguration
    
    fileprivate lazy var mainRouter: MainRoutingProtocol = self.createMainRouter()
    fileprivate lazy var networkClient: HTTPClientProtocol = self.createNetworkClient()
    fileprivate lazy var networkManager: SessionManager = self.createSessionManager()
    fileprivate lazy var keychainService: KeychainServiceProtocol = self.createKeychainService()

    
    // MARK: Init
    required init(with configuration: AppConfiguration) {
        
        self.configuration = configuration
    }
}

// MARK: -
// MARK: ApplicationAssemblyProtocol
extension ApplicationAssembly: ApplicationAssemblyProtocol {
    
    func assemblyMainRouter() -> MainRoutingProtocol { return self.mainRouter }
    func assemblyNetworkClient() -> HTTPClientProtocol { return self.networkClient }
    func assemblyKeychainService() -> KeychainServiceProtocol { return self.keychainService }

}

// MARK: -
// MARK: Private
fileprivate extension ApplicationAssembly {

    func createSessionManager() -> SessionManager {
        
        let networkRequestTimeOutInterval: TimeInterval = 30
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = networkRequestTimeOutInterval
        configuration.timeoutIntervalForResource = networkRequestTimeOutInterval
        
        let networkManager = Alamofire.SessionManager(configuration: configuration)
        networkManager.startRequestsImmediately = false
        
        return networkManager
    }

    // MARK: Routers
    func createMainRouter() -> MainRoutingProtocol {
        
        let mainAssembly = MainAssembly(withAssembly: self)
        let mainRouter = MainUIRouter(with: mainAssembly)
        return mainRouter
    }

    // MARK: Services
    func createNetworkClient() -> HTTPClientProtocol {
        
        let networkMapper = NetworkMapper()
        let requestBuilder = NetworkRequestBuilder(baseURL: configuration.network.baseURL,
                                                   manager: self.networkManager)
        let networkClient = ScoutHTTPClient(with: networkMapper,
                                  requestBuilder: requestBuilder,
                                         manager: self.networkManager)

        return networkClient
    }
    
    func createKeychainService() -> KeychainServiceProtocol {
        
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let keychainService = KeychainService(with: bundleID)
        return keychainService
    }
}