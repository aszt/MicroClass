package microclass

import microclass.util.GeetestConfig
import microclass.util.GeetestLib

class PublicController {
    def index(){
        print("m预加载执行了")
    }

    /*
    * 加载验证码
    * */
    def startCaptcha(){
        GeetestLib gtSdk = new GeetestLib(GeetestConfig.getCaptcha_id(), GeetestConfig.getPrivate_key());
        String resStr = "{}";
        //自定义userid
        String userid = "test";
        //进行验证预处理
        int gtServerStatus = gtSdk.preProcess(userid);
        //将服务器状态设置到session中
        request.getSession().setAttribute(gtSdk.gtServerStatusSessionKey, gtServerStatus);
        //将userid设置到session中
        request.getSession().setAttribute("userid", userid);
        resStr = gtSdk.getResponseStr();
        print("resStr"+resStr)
        render(resStr )
    }
    /*
    * 验证验证码
    * */
    def verifyLogin(){
        GeetestLib gtSdk = new GeetestLib(GeetestConfig.getCaptcha_id(), GeetestConfig.getPrivate_key());
        String challenge = request.getParameter(GeetestLib.fn_geetest_challenge);
        String validate = request.getParameter(GeetestLib.fn_geetest_validate);
        String seccode = request.getParameter(GeetestLib.fn_geetest_seccode);
        //从session中获取gt-server状态
        int gt_server_status_code = (Integer) request.getSession().getAttribute(gtSdk.gtServerStatusSessionKey);
        //从session中获取userid
        String userid = (String)request.getSession().getAttribute("userid");
        int gtResult = 0;
        if (gt_server_status_code == 1) {
            //gt-server正常，向gt-server进行二次验证
            gtResult = gtSdk.enhencedValidateRequest(challenge, validate, seccode, userid);
            System.out.println(gtResult);
        } else {
            // gt-server非正常情况下，进行failback模式验证
            System.out.println("failback:use your own server captcha validate");
            gtResult = gtSdk.failbackValidateRequest(challenge, validate, seccode);
            System.out.println(gtResult);
        }
        if (gtResult == 1) {
            // 验证成功
            render(contentType: "application/json") {
                status ="success"
                version=gtSdk.getVersionInfo()
            }
        }
        else {
            // 验证失败
            render(contentType: "application/json") {
                status ="fail"
                version=gtSdk.getVersionInfo()
            }
        }
    }
    /*退出登陆*/
    def loginOut = {
        session.invalidate()
        redirect(uri: "/")
    }

}
