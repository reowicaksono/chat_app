import 'dart:async';
import 'dart:io';

import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app/src/core/utils/constants/app_constant.dart';
import 'package:chat_app/src/env/env_prod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:chat_app/src/core/helper/dialog/alert_dialog.dart';
import 'package:chat_app/src/core/helper/dialog/show_dialog.dart';
import 'package:chat_app/src/core/helper/textformfield/textformfield.dart';
import 'package:chat_app/src/shared/presentation/components/usertile/user_tile.dart';
// import 'package:chat_app/src/core/helper/users_firestore/get_user.dart';
import 'package:chat_app/src/core/utils/preferences/app_preferences.dart';
import 'package:chat_app/src/core/utils/styles/app_styles.dart';
import 'package:chat_app/src/shared/domain/service/auth_service.dart';
import 'package:chat_app/src/shared/domain/service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:chat_app/src/shared/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/core/utils/constants/app_routes.dart' as Approute;
import 'package:chat_app/src/core/common/navigation.dart';
import 'package:chat_app/src/core/utils/preferences/app_preferences.dart';

import 'package:image_picker/image_picker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

part 'auth/login_page.dart';
part 'auth/signup_page.dart';
part 'splashscreen/splash_screen.dart';
part 'wrapper.dart';
part 'dashboard/dashboard_screen.dart';
part 'onboarding/onboarding.dart';

part 'dashboard/home/home_screen.dart';
part 'dashboard/home/chat/chat_screen.dart';
part 'dashboard/home/video_call/video_call.dart';
part 'dashboard/profile/profile_screen.dart';
part 'dashboard/settings/settings_screen.dart';
