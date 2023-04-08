import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout_programs/model/AddExerciseSingleWTimeRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/AddWorkoutPlanRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_long_video_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_long_video_response.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_single_workout_tResponse.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_day%20_response.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_plan_response.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_response.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/get_week_all_days_workouts_response.dart';
import 'package:app/module/influencer/workout_programs/model/get_workout_all_weeks_response.dart';
import 'package:app/module/influencer/workout_programs/model/get_workout_plan_response.dart';
import 'package:app/module/influencer/workout_programs/model/update_workout_program_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_prerequisites_response.dart';
import 'package:app/module/influencer/workout_programs/repo/workout_program_repo.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/mixins.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../repo/repository/web_service.dart';

part 'week_bloc_event.dart';
part 'week_bloc_state.dart';

class WeekBlocBloc extends Bloc<WeekBlocEvent, WeekBlocState> {
  final WorkoutProgramRepo _workoutProgramRepo;
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  WeekBlocBloc(this._workoutProgramRepo) : super(WeekBlocInitial()) {
    // on<WorkoutPrerequisitesLoadingEvent>((event, emit) => emit(AddWorkoutLoadingState()));
    on<SetStateEvent>((event, emit) async {
      emit(SetStateState());
    });
    on<WorkoutPrerequisitesLoadedEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.getWorkoutPrerequisites();

          if (response != null) {
            WorkoutPrerequisitesListResponse workoutPrerequisitesListResponse =
                WorkoutPrerequisitesListResponse.fromJson(
                    jsonDecode(response.toString()));

            if (workoutPrerequisitesListResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(WorkoutPrerequisitesLoadedState(
                  workoutPrerequisitesListResponse:
                      workoutPrerequisitesListResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          print("exception ${e.toString()}");
          emit(ErrorState(error: e.toString()));
        }
      }
    });
    // on<AddWorkoutProgramEvent>((event, emit) async {
    //   emit(LoadingState());
    //   var isInternetConnected = await checkInternetConnectivity();
    //   if (isInternetConnected == false) {
    //     emit(InternetErrorState(error: 'Internet not connected'));
    //   } else {
    //     try {
    //       dynamic response = await _workoutProgramRepo.addWorkoutProgram(
    //           addWorkoutPlanRequestModel: event.addWorkoutPlanRequestModel);
    //       print('>>>>>>>>>>>>>11');

    //       if (response != null) {
    //         print('>>>>>>>>>>>>>12');

    //         if (event.addWorkoutPlanRequestModel.isEditing == false) {
    //           AddWorkoutPlanResponse addWorkoutPlanResponse =
    //               AddWorkoutPlanResponse.fromJson(jsonDecode(response.toString()));
    //           if (addWorkoutPlanResponse.status == 'success') {
    //             print('>>>>>>>>>>>>>13');
    //             emit(AddWorkoutProgramState(addWorkoutPlanResponse: addWorkoutPlanResponse));
    //           } else {
    //             emit(ErrorState(error: 'Error'));
    //           }
    //         } else {
    //           UpdateWorkoutProgramResponse updateWorkoutProgramResponse =
    //               UpdateWorkoutProgramResponse.fromJson(jsonDecode(response.toString()));
    //           if (updateWorkoutProgramResponse.status == 'success') {
    //             print('>>>>>>>>>>>>>13');
    //             emit(UpdateWorkoutProgramState(
    //                 updateWorkoutProgramResponse: updateWorkoutProgramResponse));
    //           } else {
    //             emit(ErrorState(error: 'Error'));
    //           }
    //         }
    //       } else {
    //         emit(ErrorState(error: 'Timeout'));
    //       }
    //     } catch (e) {
    //       // emit(ErrorState(error: 'Invalid credentials'));

    //     }
    //   }
    // });
    on<AddWorkoutWeekEvent>((event, emit) async {
      // emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          // dynamic response = await _workoutProgramRepo.addWorkoutWeekEvent(
          //     addWorkoutWeekRequestModel: event.addWorkoutWeekRequestModel);

          String urlRoute =
              '/api/user/workout/${event.addWorkoutWeekRequestModel.workoutID}/week';

          List<String> fields = [];
          List<String> paths = [];
          if (event.addWorkoutWeekRequestModel.media != null) {
            fields.add('imageVideoURL');
            paths.add(event.addWorkoutWeekRequestModel.media!.path);
          }
          String assetType = "";
          if (event.addWorkoutWeekRequestModel.assetType != null) {
            assetType = event.addWorkoutWeekRequestModel.assetType!;
          }

          Map<String, String> body = {
            'title': event.addWorkoutWeekRequestModel.workoutTitle,
            'description': event.addWorkoutWeekRequestModel.description,
            'assetType': assetType,
          };
          dynamic response = await sl
              .get<WebServiceImp>()
              .
              // postVideosPictures(
              postdioVideosPictures(
                  onUploadProgress: (p) {
                    print(((p.done / p.total) * 100).toInt());
                    if (p.done == p.total) {
                      _progressSink.add(ProgressFile(done: 0, total: 0));
                    } else {
                      _progressSink.add(p);
                    }
                  },
                  endPoint: urlRoute,
                  body: body,
                  fileKeyword: fields,
                  files: paths);

          if (response != null) {
            AddWorkoutWeekResponse addWorkoutWeekResponse =
                AddWorkoutWeekResponse.fromJson(response.data);

            if (addWorkoutWeekResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(AddWorkoutWeekState(
                  addWorkoutWeekResponse: addWorkoutWeekResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<AddWorkoutDayEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response = await _workoutProgramRepo.addWorkoutDayEvent(
              addWorkoutWeekRequestModel: event.addWorkoutWeekRequestModel);

          if (response != null) {
            AddWorkoutDayResponse addWorkoutDayResponse =
                AddWorkoutDayResponse.fromJson(jsonDecode(response.toString()));

            if (addWorkoutDayResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(AddWorkoutDayState(
                  addWorkoutDayResponse: addWorkoutDayResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<AddExerciseLongVideoEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.addExerciseLongVideoEvent(
                  addExerciseLongVideoRequestModel:
                      event.addExerciseLongVideoRequestModel);

          if (response != null) {
            AddExerciseLongVideoResponse addExerciseLongVideoResponse =
                AddExerciseLongVideoResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addExerciseLongVideoResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(AddExerciseLongVideoState(
                  addExerciseLongVideoResponse: addExerciseLongVideoResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<AddExerciseSingleWTimeEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.addExerciseSingleWTimeEvent(
                  addExerciseSingleWTimeRequestModel:
                      event.addExerciseSingleWTimeRequestModel,
                  workoutSetsList: event.workoutSetsList);

          if (response != null) {
            AddExerciseSingleWorkoutTResponse
                addExerciseSingleWorkoutTResponse =
                AddExerciseSingleWorkoutTResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addExerciseSingleWorkoutTResponse.status == 'success') {
              print('>>>>>>>>>>>>>12');
              emit(AddExerciseSingleWorkoutTState(
                  addExerciseSingleWorkoutTResponse:
                      addExerciseSingleWorkoutTResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<AddExerciseSingleWFailureEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.addExerciseSingleWTimeEvent(
                  addExerciseSingleWTimeRequestModel:
                      event.addExerciseSingleWTimeRequestModel,
                  workoutSetsList: event.workoutSetsList);

          if (response != null) {
            AddExerciseSingleWorkoutTResponse
                addExerciseSingleWorkoutTResponse =
                AddExerciseSingleWorkoutTResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addExerciseSingleWorkoutTResponse.status == 'success') {
              print('>>>>>>>>>>>>>12');
              emit(AddExerciseSingleWorkoutTState(
                  addExerciseSingleWorkoutTResponse:
                      addExerciseSingleWorkoutTResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<AddExerciseSingleWRepsEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.addExerciseSingleWTimeEvent(
                  addExerciseSingleWTimeRequestModel:
                      event.addExerciseSingleWTimeRequestModel,
                  workoutSetsList: event.workoutSetsList);

          if (response != null) {
            AddExerciseSingleWorkoutTResponse
                addExerciseSingleWorkoutTResponse =
                AddExerciseSingleWorkoutTResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addExerciseSingleWorkoutTResponse.status == 'success') {
              print('>>>>>>>>>>>>>12');
              emit(AddExerciseSingleWorkoutTState(
                  addExerciseSingleWorkoutTResponse:
                      addExerciseSingleWorkoutTResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<AddExerciseSingleWCustomEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.addExerciseSingleWTimeEvent(
                  addExerciseSingleWTimeRequestModel:
                      event.addExerciseSingleWTimeRequestModel,
                  workoutSetsList: event.workoutSetsList);

          if (response != null) {
            AddExerciseSingleWorkoutTResponse
                addExerciseSingleWorkoutTResponse =
                AddExerciseSingleWorkoutTResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addExerciseSingleWorkoutTResponse.status == 'success') {
              print('>>>>>>>>>>>>>12');
              emit(AddExerciseSingleWorkoutTState(
                  addExerciseSingleWorkoutTResponse:
                      addExerciseSingleWorkoutTResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<GetWorkoutProgramsEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.getWorkoutProgramsEvent();
          print('>>>>>>>>>>>>>127');

          if (response != null) {
            print('>>>>>>>>>>>>>126');
            GetWorkoutPlansResponse getWorkoutPlansResponse =
                GetWorkoutPlansResponse.fromJson(response);

            if (getWorkoutPlansResponse.status == 'success') {
              // for (int i = 0; i < getWorkoutPlansResponse.responseDetails.data.length; i++) {
              //   if (getWorkoutPlansResponse.responseDetails.data[i].isActive == 1) {
              //     getWorkoutPlansResponse.responseDetails.totalPublished++;
              //   } else {
              //     getWorkoutPlansResponse.responseDetails.totalUnpublished++;
              //   }
              // }
              print('>>>>>>>>>>>>>12');
              emit(GetWorkoutProgramsState(
                  getWorkoutPlansResponse: getWorkoutPlansResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<GetWorkoutWeeksEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response =
              await _workoutProgramRepo.getWorkoutWeeksEvent(id: event.id);

          if (response != null) {
            GetWorkoutAllWeeksResponse getWorkoutAllWeeksResponse =
                GetWorkoutAllWeeksResponse.fromJson(
                    jsonDecode(response.toString()));

            if (getWorkoutAllWeeksResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(GetWorkoutWeeksState(
                  getWorkoutAllWeeksResponse: getWorkoutAllWeeksResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<GetWorkoutDaysEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response = await _workoutProgramRepo.getWorkoutDaysEvent(
              id: event.id, workoutId: event.workoutId);

          if (response != null) {
            GetWeekAllDaysWorkoutsResponse getWeekAllDaysWorkoutsResponse =
                GetWeekAllDaysWorkoutsResponse.fromJson(
                    jsonDecode(response.toString()));

            if (getWeekAllDaysWorkoutsResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(GetWorkoutWeeksAllDaysState(
                  getWeekAllDaysWorkoutsResponse:
                      getWeekAllDaysWorkoutsResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<GetWorkoutExerciseEvent>((event, emit) async {
      emit(LoadingState());
      print("test");
      var isInternetConnected = await checkInternetConnectivity();
      print("heelo there");
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        print("heelo there");
        try {
          print("test");
          var response =
              await _workoutProgramRepo.getWorkoutExerciseEvent(id: event.id);

          print('>>>>>>>>>>123155');
          if (response != null) {
            print('>>>>>>>>>>123166');
            GetAllExerciseResponse getAllExerciseResponse =
                GetAllExerciseResponse.fromJson(response);
            print('>>>>>>>>>>123177');

            if (getAllExerciseResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(GetWorkoutExerciseState(
                  getAllExerciseResponse: getAllExerciseResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          emit(ErrorState(error: e.toString()));
        }
      }
    });
    on<GetWorkoutProgramsNextBackPageEvent>((event, emit) async {
      print("test");
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response = await _workoutProgramRepo
              .getWorkoutProgramsNextBackPageEvent(url: event.pageUrl);

          if (response != null) {
            GetWorkoutPlansResponse getWorkoutPlansResponse =
                GetWorkoutPlansResponse.fromJson(
                    jsonDecode(response.toString()));

            if (getWorkoutPlansResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(GetWorkoutProgramsState(
                  getWorkoutPlansResponse: getWorkoutPlansResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
    on<GetWorkoutWeeksNextBackPageEvent>((event, emit) async {
      emit(LoadingState());
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        emit(InternetErrorState(error: 'Internet not connected'));
      } else {
        try {
          dynamic response = await _workoutProgramRepo
              .getWorkoutProgramsNextBackPageEvent(url: event.pageUrl);

          if (response != null) {
            GetWorkoutAllWeeksResponse getWorkoutAllWeeksResponse =
                GetWorkoutAllWeeksResponse.fromJson(
                    jsonDecode(response.toString()));

            if (getWorkoutAllWeeksResponse.status == 'success') {
              print('>>>>>>>>>>>>>');
              emit(GetWorkoutWeeksState(
                  getWorkoutAllWeeksResponse: getWorkoutAllWeeksResponse));
            } else {
              emit(ErrorState(error: 'Error'));
            }
          } else {
            emit(ErrorState(error: 'Timeout'));
          }
        } catch (e) {
          // emit(ErrorState(error: 'Invalid credentials'));
        }
      }
    });
  }

  addWeek(AddWorkoutWeekRequestModel addWorkoutWeekRequestModel) async {
    var isInternetConnected = await checkInternetConnectivity();
    if (isInternetConnected == false) {
      emit(InternetErrorState(error: 'Internet not connected'));
    } else {
      try {
        // dynamic response = await _workoutProgramRepo.addWorkoutWeekEvent(
        //     addWorkoutWeekRequestModel: event.addWorkoutWeekRequestModel);

        String urlRoute =
            'api/user/workout/${addWorkoutWeekRequestModel.workoutID}/week';

        List<String> fields = [];
        List<String> paths = [];
        if (addWorkoutWeekRequestModel.media != null) {
          fields.add('imageVideoURL');
          paths.add(addWorkoutWeekRequestModel.media!.path);
        }
        String assetType = "";
        if (addWorkoutWeekRequestModel.assetType != null) {
          assetType = addWorkoutWeekRequestModel.assetType!;
        }

        Map<String, String> body = {
          'title': addWorkoutWeekRequestModel.workoutTitle,
          'description': addWorkoutWeekRequestModel.description,
          'assetType': assetType,
        };
        ApiResponse response = await sl
            .get<WebServiceImp>()
            .
            // postVideosPictures(
            postdioVideosPictures(
                onUploadProgress: (p) {
                  print(((p.done / p.total) * 100).toInt());
                  if (p.done == p.total) {
                    _progressSink.add(ProgressFile(done: 0, total: 0));
                  } else {
                    _progressSink.add(p);
                  }
                },
                endPoint: urlRoute,
                body: body,
                fileKeyword: fields,
                files: paths);

        print(response.data);
        print(response.status);

        if (response != null) {
          AddWorkoutWeekResponse addWorkoutWeekResponse =
              AddWorkoutWeekResponse.fromJson(response.data);

          if (addWorkoutWeekResponse.status == 'success') {
            print('>>>>>>>>>>>>>');
            emit(AddWorkoutWeekState(
                addWorkoutWeekResponse: addWorkoutWeekResponse));
          } else {
            emit(ErrorState(error: 'Error'));
          }
        } else {
          emit(ErrorState(error: 'Timeout'));
        }
      } catch (e) {
        // emit(ErrorState(error: 'Invalid credentials'));
      }
    }
  }
}
