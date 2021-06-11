import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/base/base_view.dart';
import '../../../core/init/extensions/context_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/services/google_signin.dart';
import '../../../core/widgets/locale_text.dart';
import '../../widgets/base_app_bar.dart';
import '../../widgets/list_fire_data.dart';
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
          title: LocaleKeys.profile_appBarTitle,
          widgets: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    await GoogleSignHelper.instance.signOut();
                    viewModel.navigateToOnboardPage();
                  }),
            ),
          ],
        ),
        body: buildBody(viewModel, context),
      ),
    );
  }

  Column buildBody(ProfileViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              buildGoogleInfo(viewModel, context),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(30, 50, 0, 20),
                  child: LocaleText(
                    value: LocaleKeys.profile_history,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.colors.primary),
                  )),
            ],
          ),
        ),
        ListData(
            function: statusService.getLinkWithQuery('deleted', true),
            page: 'profile')
      ],
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
