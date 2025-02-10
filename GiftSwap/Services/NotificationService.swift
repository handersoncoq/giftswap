//
//  NotificationService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import Foundation
import Combine

class NotificationService {
    static let shared = NotificationService()
    private init() {}

    private var notifications: [NotificationItem] = []

    // Send a notification to a user
    func sendNotification(to userId: UUID, message: String) {
        let notification = NotificationItem(id: UUID(), userId: userId, message: message, date: Date(), isRead: false)
        notifications.append(notification)
    }

    // Fetch notifications for a specific user
    func fetchNotifications(for userId: UUID) -> AnyPublisher<[NotificationItem], Never> {
        return Just(notifications.filter { $0.userId == userId })
            .eraseToAnyPublisher()
    }

    // Mark notification as read
    func markAsRead(notificationId: UUID) {
        if let index = notifications.firstIndex(where: { $0.id == notificationId }) {
            notifications[index].isRead = true
        }
    }
}

// Notification Model
struct NotificationItem: Identifiable {
    let id: UUID
    let userId: UUID
    let message: String
    let date: Date
    var isRead: Bool
}
