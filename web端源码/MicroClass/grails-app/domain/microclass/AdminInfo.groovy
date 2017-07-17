package microclass
/*
*管理员领域类
*/
class AdminInfo {
    String id
    String name
    String password
    static constraints = {
        name(blank:false)
        password(blank:false)
    }
    static mapping = {
        id generator: 'uuid.hex'
    }
    String toString(){
        return name
    }
}
