abstract class ChatState {}

class InitChatState extends ChatState {}

class LoadingRegisterRoom extends ChatState {}

class SuccessRegisterRoom extends ChatState {}

class LoadingGetMessagesList extends ChatState {}

class LoadingGetMessagesList2 extends ChatState {}

class SuccessGetMessagesList extends ChatState {}

class ErrorGetMessagesList extends ChatState {}

/////
class LoadingAddNewMessage extends ChatState {}

class SuccessAddNewMessage extends ChatState {}

class LoadingDeleteMessage extends ChatState {}

class SuccessDeleteMessage extends ChatState {}

class ErrorDeleteMessage extends ChatState {}

class LoadingGetRoomList extends ChatState {}

class Loading2GetRoomList extends ChatState {}

class SuccessGetRoomList extends ChatState {}

class ErrorGetRoomList extends ChatState {}

class LoadingAddImageToMessageList extends ChatState {}

class SuccessAddImageToMessageList extends ChatState {}

class SearchedState extends ChatState {}

class NotificationState extends ChatState {}

class LoadingSearchChatFollowers extends ChatState {}

class Loading2SearchChatFollowers extends ChatState {}

class LoadedSearchChatFollowers extends ChatState {}

class ErrorSearchChatFollowers extends ChatState {}

class LoadingGeFollowers extends ChatState {}

class LoadedGeFollowers extends ChatState {}

class ErrorGeFollowers extends ChatState {}

class LoadingSearchFollowers extends ChatState {}

class Loading2SearchFollowers extends ChatState {}

class LoadedSearchFollowers extends ChatState {}

class ErrorSearchFollowers extends ChatState {}

class LoadingDeleteRoomWithId extends ChatState {}

class LoadedDeleteRoomWithId extends ChatState {}

class ErrorDeleteRoomWithId extends ChatState {}

class LoadingGetUserDataState extends ChatState {}

class LoadedGetUserDataState extends ChatState {}

class ErrorGetUserDataState extends ChatState {}

class LoadingChargeWalletState extends ChatState {}

class LoadedChargeWalletState extends ChatState {}

class ErrorChargeWalletState extends ChatState {}
