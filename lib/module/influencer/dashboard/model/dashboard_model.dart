class DashboardModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;
  ResponseDetailsIncome? responseDetailsIncome;
  bool? isIncome = false;

  DashboardModel({
    this.status,
    this.responseCode,
    this.responseDescription,
    this.responseDetails,
  });

  DashboardModel.fromJson(Map<String, dynamic> json, {bool? isIncome}) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    if (isIncome == true) {
      responseDetailsIncome = json['responseDetails'] != null
          ? new ResponseDetailsIncome.fromJson(json['responseDetails'])
          : null;
    } else {
      responseDetails = json['responseDetails'] != null
          ? new ResponseDetails.fromJson(json['responseDetails'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['responseDescription'] = this.responseDescription;
    if (this.responseDetails != null) {
      data['responseDetails'] = this.responseDetails!.toJson();
    }
    if (this.responseDetailsIncome != null) {
      data['responseDetails'] = this.responseDetailsIncome!.toJson();
    }
    return data;
  }
}

class ResponseDetailsIncome {
  IncomeChart? data;
  TotalObj? totalObj;

  ResponseDetailsIncome({this.data, this.totalObj});

  ResponseDetailsIncome.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null && (json['data'] as List).isNotEmpty)
        ? new IncomeChart.fromJson(json['data'])
        : null;

    if (json['total'] != null) {
      if (json['total'] is String) {
        totalObj = json['total'];
      } else if ((json['total'] as List).isNotEmpty) {
        totalObj =
            json['total'] != null ? new TotalObj.fromJson(json['total']) : null;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    if (this.totalObj != null) {
      data['total'] = this.totalObj!.toJson();
    }

    return data;
  }
}

class ResponseDetails {
  IncomeChart? incomeChart;
  Views? views;
  List<InfluencerInfoWithsubscribers>? influencerInfoWithsubscribers;
  WorkoutStats? workoutStats;
  Views? data;
  String? total;
  TotalObj? totalObj;

  ResponseDetails(
      {this.incomeChart,
      this.views,
      this.influencerInfoWithsubscribers,
      this.workoutStats});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    incomeChart = (json['incomeChart'] != null)
        ? new IncomeChart.fromJson(json['incomeChart'])
        : null;
    views = json['views'] != null ? new Views.fromJson(json['views']) : null;
    if (json['influencerInfoWithsubscribers'] != null) {
      influencerInfoWithsubscribers = <InfluencerInfoWithsubscribers>[];
      json['influencerInfoWithsubscribers'].forEach((v) {
        influencerInfoWithsubscribers!
            .add(new InfluencerInfoWithsubscribers.fromJson(v));
      });
    }
    workoutStats = json['workoutStats'] != null
        ? new WorkoutStats.fromJson(json['workoutStats'])
        : null;
    data = (json['data'] != null && (json['data'] as List).isNotEmpty)
        ? new Views.fromJson(json['data'])
        : null;

    if (json['total'] != null) {
      if (json['total'] is String) {
        total = json['total'];
      } else if ((json['total'] as List).isNotEmpty) {
        totalObj =
            json['total'] != null ? new TotalObj.fromJson(json['total']) : null;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.incomeChart != null) {
      data['incomeChart'] = this.incomeChart!.toJson();
    }
    if (this.views != null) {
      data['views'] = this.views!.toJson();
    }
    if (this.influencerInfoWithsubscribers != null) {
      data['influencerInfoWithsubscribers'] =
          this.influencerInfoWithsubscribers!.map((v) => v.toJson()).toList();
    }
    if (this.workoutStats != null) {
      data['workoutStats'] = this.workoutStats!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.total != null) {
      if (this.total is String)
        data['total'] = this.total;
      else {
        data['total'] = this.totalObj!.toJson();
      }
    }

    return data;
  }
}

class TotalObj {
  int? subscription;
  int? views;

  TotalObj({this.subscription, this.views});

  TotalObj.fromJson(Map<String, dynamic> json) {
    subscription = json['subscription'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription'] = this.subscription;
    data['views'] = this.views;
    return data;
  }
}

class IncomeChart {
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
  Day? saturday;
  Day? sunday;

  IncomeChart.fromJson(Map<String, dynamic> json) {
    monday = json['Monday'] != null ? new Day.fromJson(json['Monday']) : null;
    tuesday =
        json['Tuesday'] != null ? new Day.fromJson(json['Tuesday']) : null;
    wednesday =
        json['Wednesday'] != null ? new Day.fromJson(json['Wednesday']) : null;
    thursday =
        json['Thursday'] != null ? new Day.fromJson(json['Thursday']) : null;
    friday = json['Friday'] != null ? new Day.fromJson(json['Friday']) : null;
    saturday =
        json['Saturday'] != null ? new Day.fromJson(json['Saturday']) : null;
    sunday = json['Sunday'] != null ? new Day.fromJson(json['Sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    return data;
  }

  bool isDataFound() {
    if (monday != null) return true;
    if (tuesday != null) return true;
    if (wednesday != null) return true;
    if (thursday != null) return true;
    if (friday != null) return true;
    if (saturday != null) return true;
    if (sunday != null) return true;
    return false;
  }
}

class Day {
  String? fullname;
  String? action;
  int? totalIncome;
  String? dated;
  String? day;
  String? month;

  Day(
      {this.fullname,
      this.action,
      this.totalIncome,
      this.dated,
      this.day,
      this.month});

  Day.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    action = json['action'];
    totalIncome = json['total_income'];
    dated = json['dated'];
    day = json['day'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['action'] = this.action;
    data['total_income'] = this.totalIncome;
    data['dated'] = this.dated;
    data['day'] = this.day;
    data['month'] = this.month;
    return data;
  }
}

class MonthView {
  String? workout;
  String? blog;
  int? views;
  int? subscription;

  MonthView({this.workout, this.blog});

  MonthView.fromJson(Map<String, dynamic> json) {
    workout = json['workout'];
    blog = json['blog'];
    views = json['views'];
    subscription = json['subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workout'] = this.workout;
    data['blog'] = this.blog;
    data['views'] = this.views;
    data['subscription'] = this.subscription;
    return data;
  }
}

class Views {
  DayView? monday;
  DayView? tuesday;
  DayView? wednesday;
  DayView? thursday;
  DayView? friday;
  DayView? saturday;
  DayView? sunday;

  MonthView? jan;
  MonthView? feb;
  MonthView? march;
  MonthView? april;
  MonthView? may;
  MonthView? june;
  MonthView? july;
  MonthView? aug;
  MonthView? sep;
  MonthView? oct;
  MonthView? nov;
  MonthView? dec;

  Views.name(this.monday, this.tuesday, this.wednesday, this.thursday,
      this.friday, this.saturday, this.sunday);

  Views.fromJson(Map<String, dynamic> json) {
    monday =
        json['Monday'] != null ? new DayView.fromJson(json['Monday']) : null;
    tuesday =
        json['Tuesday'] != null ? new DayView.fromJson(json['Tuesday']) : null;
    wednesday = json['Wednesday'] != null
        ? new DayView.fromJson(json['Wednesday'])
        : null;
    thursday = json['Thursday'] != null
        ? new DayView.fromJson(json['Thursday'])
        : null;
    friday =
        json['Friday'] != null ? new DayView.fromJson(json['Friday']) : null;
    saturday = json['Saturday'] != null
        ? new DayView.fromJson(json['Saturday'])
        : null;
    sunday =
        json['Sunday'] != null ? new DayView.fromJson(json['Sunday']) : null;

    july = json['July'] != null ? new MonthView.fromJson(json['July']) : null;
    aug =
        json['August'] != null ? new MonthView.fromJson(json['August']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    if (this.july != null) {
      data['July'] = this.july!.toJson();
    }
    if (this.aug != null) {
      data['August'] = this.aug!.toJson();
    }
    return data;
  }
}

class DayView {
  Blog? blog;
  Blog? workout;

  DayView({this.blog, this.workout});

  DayView.fromJson(Map<String, dynamic> json) {
    blog = json['blog'] != null ? new Blog.fromJson(json['blog']) : null;
    workout =
        json['workout'] != null ? new Blog.fromJson(json['workout']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blog != null) {
      data['blog'] = this.blog!.toJson();
    }
    if (this.workout != null) {
      data['workout'] = this.workout!.toJson();
    }
    return data;
  }
}

class Blog {
  String? views;
  String? againstType;
  String? day;

  Blog({this.views, this.againstType, this.day});

  Blog.fromJson(Map<String, dynamic> json) {
    views = json['views'];
    againstType = json['againstType'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['views'] = this.views;
    data['againstType'] = this.againstType;
    data['day'] = this.day;
    return data;
  }
}

class InfluencerInfoWithsubscribers {
  int? id;
  String? fullname;
  String? email;
  String? phone;
  int? roleId;
  String? promoCode;
  String? instagram;
  String? youtube;
  String? snapchat;
  int? isActive;
  int? isVerified;
  int? createBy;
  String? otp;
  String? facebook;
  String? imageUrl;
  Null? reason;
  int? followedInfluencersCount;
  Info? info;

  InfluencerInfoWithsubscribers(
      {this.id,
      this.fullname,
      this.email,
      this.phone,
      this.roleId,
      this.promoCode,
      this.instagram,
      this.youtube,
      this.snapchat,
      this.isActive,
      this.isVerified,
      this.createBy,
      this.otp,
      this.facebook,
      this.imageUrl,
      this.reason,
      this.followedInfluencersCount,
      this.info});

  InfluencerInfoWithsubscribers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    roleId = json['roleId'];
    promoCode = json['promoCode'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    snapchat = json['snapchat'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    createBy = json['createBy'];
    otp = json['otp'];
    facebook = json['facebook'];
    imageUrl = json['imageUrl'];
    reason = json['reason'];
    followedInfluencersCount = json['followed_influencers_count'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['roleId'] = this.roleId;
    data['promoCode'] = this.promoCode;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['snapchat'] = this.snapchat;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['createBy'] = this.createBy;
    data['otp'] = this.otp;
    data['facebook'] = this.facebook;
    data['imageUrl'] = this.imageUrl;
    data['reason'] = this.reason;
    data['followed_influencers_count'] = this.followedInfluencersCount;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Info {
  int? userId;
  int? id;
  String? imageUrl;
  String? workTitle;
  String? intro;
  String? goals;
  String? credentials;
  String? requirements;
  int? rating;
  String? assetType;
  String? introUrl;

  Info(
      {this.userId,
      this.id,
      this.imageUrl,
      this.workTitle,
      this.intro,
      this.goals,
      this.credentials,
      this.requirements,
      this.rating,
      this.assetType,
      this.introUrl});

  Info.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    workTitle = json['workTitle'];
    intro = json['intro'];
    goals = json['goals'];
    credentials = json['credentials'];
    requirements = json['requirements'];
    rating = json['rating'];
    assetType = json['assetType'];
    introUrl = json['introUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['workTitle'] = this.workTitle;
    data['intro'] = this.intro;
    data['goals'] = this.goals;
    data['credentials'] = this.credentials;
    data['requirements'] = this.requirements;
    data['rating'] = this.rating;
    data['assetType'] = this.assetType;
    data['introUrl'] = this.introUrl;
    return data;
  }
}

class WorkoutStats {
  Workouts? workouts;

  WorkoutStats({this.workouts});

  WorkoutStats.fromJson(Map<String, dynamic> json) {
    workouts = json['workouts'] != null
        ? new Workouts.fromJson(json['workouts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workouts != null) {
      data['workouts'] = this.workouts!.toJson();
    }
    return data;
  }
}

class Workouts {
  String? published;
  String? unPublished;

  Workouts({this.published, this.unPublished});

  Workouts.fromJson(Map<String, dynamic> json) {
    published = json['Published'];
    unPublished = json['UnPublished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Published'] = this.published;
    data['UnPublished'] = this.unPublished;
    return data;
  }
}
