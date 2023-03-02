import 'package:daeng_time/screen/image_carousel_screen.dart';
import 'package:daeng_time/widget/default_widgets.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAutoLogin = false;

  void _checkUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Color(0xffffa502)),
        child: Column(
          children: [
            DefaultWidgets.hugeEmptyHeight,

            DefaultWidgets.middleEmptyHeight,

            const Text('Sign In', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),

            // _InputBox('Email', const Icon(Icons.mail_outline_outlined, color: Colors.white,), 'Enter your Email', false),
            _createInputBox('Email', const Icon(Icons.mail_outline_outlined, color: Colors.white,), 'Enter your Email', false),

            _createInputBox('Password', const Icon(Icons.key_outlined, color: Colors.white,), 'Enter your Password', true),

            const SizedBox(height: 16,),

            Align(alignment: Alignment.centerRight, child: Text('Forgot Password?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: const [
            //     Text('Forgot Password?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
            //   ],
            // ),
            Row(children: <Widget>[
                Checkbox(
                  value: _isAutoLogin,
                  onChanged: (value) {
                    setState(() {
                      _isAutoLogin = value!;
                    });
                  },
                  side: const BorderSide(color: Colors.white, width: 1.5,),
                  checkColor: Colors.white,
                  activeColor: const Color(0xff06bbfb),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                ),
                const Text('자동로그인', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20,),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImageCarouselScreen()));
              },
              child: const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xffffa502)),
              ),
            ),

            const SizedBox(height: 20,),
            const Text('- OR -',style: TextStyle(color: Colors.white, fontSize: 16),),
            const SizedBox(height: 20,),
            const Text('Sing in with',style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),

            InkWell(
              splashColor: Colors.red,
              onTap: _handleKakaoClicked,
              child: Container(
                child: Image.asset('assets/kakao_login_medium_narrow.png',),
              ),
            ),

            const Spacer(),

            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Don\'t have an Account?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),),
                      SizedBox(width: 5,),
                      Text('Sign up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _createInputBox(String label, Widget icon, String hint, bool obscureText) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
          const SizedBox(height: 4,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xffffc473),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              obscureText: obscureText,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: icon,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleKakaoClicked() async {

    // use bloc
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        _checkUserInfo();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공 ${token.accessToken}');
          _checkUserInfo();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계졍으로 로그인 성공');
        _checkUserInfo();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}

class _InputBox extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Widget icon;
  final String hint;

  _InputBox(this.label, this.icon, this.hint, this.obscureText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
          const SizedBox(height: 4,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xffffc473),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              obscureText: obscureText,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: icon,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
