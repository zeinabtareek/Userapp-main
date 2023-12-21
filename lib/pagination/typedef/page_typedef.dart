


import '../../view/screens/chat/models/res/msg_chat_res_model_item.dart';
import '../../view/screens/chat/pagienate-use-cases/get_chat_msgs_use_case.dart';
import '../../view/screens/chat/pagienate-use-cases/get_chats_list_usecase.dart';
import '../../view/screens/chat/widget/message_bubble.dart';
import '../../view/screens/chat/widget/message_item.dart';
import '../../view/screens/history/model/history_model.dart';
import '../../view/screens/history/page-use-case/get_history_trips_use_case.dart';
import '../../view/screens/history/widgets/activity_item_view.dart';
import '../../view/screens/notification/model/notification_res_model.dart';
import '../../view/screens/notification/pagnaintion/use-case/get_notifications_use_case.dart';
import '../../view/screens/notification/widgets/activity_notification_tap.dart';
import '../../view/screens/parcel/page-use-case/get_parcel_list_package_use_case.dart';
import '../../view/screens/parcel/widgets/item_track_history_card.dart';
import '../../view/screens/parcel/widgets/track_componants/track_order_with_status.dart';
import '../../view/screens/wallet/model/wallet_model.dart';
import '../../view/screens/wallet/pagnation/get_all_transactions_use_case.dart';
import '../../view/screens/wallet/widget/my_earn_card_widget.dart';
import '../controller/pagination_controller.dart';
import '../use-case/main_paginate_list_use_case.dart';
import '../widgets/paginations_widgets.dart';

typedef PC<T extends MainPaginateListUseCase, E> = PaginationController<T, E>;

// PaginateTripHistory
typedef PaginateTripHistoryController<T extends MainPaginateListUseCase, E>
    = PC<GetHistoryTripsUseCase, HistoryData>;
typedef PaginateTripHistoryView = PaginationListViewInTabBar<
    GetHistoryTripsUseCase, HistoryData, ActivityItemView>;
// PaginateTripHistory
typedef PaginateParcelListPackageController<T extends MainPaginateListUseCase, E>
    = PC<GetParcelListPackageUseCase, HistoryData>;
typedef PaginateParcelListHomePackageController<T extends MainPaginateListUseCase, E>
    = PC<GetParcelListPackageUseCase, HistoryData>;
typedef PaginateParcelListPackageView = PaginationListViewInTabBar<
    GetParcelListPackageUseCase, HistoryData, TrackOrderWithStatus>;
typedef PaginateParcelListHomePackageView = PaginationListViewInTabBar<
    GetParcelListPackageUseCase, HistoryData, ItemTrackHistory>;



// PaginateTripHistory
typedef PaginateNotificationController<T extends MainPaginateListUseCase, E>
    = PC<GetNotificationsUseCase, NotificationModel>;
typedef PaginateNotificationView = PaginationListViewInTabBar<
    GetNotificationsUseCase, NotificationModel, NotificationWidget>;    



// PaginateAllTransactions
typedef PaginateAllTransactionsController<T extends MainPaginateListUseCase, E>
    = PC<GetAllTransactionsUseCase, WalletData>;
typedef PaginateAllTransactionsView = PaginationListViewInTabBar<
    GetAllTransactionsUseCase, WalletData, MyEarnCardWidget>;    



// PaginateChatListOrders
typedef PaginateChatListOrdersController<T extends MainPaginateListUseCase, E>
    = PC<GetChatsListOrdersUseCase, MsgChatResModelItem>;
typedef PaginateChatListOrdersView = PaginationListViewInTabBar<
    GetChatsListOrdersUseCase, MsgChatResModelItem, MessageItem>;

// PaginateChatListAdmin
typedef PaginateChatListAdminController<T extends MainPaginateListUseCase, E>
    = PC<GetChatsListAdminUseCase, MsgChatResModelItem>;
typedef PaginateChatListAdminView = PaginationListViewInTabBar<
    GetChatsListAdminUseCase, MsgChatResModelItem, MessageItem>;




// PaginateChatListOrders
typedef PaginateChatMsgsController<T extends MainPaginateListUseCase, E>
    = PC<GetChatMsgsUseCase, MsgChatResModelItem>;
typedef PaginateChatMsgsView = PaginationChatListView<GetChatMsgsUseCase,
    MsgChatResModelItem, ConversationBubble>;
