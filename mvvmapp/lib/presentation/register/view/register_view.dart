import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvmapp/app/dependency_injection.dart';
import 'package:mvvmapp/app/extensions.dart';
import 'package:mvvmapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:mvvmapp/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:mvvmapp/presentation/resources/color_manager.dart';
import 'package:mvvmapp/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel =
      getItInstance<RegisterViewModel>();
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _registerViewModel.start();
    _userNameController.addListener(() {
      _registerViewModel.setUserName(_userNameController.text);
    });

    _mobileNumberController.addListener(() {
      _registerViewModel.setMobileNumber(_mobileNumberController.text);
    });
    _emailController.addListener(() {
      _registerViewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _registerViewModel.setPassword(_passwordController.text);
    });
    _registerViewModel.isRegisteredInController.stream.listen((isLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacementNamed(Routes.main);
        }
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContent(), () {
                _registerViewModel.register();
              }) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                child: Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _registerViewModel.outIsUsernameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.username,
                        labelText: AppStrings.username,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.usernameEmpty,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (value) {
                            _registerViewModel
                                .setCountryCode(value.dialCode ?? "+20");
                          },
                          initialSelection: "+20",
                          favorite: const ["+20", "+39", "FR", "+966"],
                          showCountryOnly: true,
                          hideMainText: true,
                          showOnlyCountryWhenClosed: true,
                        )),
                    Expanded(
                      flex: 4,
                      child: StreamBuilder<bool>(
                        stream: _registerViewModel.outIsMobileNumberValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _mobileNumberController,
                            decoration: InputDecoration(
                              hintText: AppStrings.mobileNumber,
                              labelText: AppStrings.mobileNumber,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.mobileNumber +
                                      AppStrings.emptyField,
                            ),
                            keyboardType: TextInputType.phone,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _registerViewModel.outIsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.email,
                        labelText: AppStrings.email,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.emailEmpty,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _registerViewModel.outIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordEmpty,
                      ),
                      obscureText: true,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),

              /// Profile Picture
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                ),
                child: Container(
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(
                      color: ColorManager.grey,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _getMediaWidget(),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _registerViewModel.outIsRegisterButtonEnabled,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: snapshot.data ?? false
                            ? () {
                                _registerViewModel.register();
                              }
                            : null,
                        child: const Text(
                          AppStrings.register,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                  vertical: AppPadding.p8,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: Text(
                    AppStrings.alreadyMember,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profilePicture)),
          Flexible(
              child: StreamBuilder<File>(
            stream: _registerViewModel.outProfilePicture,
            builder: (context, snapshot) {
              return _pickedImage(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.cameraIcon)),
        ],
      ),
    );
  }

  Widget _pickedImage(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppStrings.camera),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _imageFromCamera();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AppStrings.gallery),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _imageFromGallery();
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  _imageFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    _registerViewModel.setProfilePicture(File(image?.path.nonNullable ?? ""));
  }

  _imageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(File(image?.path.nonNullable ?? ""));
  }
}
