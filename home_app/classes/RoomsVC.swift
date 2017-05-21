//
//  RoomsVC.swift
//  home_app
//


import UIKit
import RxSwift

class RoomsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let CELL_REUSE_ID = "room_cell"
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel: RoomsVM
    
    var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder)
    {
        self.viewModel = RoomsVM.init()
        
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    func setupBindings() {
        viewModel.roomItems.subscribe(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewAppear()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rooms = try! viewModel.roomItems.value()
        return rooms.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_ID, for: indexPath)
        let rooms = try! viewModel.roomItems.value()
        let room = rooms[indexPath.row] as! Dictionary<String, Any>
        cell.textLabel?.text = room["name"] as? String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rooms = try! viewModel.roomItems.value()
        let room = rooms[indexPath.row] as! Dictionary<String, Any>
        let id = room["id"] as? Int
        let sb = UIStoryboard(name: "Rooms", bundle: nil)
        let contr = sb.instantiateViewController(withIdentifier: "RoomsDetailVC") as! RoomsDetailVC
        contr.roomId.onNext(id)
        navigationController?.pushViewController(contr, animated: true)
    }

}
