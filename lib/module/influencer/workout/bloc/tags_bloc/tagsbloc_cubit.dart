import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/repo/get_tags.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'tagsbloc_state.dart';

class TagsblocCubit extends Cubit<TagsblocState> {
  TagsblocCubit() : super(TagsblocInitial());
  TagsRepo tagsRepo = TagsRepo();

  final RefreshController _tagsRefCont = RefreshController();
  RefreshController get tagsRefCont => _tagsRefCont;
  int pageNumber = 1;
  TagsModel? _tagsMod;
  getTags({bool initial = true}) async {
    pageNumber++;
    if (initial) {
      pageNumber = 1;
    }
    TagsModel? _tagsModel = await tagsRepo.getAllTags(pageNumber: pageNumber);
    if (initial) {
      _tagsMod = _tagsModel;
      emit(TagsLoaded(tagsModel: _tagsModel));
    } else if (_tagsModel != null &&
        _tagsModel.responseDetails?.data?.isEmpty == false) {
      TagsModel data = _tagsMod!;
      data.responseDetails!.data = [
        ..._tagsMod!.responseDetails!.data ?? [],
        ..._tagsModel.responseDetails?.data ?? []
      ];
      data.responseDetails!.currentPage = pageNumber;
      _tagsRefCont.loadComplete();
      emit(TagsLoaded(tagsModel: data));
    } else {}
  }
}
