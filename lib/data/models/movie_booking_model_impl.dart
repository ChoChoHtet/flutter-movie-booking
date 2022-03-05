
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/dataagents/retrofit_movie_data_agent_impl.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';
import 'package:movies_booking/persistence/daos/credit_dao.dart';
import 'package:movies_booking/persistence/daos/movie_dao.dart';

import '../../persistence/daos/user_dao.dart';

class MovieBookingModelImpl extends MovieBookingModel {
  MovieBookingAgent _dataAgent = RetrofitMovieDataAgentImpl();
  UserDao userDao = UserDao();
  MovieDao movieDao = MovieDao();
  CreditDao creditDao = CreditDao();

  MovieBookingModelImpl._internal();

  static MovieBookingModelImpl _singleton = MovieBookingModelImpl._internal();

  factory MovieBookingModelImpl() {
    return _singleton;
  }

  @override
  Future<UserVO?> emailRegister(
      String name, String email, String phone, String password) {
    return _dataAgent
        .emailRegister(name, email, phone, password)
        .then((userResponse) async {
      var userVo = userResponse.data;
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      return Future.value(userResponse.data);
    });
  }

  @override
  Future<UserVO?> googleRegister(String name, String email, String phone, String password, String googleToken) {
    return _dataAgent
        .googleRegister(name, email, phone, password,googleToken)
        .then((userResponse) async {
      var userVo = userResponse.data;
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("Google Login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      return Future.value(userResponse.data);
    });
  }

  @override
  Future<UserVO?> emailLogin(String email, String password) {
    return _dataAgent.emailLogin(email, password).then((userResponse) async {
      var userVo = userResponse.data;
      print("email login success: ${userResponse.toString()}");
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      if (userResponse.code == 200) {
        return Future.value(userResponse.data);
      } else {
        return Future.error(userResponse.message ?? "Something went wrong");
      }
    });
  }

  @override
  Future<UserVO> loginGoogle(String accessToken) {
    return _dataAgent.loginGoogle(accessToken).then((userResponse) async {
      var userVo = userResponse.data;
      print("google login success: ${userResponse.toString()}");
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("google login success: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      if (userResponse.code == 200) {
        return Future.value(userResponse.data);
      } else {
        return Future.error(userResponse.message ?? "Something went wrong");
      }
    });
  }

  @override
  Future<CommonResponse> logout() async {
    var token = userDao.getUserInfo()?.getToken();
    print("token: $token");
    return _dataAgent.logout(token!).then((value) => value).asStream().first;
  }

  @override
  Future<UserVO?> getUserInfo() {
    return Future.value(userDao.getUserInfo());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovie() {
    return _dataAgent.getComingSoonMovie().then((comingSoon) async {
      List<MovieVO> movieList = comingSoon?.map((movie) {
            movie.isComingSoon = true;
            return movie;
          }).toList() ??
          [];
      movieDao.saveAllMovies(movieList);
      return Future.value(comingSoon);
    });
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    return _dataAgent.getMovieCredit(movieId).then((credit) async {
      creditDao.saveAllCast(credit ?? []);
      return Future.value(credit);
    });
  }

  @override
  Future<MovieVO?> getMovieDetail(int movieId) {
    return _dataAgent.getMovieDetail(movieId).then((movie) async {
      if (movie != null) {
        movieDao.saveSingleMovie(movie);
      }
      return Future.value(movie);
    });
  }

  @override
  Future<List<MovieVO>?> getNowShowingMovie() {
    return _dataAgent.getNowShowingMovie().then((nowShowing) async {
      List<MovieVO> movieList = nowShowing?.map((movie) {
            movie.isNowShowing = true;
            return movie;
          }).toList() ??
          [];
      movieDao.saveAllMovies(movieList);
      return Future.value(nowShowing);
    });
  }

  @override
  Future<List<CinemaVO>?> getCinemaTimeSlots(String date) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.getCinemaTimeSlots(date, token);
  }

  @override
  Future<List<CinemaSeatVO>?> getCinemaSeats(
      int timeSlotId, String bookingDate) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent
        .getCinemaSeatPlans(token, timeSlotId, bookingDate)
        .then((seatResponse) {
      List<CinemaSeatVO>? seatList =
          seatResponse?.expand((element) => element).map((seat) {
        seat.isSelected = false;
        return seat;
      }).toList();
      print("seat plan api response: ${seatList.toString()}");
      return Future.value(seatList);
    });
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethod() {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.getPaymentMethod(token);
  }

  @override
  Future<List<SnackVO>?> getSnacks() {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.getSnacks(token);
  }

  @override
  Future<GetCardResponse> createCard(String cardNumber, String cardHolder, String expirationDate, String cvc) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.createCard(token, cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  Future<UserVO?> getUserProfile() {
    var token = userDao.getUserInfo()?.getToken() ?? "";
   return _dataAgent.getUserProfile(token);
  }

  @override
  Future<CheckoutVO?> checkoutTicket(CheckOutRequest checkOutRequest) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.checkoutTicket(token, checkOutRequest);
  }





}
