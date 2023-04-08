import 'package:app/module/common/commonbloc.dart';
import 'package:app/module/influencer/challenges/cubit/badges_bloc/badgesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_detail_bloc/challengesdetailbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/comments_bloc/commentsbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/participants_bloc/participants_bloc_cubit.dart';
import 'package:app/module/influencer/income_analytics/bloc/dashboard_data_bloc.dart';
import 'package:app/module/influencer/income_analytics/repo/income_graph_repo.dart';
import 'package:app/module/influencer/more/bloc/cubit/promobloc_cubit.dart';
import 'package:app/module/influencer/more/bloc/suggestion_bloc/suggestionbloc_cubit.dart';
import 'package:app/module/influencer/subscribers/bloc/subscriber_bloc.dart';
import 'package:app/module/influencer/subscribers/repo/subscribers_repo.dart';
import 'package:app/module/influencer/workout/bloc/about_me_bloc/aboutmebloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc/blogbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/favorite_ingre_bloc/favorite_cubit.dart';
import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/favoritemealbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/influencer/get_influencer_bloc.dart';
import 'package:app/module/influencer/workout/bloc/influencer_bloc.dart' as bl;
import 'package:app/module/influencer/workout/bloc/meal_bloc/mealbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/nutrients_bloc/nutrientsbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/social_links_bloc/sociallinksbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/tags/tags_bloc.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/workout_dashboard_bloc/workoutdashboardbloc_cubit.dart';
import 'package:app/module/influencer/workout/repo/get_infuencer_repo.dart';
import 'package:app/module/influencer/workout/repo/get_tags.dart';
import 'package:app/module/influencer/workout_programs/repo/workout_program_repo.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/bloc/exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/day_bloc/daybloc_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/week_bloc/week_bloc_bloc.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/module/user/community/bloc/friends/friends_bloc.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/bloc/influencer_screen_cubit.dart';
import 'package:app/module/user/home/sub_screen/influencer_suggestion/bloc/influencer_suggestion_cubit.dart';
import 'package:app/module/user/meals/bloc/dashboard_meals_bloc.dart';
import 'package:app/module/user/profile/sub_screen/in_active_subscription/bloc/payment_method_cubit.dart';
import 'package:app/module/user/user_info/cubit/user_info_cubit.dart';
import 'package:app/module/user/workout_programs/bloc/full_screen_bloc.dart';
import 'package:app/package/bloc_route.dart';
import 'package:app/utils/default_size_handler.dart';
import 'package:app/utils/enums.dart' as enums;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../user/community/bloc/friends/community_follow_bloc.dart';
import '../user/community/bloc/friends/friend_detail_bloc.dart';
import '../user/community/view/challenges/bloc/community_challenges_cubit.dart';
import '../user/home/bloc/home_view_cubit.dart';
import '../user/influencer_listing/bloc/influencer_listing_cubit.dart';
import '../user/influencer_workout_listing/bloc/influencer_workout_cubit.dart';
import '../user/meals/bloc/meal_cubit.dart';
import '../user/profile/sub_screen/privacy_settings/privacy_settings_bloc.dart';
import '../user/workout_programs/bloc/user_workout_bloc.dart';
import 'income_analytics/income_bloc/income_graph_bloc.dart';
import 'my_app.dart';
import 'views_analytics/bloc/views_graph_bloc.dart';
import 'views_analytics/repo/views_graph_repo.dart';
import 'workout/bloc/nutrient_bloc.dart';
import 'workout_programs/view/add_exercise/single_work_out/bloc/single_work_exersise_bloc.dart';

