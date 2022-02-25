//
//  main.swift
//  3l_ChernikovOleg.playground
//
//  Created by Олег Черников on 25.02.2022.
//

import Foundation

enum CarBrands{
    case Mitsubishi, Dodge, Toyota, Lada
}

enum EngineStates{
    case running, off
}

enum WindowsStates{
    case up, down
}

enum LoadUnload{
    case empty
    case full
    case loadSome(kgs:Int)
    case unloadSome(kgs:Int)
}

enum LoadStuffCabin:Int{
    case loadTV = 10
    case unloadTV = -10
}

struct SportCar{
    private let cabinSpace: Int
    var cabinOccupied: Int {
        didSet{
            if self.cabinOccupied > self.cabinSpace{
                print("Cabin is overloaded by \(self.cabinOccupied - self.cabinSpace) kgs")
                self.cabinOccupied = self.cabinSpace
            }
            else if self.cabinOccupied < 0{
                print("Trying to take more than there is")
                self.cabinOccupied = oldValue
            }
        }
    }
    var cabinState : LoadStuffCabin{
        willSet{
            if newValue == .loadTV && self.cabinOccupied + newValue.rawValue > self.cabinSpace{
                print("No place for TV")
            }
            else if newValue == .unloadTV && self.cabinOccupied + newValue.rawValue < 0{
                print("There's no TV")
            }
        }
        didSet{
            switch self.cabinState{
            case .loadTV:
                self.cabinOccupied += LoadStuffCabin.loadTV.rawValue
            case .unloadTV:
                self.cabinOccupied += LoadStuffCabin.unloadTV.rawValue
            }
        }
    }
    private let brand: CarBrands
    var engine: EngineStates {
        willSet{
            if newValue == .running{
                print("Engine is running")
            }
            else{
                print("Engine is off")
            }
        }
    }
    var windows: WindowsStates {
        willSet{
            if newValue == .up{
                print("Windows are up")
            }
            else{
                print("Windows are down")
            }
        }
    }
    
    func whatAreYou(){
        print("My brand is \(self.brand)")
        print("My cabin's capacity is \(self.cabinSpace) kgs and it's occupied for \(self.cabinOccupied) kgs")
        print("TV in my cabin \(self.cabinState)")
        print("My engine is \(self.engine)")
        print("My windows are \(self.windows)")
    }
    
    mutating func loadUnloadCabin(_ kg: LoadUnload){
        switch kg{
        case .empty:
            self.cabinOccupied = 0
        case .full:
            self.cabinOccupied = self.cabinSpace
        case .loadSome(kgs: let kgs):
            self.cabinOccupied += kgs
        case .unloadSome(kgs: let kgs):
            self.cabinOccupied -= kgs
        }
    }
    
    init(cabinSpace: Int, brand: CarBrands, engine: EngineStates, windows: WindowsStates){
        self.cabinSpace = cabinSpace
        self.cabinOccupied = 0
        self.brand = brand
        self.engine = engine
        self.windows = windows
        self.cabinState = .unloadTV
    }
}

struct TrunkCar{
    private let trunkSpace: Int
    var trunkOccupied: Int {
        didSet{
            if self.trunkOccupied > self.trunkSpace{
                print("Cabin is overloaded by \(self.trunkOccupied - self.trunkSpace) kgs")
                self.trunkOccupied = self.trunkSpace
            }
            else if self.trunkOccupied < 0{
                print("Trying to take more than there is")
                self.trunkOccupied = oldValue
            }
        }
    }
    private let cabinSpace: Int
    var cabinOccupied: Int {
        didSet{
            if self.cabinOccupied > self.cabinSpace{
                print("Cabin is overloaded by \(self.cabinOccupied - self.cabinSpace) kgs")
                self.cabinOccupied = self.cabinSpace
            }
            else if self.cabinOccupied < 0{
                print("Trying to take more than there is")
                self.cabinOccupied = oldValue
            }
        }
    }
    var cabinState : LoadStuffCabin{
        willSet{
            if newValue == .loadTV && self.cabinOccupied + newValue.rawValue > self.cabinSpace{
                print("No place for TV")
            }
            else if newValue == .unloadTV && self.cabinOccupied + newValue.rawValue < 0{
                print("There's no TV")
            }
        }
        didSet{
            switch self.cabinState{
            case .loadTV:
                self.cabinOccupied += LoadStuffCabin.loadTV.rawValue
            case .unloadTV:
                self.cabinOccupied += LoadStuffCabin.unloadTV.rawValue
            }
        }
    }
    private let brand: CarBrands
    var engine: EngineStates {
        willSet{
            if newValue == .running{
                print("Engine is running")
            }
            else{
                print("Engine is off")
            }
        }
    }
    var windows: WindowsStates {
        willSet{
            if newValue == .up{
                print("Windows are up")
            }
            else{
                print("Windows are down")
            }
        }
    }
    
    func whatAreYou(){
        print("My brand is \(self.brand)")
        print("My trunk's capacity is \(self.trunkSpace) kgs and it's occupied for \(self.trunkOccupied) kgs")
        print("My cabin's capacity is \(self.cabinSpace) kgs and it's occupied for \(self.cabinOccupied) kgs")
        print("TV in my cabin \(self.cabinState)")
        print("My engine is \(self.engine)")
        print("My windows are \(self.windows)")
    }
    
    mutating func loadUnloadCabin(_ kg: LoadUnload){
        switch kg{
        case .empty:
            self.cabinOccupied = 0
        case .full:
            self.cabinOccupied = self.cabinSpace
        case .loadSome(kgs: let kgs):
            self.cabinOccupied += kgs
        case .unloadSome(kgs: let kgs):
            self.cabinOccupied -= kgs
        }
    }
    
    init(trunkSpace: Int, cabinSpace: Int, brand: CarBrands, engine: EngineStates, windows: WindowsStates){
        self.trunkSpace = trunkSpace
        self.trunkOccupied = 0
        self.cabinSpace = cabinSpace
        self.cabinOccupied = 0
        self.brand = brand
        self.engine = engine
        self.windows = windows
        self.cabinState = .unloadTV
    }
    
}

var mitsu = SportCar(cabinSpace: 10, brand: .Dodge, engine: .off, windows: .up)

mitsu.loadUnloadCabin(LoadUnload.loadSome(kgs: 20))

mitsu.cabinState = .unloadTV

mitsu.whatAreYou()

var toyo = TrunkCar(trunkSpace: 30, cabinSpace: 10, brand: .Toyota, engine: .running, windows: .up)

toyo.whatAreYou()

