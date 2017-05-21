//
//  RoomsDetailVC.swift
//  home_app
//


import UIKit
import RxSwift

let CELL_LIGHT_REUSE_ID = "light_cell"
let CELL_BASE_REUSE_ID = "basic_cell"

class RoomsDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var roomName: UILabel!
    
    var refreshControl: UIRefreshControl!
    
    var roomId = BehaviorSubject<Int?>(value: nil)
    
    let viewModel: RoomsDetailVM
    
    var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder)
    {
        self.viewModel = RoomsDetailVM.init()
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    func setupBindings() {
        
        roomId
            .filter {$0 != nil}
            .map {$0!}
            .bindTo(viewModel.roomId)
            .addDisposableTo(disposeBag)
        
        viewModel.sensors.subscribe(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)
        
        viewModel.name.subscribe(onNext: { [unowned self] name in
            self.roomName.text = name
        }).addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewAppear()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sensors = try! viewModel.sensors.value()
        return sensors.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sensors = try! viewModel.sensors.value()
        let sensor = sensors[indexPath.row] as! Dictionary<String, Any>
        if sensor["type"] as! String == "light" {
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_LIGHT_REUSE_ID, for: indexPath) as! LightCell
            cell.name.text = sensor["name"] as! String
            let value = sensor["value"] as! Int
            cell.value.text = "\(value)%"
            cell.slider.value = Float(value)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_BASE_REUSE_ID, for: indexPath)
            cell.textLabel?.text = sensor["name"] as! String
            let value = sensor["value"] as! Int
            if sensor["type"] as! String == "temperature" {
                cell.detailTextLabel?.text = "\(value)°C"
            } else {
                cell.detailTextLabel?.text = "\(value)%"
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sensors = try! viewModel.sensors.value()
        let sensor = sensors[indexPath.row] as! Dictionary<String, Any>
        if sensor["type"] as! String == "light" {
            return 93
        } else {
            return 44
        }
    }


}
