import OSLog

extension Logger {

    static let conferencePlanning = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "ConferencePlanning"
    )

}

extension Data {
    var pushTokenHumanReadableDescription: String {
        reduce(into: "") {
            $0.append(String(format: "%02x", $1))
        }
    }
}
