//
//  ViewController.swift
//  iOSExample
//
//  Created by Bibin Jacob Pulickal on 16/05/20.
//

import UIKit
import BBToast

class ViewController: UITableViewController {

    var toastMessage: String?   = "This is how a toast looks. ☺️"

    var selectedBackgroundColorIndex = 0
    var selectedTextColorIndex       = 0
    var selectedIndicatorColorIndex  = 0

    override func loadView() {
        super.loadView()

        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title                                   = "BBToast"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem                      = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showToast))
    }

    override func numberOfSections(in tableView: UITableView) -> Int { Section.allCases.count }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section.allCases[section].rawValue.camelCaseToWords
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { section == 0 ? 1 : Color.allCases.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as! TextFieldCell
            cell.label.text     = "Message:"
            cell.textField.text = toastMessage
            cell.delegate       = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = Color.allCases[indexPath.row].rawValue
        cell.selectionStyle = .none
        if indexPath.section == 1 {
            cell.accessoryType   = indexPath.row == selectedBackgroundColorIndex ? .checkmark : .none
        } else if indexPath.section == 2 {
            cell.accessoryType   = indexPath.row == selectedTextColorIndex ? .checkmark : .none
        } else if indexPath.section == 3 {
            cell.accessoryType   = indexPath.row == selectedIndicatorColorIndex ? .checkmark : .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedBackgroundColorIndex = indexPath.row
        } else if indexPath.section == 2 {
            selectedTextColorIndex = indexPath.row
        } else if indexPath.section == 3 {
            selectedIndicatorColorIndex = indexPath.row
        }
        tableView.reloadData()
    }

    @objc private func showToast() {
        showBBToast(toastMessage, duration: 2) { toast in
            toast.backgroundColor = Color.allCases[self.selectedBackgroundColorIndex].color
            toast.textColor       = Color.allCases[self.selectedTextColorIndex].color
        }
    }
}

extension ViewController: TextFieldCellDelegate {

    func textFieldCell(_ textFieldCell: TextFieldCell, updatedText text: String?) {
        toastMessage = text
    }
}
