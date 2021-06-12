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
        buildGoogleInfo(viewModel, context),
        ListData(
            function: statusService.getLinkWithQuery('deleted', true),
            page: 'profile')
      ],
    );
  }

  Expanded buildGoogleInfo(ProfileViewModel viewModel, BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          SizedBox(
            height: context.mediumValue,
          ),
          buildCircleAvatar(viewModel),
          SizedBox(
            height: context.normalValue,
          ),
          buildDisplayname(viewModel, context),
          SizedBox(
            height: context.lowValue,
          ),
          buildEmail(viewModel, context),
          SizedBox(
            height: context.mediumValue,
          ),
          buildHistoryText(context),
        ],
      ),
    );
  }

  Container buildHistoryText(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(30, context.normalValue, 0, 0),
        child: LocaleText(
          value: LocaleKeys.profile_history,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.colors.primary),
        ));
  }

  Text buildEmail(ProfileViewModel viewModel, BuildContext context) {
    return Text(
      viewModel.user.email,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: context.colors.primary, fontSize: 16),
    );
  }

  Text buildDisplayname(ProfileViewModel viewModel, BuildContext context) {
    return Text(
      viewModel.user.displayName,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.secondary,
          ),
    );
  }

  CircleAvatar buildCircleAvatar(ProfileViewModel viewModel) {
    return CircleAvatar(
      maxRadius: 50,
      backgroundImage: NetworkImage(viewModel.user.photoURL),
    );
  }
}
