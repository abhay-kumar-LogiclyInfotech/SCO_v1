import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_advanced_switch.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/forgot_password/forgot_password_view.dart';
import 'package:sco_v1/view/main_view.dart';
import 'package:sco_v1/viewModel/authentication/login_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/response/status.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../viewModel/services/navigation_services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with MediaQueryMixin<LoginView> {
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  bool _isArabic = false;
  final _languageController = ValueNotifier<bool>(false);
  bool _isLoading = true; // State to track loading

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  Future<void> getInitialLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? language = preferences.getString('language_code');
    debugPrint(language);

    if (language != null && language == 'ar') {
      _isArabic = true;
      _languageController.value = true;
    } else {
      _isArabic = false;
      _languageController.value = false;
    }

    setState(() {
      _isLoading = false; // Set loading to false after initialization
    });
  }

  //Fetching the Device information:
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'id': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'patchVersion': data.patchVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'userName': data.userName,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'buildNumber': data.buildNumber,
      'platformId': data.platformId,
      'csdVersion': data.csdVersion,
      'servicePackMajor': data.servicePackMajor,
      'servicePackMinor': data.servicePackMinor,
      'suitMask': data.suitMask,
      'productType': data.productType,
      'reserved': data.reserved,
      'buildLab': data.buildLab,
      'buildLabEx': data.buildLabEx,
      'digitalProductId': data.digitalProductId,
      'displayVersion': data.displayVersion,
      'editionId': data.editionId,
      'installDate': data.installDate,
      'productId': data.productId,
      'productName': data.productName,
      'registeredOwner': data.registeredOwner,
      'releaseId': data.releaseId,
      'deviceId': data.deviceId,
    };
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
        TargetPlatform.linux =>
          _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
        TargetPlatform.windows =>
          _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
        TargetPlatform.macOS =>
          _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
        TargetPlatform.fuchsia => <String, dynamic>{
            'Error:': 'Fuchsia platform isn\'t supported'
          },
      };
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
      debugPrint(_deviceData['id']);
    });
  }

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();
    initPlatformState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInitialLanguage();
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.scoThemeColor),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/login_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: orientation == Orientation.portrait
                  ? screenHeight / 3
                  : screenHeight / 3,
            ),
            padding: EdgeInsets.only(
              left: orientation == Orientation.portrait
                  ? screenWidth * 0.08
                  : screenWidth / 100,
              right: orientation == Orientation.portrait
                  ? screenWidth * 0.08
                  : screenWidth / 100,
              top: orientation == Orientation.portrait
                  ? screenWidth * 0.05
                  : screenWidth / 100 * 5,
              bottom: orientation == Orientation.portrait
                  ? screenWidth / 100 * 1
                  : screenWidth / 100 * 1,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.elliptical(60, 60)),
            ),
            child: Column(
              children: [
                SizedBox(
                    child: SvgPicture.asset(
                  "assets/sco_logo.svg",
                  fit: BoxFit.fill,
                  height: 55,
                  width: 110,
                )),
                Expanded(
                  child: Consumer<LanguageChangeViewModel>(
                    builder: (context, provider, _) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            //email Address Field;
                            _emailAddressField(provider),
                            const SizedBox(height: 20),
                            //_passwordField
                            _passwordField(provider),
                            const SizedBox(height: 10),

                            //forgot password field:
                            _forgotPasswordLink(provider),
                            const SizedBox(height: 40),
                            //Login Button:
                            _loginButton(provider),
                            const SizedBox(height: 20),
                            //giving or option:
                            _or(),
                            const SizedBox(height: 20),
                            //sign in with Uae Pass button:
                            _signInWithUaePassButton(provider),
                            const SizedBox(height: 16),
                            //sign up link:
                            _signUpLink(provider),
                            const SizedBox(height: 23),
                            //Change Language:
                            _selectLanguage(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailAddressField(LanguageChangeViewModel provider) {
    return CustomTextField(
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _passwordFocusNode,
      controller: _usernameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.idEmailOrMobile,
      textInputType: TextInputType.emailAddress,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {},
    );
  }

  Widget _passwordField(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _obscurePassword,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            currentFocusNode: _passwordFocusNode,
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.password,
            textInputType: TextInputType.text,
            leading: SvgPicture.asset(
              "assets/lock.svg",
              // height: 18,
              // width: 18,
            ),
            obscureText: obscurePassword,
            trailing: GestureDetector(
                onTap: () {
                  _obscurePassword.value = !_obscurePassword.value;
                },
                child: obscurePassword
                    ? const Icon(
                        Icons.visibility_off_rounded,
                        color: AppColors.darkGrey,
                      )
                    : const Icon(
                        Icons.visibility_rounded,
                        color: AppColors.darkGrey,
                      )),
            onChanged: (value) {},
          );
        });
  }

  Widget _forgotPasswordLink(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                //Implement Forgot Password link here:
                _navigationServices.pushCupertino(CupertinoPageRoute(
                    builder: (context) => const ForgotPasswordView()));
              },
              child: Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: const TextStyle(
                  color: AppColors.scoButtonColor,
                  fontSize: 14,
                ),
              ))
        ],
      ),
    );
  }

  Widget _loginButton(LanguageChangeViewModel langProvider) {
    return ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Consumer<LoginViewModel>(builder: (context, provider, _) {
          return CustomButton(
            textDirection: getTextDirection(langProvider),
            buttonName: AppLocalizations.of(context)!.login,
            isLoading:
                provider.apiResponse.status == Status.LOADING ? true : false,
            onTap: () async {
              bool validateFields = _validateFields(langProvider: langProvider);
              if (validateFields) {
                provider.username = _usernameController.text;
                provider.password = _passwordController.text;
                provider.deviceId = _deviceData['id'];

                bool result = await provider.login(
                    context: context, langProvider: langProvider);
                if (result) {
                  //Navigate to MainView after successful login
                  _navigationServices.goBack();
                  _navigationServices.pushReplacementCupertino(
                      CupertinoPageRoute(
                          builder: (context) => const MainView()));
                }
              }
            },
            fontSize: 16,
            buttonColor: AppColors.scoButtonColor,
            elevation: 1,
          );
        }));
  }

  Widget _or() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          AppLocalizations.of(context)!.or,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }

  Widget _signInWithUaePassButton(LanguageChangeViewModel provider) {
    return CustomButton(
      textDirection: getTextDirection(provider),
      buttonName: "Sign in with UAE PASS",
      isLoading: false,
      onTap: () {},
      fontSize: 16,
      buttonColor: Colors.white,
      borderColor: Colors.black,
      textColor: Colors.black,
      elevation: 1,
      leadingIcon: const Icon(Icons.fingerprint),
    );
  }

  Widget _signUpLink(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.dontHaveAccount,
            style: const TextStyle(
                color: AppColors.scoButtonColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            //Implement signup link here:
            onTap: () {
              _navigationServices.pushNamed('/signUpView');
            },
            child: Text(
              AppLocalizations.of(context)!.signUp,
              style: const TextStyle(
                  color: AppColors.scoThemeColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectLanguage() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("English"),
        const SizedBox(
          width: 10,
        ),
        CustomAdvancedSwitch(
          controller: _languageController,
          activeColor: AppColors.scoThemeColor,
          inactiveColor: Colors.grey,
          initialValue: _isArabic,
          onChanged: (value) {
            if (value) {
              Provider.of<LanguageChangeViewModel>(context, listen: false)
                  .changeLanguage(const Locale('ar'));
            } else {
              Provider.of<LanguageChangeViewModel>(context, listen: false)
                  .changeLanguage(const Locale('en'));
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        const Directionality(
            textDirection: TextDirection.rtl, child: Text("عربي")),
      ],
    );
  }

  bool _validateFields({required LanguageChangeViewModel langProvider}) {
    if (_usernameController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Username can't be empty ",
          context: context,
          provider: langProvider);

      return false;
    }

    if (_passwordController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Password can't be empty",
          context: context,
          provider: langProvider);

      return false;
    }
    return true;
  }
}
