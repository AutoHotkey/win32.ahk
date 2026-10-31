UnsupportedType(name) {
    throw UnsupportedError("This method depends on an unsupported type.",, name)
}
class UnsupportedError extends Error {
}
