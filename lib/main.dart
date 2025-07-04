import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:socialx/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:socialx/core/secrets/app_secrets.dart';
import 'package:socialx/core/theme/theme.dart';
import 'package:socialx/features/ai_image_generate/presentation/bloc/image_bloc.dart';
import 'package:socialx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:socialx/features/auth/presentation/pages/signin_page.dart';
import 'package:socialx/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:socialx/features/blog/presentation/pages/blog_page.dart';
import 'package:socialx/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:socialx/init_dependancy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppSecrets.stripePublishableKey;
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
        BlocProvider(create: (_) => serviceLocator<PaymentBloc>()),
        BlocProvider(create: (_) => serviceLocator<ImageBloc>()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const SignInPage();
        },
      ),
    );
  }
}






// // abstraction hiding complex imlementation details and showing only essential features
// abstract class NotificationService {
//   void sendNotifications(String msg);
// }
// //open/closed principle: this class is open for extension but closed for modification

// // concrete implementations
// class EmailNotification implements NotificationService { // inheritance

//   @override 
//   void sendNotifications(String msg) {
//     print("Email notification : $msg"); //single responsibility principle: this class is only responsible for sending email notifications
//   }
// }

// class SMSNotification implements NotificationService { // inheritance

//   @override
//   void sendNotifications(String msg) {
//     print("SMS notification send : $msg");
//   }
// }

// class PushNotification implements NotificationService { // inheritance
//   @override
//   void sendNotifications(String msg) {
//     print("Push notification msg: $msg");
//   }
// }

// //liskov substitution principle: all concrete implementations can be used interchangeably

// //interface segregation principle: NotificationService interface is small and focused, allowing for easy implementation without unnecessary methods
// class NotificationManager {
//   final NotificationService service; // dependancy inversion-> depends on notifiationservice on abstraction not on a concreations 
//   NotificationManager(this.service); 

//   void notify(String msg) {
//     service.sendNotifications(msg); // polymorphism: NotificationManager can work with any NotificationService implementation
//   }
// }


// void main() {
//   final emailService = EmailNotification();
//   final smsService = SMSNotification();
//   final pushService = PushNotification();

//   final emailManager = NotificationManager(emailService);
//   final smsManager = NotificationManager(smsService);
//   final pushManager = NotificationManager(pushService);

//   emailManager.notify("Welcome to our platform!");
//   smsManager.notify("Your OTP is 123456");
//   pushManager.notify("New message received!");
// }

// //enca