import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_baza/assets/colors.dart';
import 'package:i_baza/assets/icons.dart';
import 'package:i_baza/features/authentication/presentation/pages/recover_password_screen.dart';
import 'package:i_baza/features/authentication/presentation/pages/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 52),
          SvgPicture.asset(AppIcons.i_baza),
          SizedBox(height: 48),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Xush kelibsiz!',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ),
           ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ma\'lumotlaringizni kiriting',
                style:
                TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
              child:

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Telefon raqam',style: TextStyle(fontSize: 16),),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: '+998',
                hintText: '99 123 45 67',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child:

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Parol',style: TextStyle(fontSize: 16),),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
                alignment: Alignment.topRight,
              children: [ TextFormField(
                decoration: InputDecoration(
                  labelText: 'Parolni kiriting',
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                  ),
                ),
              ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecoverScreen()
                        )
                    );

                  },
                  child: const Text(
                    'Unutdingizmi?',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                    ),
                  ),
                )
]
            ),
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 45,
              width: double.maxFinite,
              child: MaterialButton(
                  color: buttonColor,
                onPressed: () {
                },
                child:
                Text('Kirish'),

              ),
            ),
          ),
          SizedBox(height: 170),
          Text('Ilovada yangimisiz?'),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 43,
              width: double.maxFinite,
              child: MaterialButton(
                color: buttonColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterScreen(),
                    ),
                  );
                },
                child: Text('Ro\'yxatdan o\'tish'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
