import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/base/base_view.dart';
import '../../core/init/extensions/context_extension.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/services/google_signin.dart';
import '../../core/widgets/locale_text.dart';
import '../widgets/base_app_bar.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ProfileViewModel viewModel) =>
          Scaffold(
        appBar: BaseAppBar(
          title: LocaleText(
            value: LocaleKeys.profile_appBarTitle,
            style: TextStyle(fontSize: 28),
          ),
          widgets: [
            IconButton(
                icon: Icon(FontAwesomeIcons.signOutAlt),
                splashColor: Colors.transparent,
                onPressed: () async {
                  await GoogleSignHelper.instance.signOut();
                  viewModel.navigateToOnboardPage();
                }),
          ],
        ),
        body: buildGoogleInfo(viewModel, context),
      ),
    );
  }

  Container buildGoogleInfo(ProfileViewModel viewModel, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 10),
          CircleAvatar(
            maxRadius: 50,
            backgroundImage: NetworkImage(viewModel.user.photoURL),
          ),
          SizedBox(height: 10),
          Text(
            viewModel.user.displayName,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.secondary,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            viewModel.user.email,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: context.colors.primary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
