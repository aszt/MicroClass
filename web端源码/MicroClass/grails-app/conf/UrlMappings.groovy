class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'microClass')
//        "/"(controller: 'public')
//        "/"(view:"/index")
        "/loginRegister"(controller: 'userInfo',action: 'loginRegister')
        "/adminLogin"(controller: 'adminInfo',action: 'login')
        "500"(view:'/microClass/error')

	}
}
