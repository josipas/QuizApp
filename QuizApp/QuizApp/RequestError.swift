enum RequestError: Error {

    case invalidUrl
    case serverError
    case noDataError
    case dataDecodingError
    case forbidden
    case notFound
    case unauthorized
    case badRequest
    case responseError
    case unknownError

}
