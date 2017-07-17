package microclass

class Collect {
    String id
    String userId
    String courseId
    static constraints = {

    }
    static mapping = {
        id generator: 'uuid.hex'
    }
}