class InitialiseBlocs extends StatelessWidget {
  const InitialiseBlocs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LanguageBloc(enums.Language.ENGLISH)),
          BlocProvider(create: (_) => OnboardingBloc(enums.Screens.Screen_1)),
          BlocProvider(create: (_) => BottomNavBloc(enums.Action.DASHBOARD)),
          BlocProvider(create: (_) => LinkBloc([])),
          BlocProvider(create: (_) => BlogBloc([])),
          BlocProvider(create: (_) => NutrientBloc([])),
          BlocProvider(create: (_) => bl.InfluencerBloc(InfluencerInfo())),
          BlocProvider(create: (_) => DashboardDataBloc(DashboardDataRepo())),
          BlocProvider(create: (_) => ViewsGraphBloc(ViewsGraphRepo())),
          BlocProvider(create: (_) => IncomeGraphBloc(ViewsGraphRepo())),
          // BlocProvider(create: (_) => ViewsGraphBloc(ViewsGraphRepo())),
          BlocProvider(create: (_) => SubscriberBloc(SubscriberRepo())),
          BlocProvider(
              create: (_) =>
                  GetInfluencerBloc(getInfluencerRepo: GetInfluencerRepo())),
          BlocProvider(create: (_) => TagsBloc(tagsRepo: TagsRepo())),
          BlocProvider(create: (_) => ChallengesCubit()),
          BlocProvider(create: (_) => ChallengesblocCubit()),
          BlocProvider(create: (_) => SingleWorkOutCubit()),
          BlocProvider(create: (_) => ParticipantsBlocCubit()),
          BlocProvider(create: (_) => InfluencerSuggestionCubit()),
          BlocProvider(create: (_) => BadgesblocCubit()),
          BlocProvider(create: (_) => InfluencerScreenCubit()),
          BlocProvider(create: (_) => SuggestionblocCubit()),
          BlocProvider(create: (_) => ChallengesdetailblocCubit()),
          BlocProvider(create: (_) => ExerciseCubit()),
          BlocProvider(create: (_) => FavoriteCubit()),
          BlocProvider(create: (_) => WorkoutdashboardblocCubit()),
          BlocProvider(create: (_) => PromoblocCubit()),
          BlocProvider(create: (_) => CommentsblocCubit()),
          BlocProvider(create: (_) => FavoritemealblocCubit()),
          BlocProvider(create: (_) => AboutmeblocCubit()),
          BlocProvider(create: (_) => TagsblocCubit()),
          BlocProvider(create: (_) => SociallinksblocCubit()),
          BlocProvider(create: (_) => BlogblocCubit()),
          BlocProvider(create: (_) => NutrientsblocCubit()),
          BlocProvider(create: (_) => MealblocCubit()),
          // BlocProvider(create: (_) => SuggestionCubit(const MoreRepository())),
          BlocProvider(
            create: (_) => WorkoutProgramBloc(WorkoutProgramRepo()),
          ),
          BlocProvider(
            create: (_) => SubscriberBloc(SubscriberRepo()),
          ),
          BlocProvider(create: (_) => ChallengesCubit()),
          BlocProvider(
            create: (_) => WorkoutProgramBloc(WorkoutProgramRepo()),
          ),
          BlocProvider(create: (_) => WeekBlocBloc(WorkoutProgramRepo())),
          BlocProvider(create: (_) => DayblocBloc(WorkoutProgramRepo())),
          BlocProvider(create: (_) => PaymentMethodCubit()),
          BlocProvider(create: (_) => HomeViewCubit()),
          BlocProvider(create: (_) => InfluencerWorkoutCubit()),
          BlocProvider(create: (_) => CommonBloc(null)),
          BlocProvider(create: (_) => FriendsBloc()),
          BlocProvider(create: (_) => FriendDetailBloc()),
          BlocProvider(create: (_) => CommunityFollowBloc()),
          BlocProvider(create: (_) => PrivacySettingsBloc(null)),
          BlocProvider(create: (_) => DashboardMealsBloc()),
          BlocProvider(create: (_) => CommunityChallengesCubit()),
          BlocProvider<UserInfoCubit>(create: (_) => UserInfoCubit()),
          BlocProvider<MealCubit>(create: (_) => MealCubit()),
          BlocProvider<UserWorkoutBloc>(create: (_) => UserWorkoutBloc()),
          BlocProvider<FullScreenBloc>(create: (_) => FullScreenBloc()),
          BlocProvider<InfluencerListingCubit>(
              create: (_) => InfluencerListingCubit()),
        ],
        child: DefaultSizeInit(
          builder: () => const MyApp(),
        ),
      ),
    );
  }
}
