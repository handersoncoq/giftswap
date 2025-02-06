//
//  SwapRequestService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation
import Combine

class SwapRequestService {
    static let shared = SwapRequestService()
    private init() {}

    // Mock data for now
    private var swapRequests: [SwapRequest] = MockSwapRequests.swapRequests

    // Fetch all swap requests
    func fetchSwapRequests() -> AnyPublisher<[SwapRequest], Error> {
        return Just(swapRequests)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch swap requests for a user
    func fetchSwapRequests(forUserId userId: UUID) -> AnyPublisher<[SwapRequest], Error> {
        let userSwapRequests = swapRequests.filter { $0.senderId == userId || $0.receiverId == userId }

        return Just(userSwapRequests)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch swap requests by status
    func fetchSwapRequests(byStatus status: SwapRequestStatus) -> AnyPublisher<[SwapRequest], Error> {
        let filteredRequests = swapRequests.filter { $0.status == status }

        return Just(filteredRequests)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Add a swap request (mock persistence)
    func addSwapRequest(_ swapRequest: SwapRequest) -> AnyPublisher<SwapRequest, Error> {
        swapRequests.append(swapRequest)

        return Just(swapRequest)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Update a swap request (mock persistence)
    func updateSwapRequest(_ updatedSwapRequest: SwapRequest) -> AnyPublisher<SwapRequest, Error> {
        if let index = swapRequests.firstIndex(where: { $0.id == updatedSwapRequest.id }) {
            swapRequests[index] = updatedSwapRequest
            return Just(updatedSwapRequest)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "SwapRequestService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Swap request not found"]))
                .eraseToAnyPublisher()
        }
    }

    // Delete a swap request (mock persistence)
    func deleteSwapRequest(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = swapRequests.firstIndex(where: { $0.id == id }) {
            swapRequests.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "SwapRequestService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Swap request not found"]))
                .eraseToAnyPublisher()
        }
    }
}
