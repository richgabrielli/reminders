import Vapor
import FluentProvider

struct RemindersController {
    func addRoutes(to drop: Droplet) {
        let reminderGroup = drop.grouped("api", "reminders")
    }
}


func createReminder(_ req: Request) throws -> ResponseRepresentable {
    guard let json = req.json else {
        throw Abort.badRequest
    }
    let reminder = try Reminder(json: json)
    try reminder.save()
    return reminder
}

func addRoutes(drop: Droplet) {
    let reminderGroup = drop.grouped("api", "reminders")
    reminderGroup.post("create", handler: createReminder)
    reminderGroup.get(handler: allReminders)
}

func allReminders(_ req: Request) throws -> ResponseRepresentable {
    let reminders = try Reminder.all()
    return try reminders.makeJSON()
}

