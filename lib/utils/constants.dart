
const ksignUp = 'user/signUp';
const ksignIn = 'user/signIn';
const kgetUserData = 'user/getUserData';
const krefreshToken = 'user/refreshToken';

var ip = "172.20.10.2";
var kbaseUrl = 'http://$ip:9090/';
var kmeetingUrl = 'http://$ip:9091';
const gameBaseServer = 'http://172.20.10.6:2020/';
const gameWsServer = 'ws://172.20.10.6  :2020/';

var imageUrl = '${kbaseUrl}img/';
const kcheckInternetConnection = 'Check your internet connection!';
const kidPasswordIncorrect = 'Id or password Incorrect!';

const kbadRequest = 'Bad Request!';
const ktryLater = 'Try later!';
const ktimeOut = 'Time out!';

//louay
const kgetCourses = 'course/get/user';
const kaddAvatar = 'user/avatar';
const kgetAllUsers = 'user/all';
const kgetChat = 'messages/';
const kgetChatByGrade = 'messages/grade';

//souhail
const kgetQuiz = 'quiz/get';
const kquizResult = 'quiz/result';
const kgetLeaderBoard = 'leaderboard/get';
const kgetCodingProblem = 'problem/get';
const ksubmission = 'problem/submit';
const ksendEth = 'crypto/sendETH';
const kerrorSendingEth = 'Transaction failed!';
const ktopSolutions = 'problem/top';
const kanswerQuiz = 'quiz/answer';
const kAddAchievement = 'achievement/add';
const kCreatePost = "post/create";
const kGetPosts = "post/get";
const kLikePosts = "post/like";
//seif
const kgetEvents = 'event/getEvents';
const kgetUserEvent = 'event/getUserEvents';
const kregisterEvent = 'event/register';
final DateTime kFirstDay = DateTime(2021, 1, 1);
final DateTime kLastDay = DateTime(2030, 12, 31);

//Zied
const kgetAllClubs = 'club/getAll';
const kgetClub = 'club/get';
const kgetAllClubEvents = 'clubEvent/getAll';
const kgetAllApplications = 'application/getAll';
const kapply = 'application/apply';
const kbookEvent = 'clubEvent/book';

//map consts
const mapToken = 'pk.eyJ1IjoiemllZC1kYWhtYW5pIiwiYSI6ImNsZWJnd3RjMjA1c3kzb210OWQ0YW1pb2kifQ.KNa3PMeruCB7HdCN9zDfQQ';
const mapStyle = 'mapbox.mapbox-streets-v8';
const mapUrlTemplate = 'https://api.mapbox.com/styles/v1/zied-dahmani/cled45t8y001801muszxjo9ti/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}';


//zegocloud
const kzegoAppId = 1961455378;
const kzegoAppSign = '1d1fe700d00e6e452fb3fa49032ab5447492a20392944b300d3b864d7a10aa71';
// User

const kupdatePassword ='user/updatePassword';
const kerrorUpdatePassword = 'Error in updating password!';
const kupdateUsername = 'user/updateUsername';
const kCheckUsername = 'user/checkusername';




const kupdateDeviceToken = 'user/updateDeviceToken';
