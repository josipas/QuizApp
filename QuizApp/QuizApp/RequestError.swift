enum RequestError: Error {
    case invalidUrl
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
}
