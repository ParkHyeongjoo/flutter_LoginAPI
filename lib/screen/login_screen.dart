import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAutoLogin = false;

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    }catch(error){
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xffffa502)
          ),
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text('Sign In', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
                          SizedBox(height: 4,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: Color(0xffffc473),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                icon: Icon(Icons.mail_outline_outlined, color: Colors.white,),
                                hintText: 'Enter your Email',
                                hintStyle: TextStyle(color: Colors.grey.shade500),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
                          SizedBox(height: 4,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: Color(0xffffc473),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                icon: Icon(Icons.key_outlined, color: Colors.white,),
                                hintText: 'Enter your Password',
                                hintStyle: TextStyle(color: Colors.grey.shade500),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Forgot Password?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(value: _isAutoLogin, onChanged: (value){
                          setState(() {
                            _isAutoLogin = value!;
                          });
                        },
                          side: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          checkColor: Colors.white,
                          activeColor: Color(0xff06bbfb),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),
                        Text('자동로그인', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('LOGIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xfffffa502)),)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Text('- OR -', style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Text('Sing in with', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () async{
                        if(await isKakaoTalkInstalled()){
                          try{
                            await UserApi.instance.loginWithKakaoTalk();
                            print('카카오톡으로 로그인 성공');
                            _get_user_info();
                          }catch(error){
                            print('카카오톡으로 로그인 실패 $error');

                            try{
                              await UserApi.instance.loginWithKakaoAccount();
                              print('카카오계정으로 로그인 성공');
                              _get_user_info();
                            }catch(error){
                              print('카카오계정으로 로그인 실패 $error');
                            }
                          }
                        }else{
                          try{
                            await UserApi.instance.loginWithKakaoAccount();
                            print('카카오계졍으로 로그인 성공');
                            _get_user_info();
                          }catch(error){
                            print('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      },
                      child: Container(
                        child: Image.asset('assets/kakao_login_medium_narrow.png', ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an Account?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                        SizedBox(width: 5,),
                        Text('Sign up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
