//
//  ProjectsViewModel.swift
//  Httper
//
//  Created by Meng Li on 2018/9/12.
//  Copyright © 2018 MuShare Group. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFlow

class ProjectsViewModel {
    
    private let projects = BehaviorRelay<[Project]>(value: DaoManager.shared.projectDao.findAll())
    
    init() {
        syncProjects()
    }
    
    private func syncProjects() {
        // Pull remote projects from server
        SyncManager.shared.pullUpdatedProjects { [weak self] revision in
            // Pull successfully.
            if revision > 0 {
                self?.projects.accept(DaoManager.shared.projectDao.findAll())
                
                // Push local projects to server in background.
                SyncManager.shared.pushLocalProjects(nil)
            }
        }
    }
    
    var projectSection: Observable<SingleSection<Project>> {
        return projects.map { SingleSection.create($0) }
    }
}

extension ProjectsViewModel: Stepper {
    
}
