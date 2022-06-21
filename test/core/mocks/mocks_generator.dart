import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Core/utils/networking/network_info.dart';
import 'package:untitled/Features/number_trivia/data/data_source/local/number_trivia_local_data_source.dart';
import 'package:untitled/Features/number_trivia/data/data_source/remote/number_trivia_remote_data_source.dart';
import 'package:untitled/Features/number_trivia/domain/repository/numbers_trivia_repository.dart';

@GenerateMocks([NumbersTriviaRepository])
@GenerateMocks([NumberTriviaRemoteDataSource])
@GenerateMocks([NumberTriviaLocalDataSource])
@GenerateMocks([NetworkInfo])
@GenerateMocks([InternetConnectionChecker])
@GenerateMocks([SharedPreferences])
void main(){}