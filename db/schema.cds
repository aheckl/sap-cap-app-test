using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

namespace ibike.db;

entity Bikes : cuid {
    name : String(128) not null  @mandatory;
    type : String(20);
    price : Int32;
    status : String(20);
    currentStation: Association to Stations;
}

entity Stations : cuid {
    location : String(128) not null @mandatory;
    maxCapacity : Int32;
    bikesAvailable : Int32;
    // bikes : Association to many Bikes on bikes.currentStation = $self;
    incentiveLevel : Association to Incentives;
}

entity Incentives : cuid {
    level : String(10);
    discountRate : Int32;
    bonusMinutes : Int32;
    // station: Association to many Stations on station.incentiveLevel = $self;
}

entity TaskItems : cuid {
    bike : Association to Bikes;
    departure : Association to Stations;
    target : Association to Stations;
    task : Association to RedistributionTasks;
}

entity RedistributionTasks : cuid {
    status : Association to TaskStatus;
    assignedWorker : Association to Workers;
    // taskItems : Composition of  many TaskItems on tasksItems.task = $self;
}

entity TaskStatus : CodeList {
    key code : String(20);
}

entity Workers : cuid {
    name : String(20);
    email : String(128);
    // tasks : Association to many RedistributionTasks on tasks.assignedWorker = $self;
}