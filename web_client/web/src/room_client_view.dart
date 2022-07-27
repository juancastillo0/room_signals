import 'dart:async';

import 'package:rad/rad.dart';
import 'package:rad/widgets_async.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad/widgets_short_html.dart';
import 'package:room_signals_client/room_signals_client.dart';

import 'flex.dart';
import 'inputs.dart';
import 'utils/local_storage_persistence.dart';

class RoomSignalsClientView extends StatefulWidget {
  const RoomSignalsClientView({
    super.key,
    this.style,
  });

  final String? style;

  @override
  State<RoomSignalsClientView> createState() => _RoomSignalsClientViewState();
}

class _RoomSignalsClientViewState extends State<RoomSignalsClientView> {
  late final RoomSignalsClient client;
  final ValueNotifier<String> userName = ValueNotifier('');
  final ValueNotifier<String> messageText = ValueNotifier('');

  bool loading = true;
  bool creatingRoom = false;
  bool sendingMessage = false;

  String? error;

  Room? room;
  final ValueNotifier<String> roomToken = ValueNotifier('');
  final Map<String, List<$RoomMessageMixin>> messages = {};
  List<$RoomMessageMixin> get roomMessages =>
      messages[room?.data.roomId] ?? const [];

  void _rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userName.addListener(_rebuild);
    messageText.addListener(_rebuild);
    roomToken.addListener(_rebuild);

    const persistence = ClientPersistencePrefixed(
      inner: ClientPersistenceLocalStorage(),
      prefix: 'rs_client-',
    );
    RoomSignalsClient.create(
      'ws://localhost:6394/graphql-subscription',
      persistence: persistence,
    ).then((value) {
      if (!mounted) return;
      setState(() {
        client = value;
        userName.value = value.userCreated.user.name ?? '';
        loading = false;
        if (value.rooms.isNotEmpty) {
          room = value.rooms.values.first;
          roomToken.value = room!.token;
        }

        client.messageStream.listen((event) {
          setState(() {
            messages.putIfAbsent(event.roomId, () => []).add(event);
          });
        });
        client.roomChangeStream.listen((event) {
          setState(() {});
        });
      });
    });
  }

  Future<void> _leaveRoom(_) async {
    await room!.cancelSubscription();

    setState(() {
      room = null;
    });
  }

  Future<void> _createRoom(_) async {
    if (creatingRoom) return;
    creatingRoom = true;
    setState(() {});
    Object? error;
    try {
      final result = await client.createRoom();
      final room = result.data?.createRoom;
      if (room != null) {
        await _subscribeToRoom(room.token);
      } else {
        error = result.errors;
      }
    } catch (e) {
      error = e;
    }

    if (mounted) {
      setState(() {
        creatingRoom = false;
        if (error != null) {
          this.error = error.toString();
        }
      });
    }
  }

  Future<Room?> _subscribeToRoom(String token) async {
    try {
      room = await client.subscribeToRoom(token);
      roomToken.value = token;
      return room;
    } catch (e) {
      return null;
    }
  }

  Future<void> _sendMessage(_) async {
    if (messageText.value.trim().isEmpty) {
      return;
    }
    if (sendingMessage) return;
    final message = messageText.value;
    messageText.value = '';
    sendingMessage = true;
    final result = await client.sendMessage(
      SendMessageRoomArguments(
        content: message,
        roomId: room!.data.roomId,
        recipientUserId: null,
      ),
    );
    if (result.hasErrors) {
      messageText.value = message;
    }
    sendingMessage = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    client.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Text('Loading...');

    return div(
      style: 'height:350px;max-width:600px;',
      child: Column(
        children: [
          Row(
            expand: false,
            children: [
              Label(
                innerText: 'Username',
                forAttribute: 'userNameInput',
              ),
              const Span(style: 'width:10px;'),
              InputText(
                id: 'userNameInput',
                value: userName.value,
                onInput: onInput(userName),
              ),
              Button(
                onClick: (event) {},
                child: Text('Update Name'),
              ),
              const Span(style: 'width:20px;'),
              if (room != null)
                Button(
                  onClick: _leaveRoom,
                  child: Text('Leave Room'),
                )
            ],
          ),
          const Span(style: 'height:20px;'),
          if (room != null)
            Row(
              cross: AxisAlign.end,
              children: [
                Flexible(child: _roomMessages()),
                div(
                  style: 'text-align:start;font-size:0.8em;width:170px;'
                      'overflow-wrap:anywhere;padding-left:12px;',
                  child: Column(
                    cross: AxisAlign.start,
                    children: [
                      Text('RoomId: ${room!.data.roomId}'),
                      Text('Token: ${room!.token}'),
                      Text('LastUpdate: ${room!.data.lastUpdateDate}'),
                      Text('Created: ${room!.data.createdDate}'),
                      Text('Users'),
                      UnOrderedList(
                        style: 'margin:0;padding-left:25px;',
                        children: [
                          ...room!.data.users.map(
                            (e) => ListItem(
                              key: Key(e.userId),
                              child: Text(
                                '${e.name ?? e.userId}${e.name == null ? '' : '(${e.userId})'}',
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          else
            div(
              style: '${flexCenter(column: true)};padding:32px;',
              children: [
                Button(
                  onClick: _createRoom,
                  child: Text('Create Room'),
                ),
                Text(
                  'Or use a room token',
                  style: 'padding:12px 18px;font-size:1.2em;',
                ),
                Row(
                  children: [
                    Label(
                      innerText: 'Room Token',
                      forAttribute: 'roomTokenInput',
                    ),
                    const Span(style: 'width:10px;'),
                    InputText(
                      id: 'roomTokenInput',
                      value: roomToken.value,
                      onInput: onInput(roomToken),
                    ),
                    Button(
                      onClick: (event) {
                        _subscribeToRoom(roomToken.value);
                      },
                      child: Text('Enter Room'),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _roomMessages() {
    return Column(
      main: AxisAlign.end,
      children: [
        ListView(
          style: 'overflow-y:auto;',
          key: Key('messageList'),
          children: [
            ...roomMessages.map(
              (e) => Column(
                cross: e.user.userId == client.userCreated.user.userId
                    ? AxisAlign.end
                    : AxisAlign.start,
                children: [
                  Text(e.content),
                  Text(e.createdDate.toString(), style: 'font-size:0.7em;'),
                ],
              ),
            )
          ],
        ),
        const Span(style: 'height:10px;'),
        Row(
          children: [
            Flexible(
              child: InputText(
                id: 'message-input',
                style: 'width:100%;',
                // TODO: empty value is not overridden
                value: messageText.value,
                onInput: onInput(messageText),
                // TODO:
                // onKeyPress: (e) {
                //   if ((e as html.KeyboardEvent).key == "Enter") {
                //     // Cancel the default action, if needed
                //     e.preventDefault();
                //     // Trigger the button element with a click
                //     _sendMessage(e);
                //   }
                // },
              ),
            ),
            Button(
              onClick: _sendMessage,
              child: Text('Send'),
            ),
          ],
        ),
      ],
    );
  }
}
