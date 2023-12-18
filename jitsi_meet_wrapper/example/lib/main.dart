import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Meeting(),
    );
  }
}

class Meeting extends StatefulWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController(text: "https://8x8.vc/");
  final roomText = TextEditingController(text: "vpaas-magic-cookie-680d9fe42572402a8d169d01e208fb2d/bDCFaOtV4V5Tb18m");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final tokenText = TextEditingController(text: "eyJhbGciOiJSUzI1NiIsImtpZCI6InZwYWFzLW1hZ2ljLWNvb2tpZS02ODBkOWZlNDI1NzI0MDJhOGQxNjlkMDFlMjA4ZmIyZC83MTE0MWQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJjaGF0IiwiYXVkIjoiaml0c2kiLCJleHAiOjE3MDI5MDY1NjAsIm5iZiI6MTcwMjczMzc2MCwicm9vbSI6IioiLCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtNjgwZDlmZTQyNTcyNDAyYThkMTY5ZDAxZTIwOGZiMmQiLCJjb250ZXh0Ijp7InVzZXIiOnsibW9kZXJhdG9yIjpmYWxzZSwiZW1haWwiOiJ4cmlzdG9zbXBvdUBob3RtYWlsLmNvbSIsIm5hbWUiOiJQYXRpZW50IERlbW8gQWxleGlzIiwiaWQiOiI1In0sImZlYXR1cmVzIjp7InJlY29yZGluZyI6ZmFsc2UsImxpdmVzdHJlYW1pbmciOmZhbHNlLCJ0cmFuc2NyaXB0aW9uIjpmYWxzZSwib3V0Ym91bmQtY2FsbCI6ZmFsc2V9fX0.Bn8K_WPDg-ec8lSQPXupsOzQYdebw6L-48WiJ2cEdScb8vSpPYX_cMxZ2g5XyEBWMfXPHvb4nDONH11fTWbJ8Dr2umTSrrgvuLDpGun-KvYkV65U4stZYzDHIoycdHd77UbxB4kKO9KiwX9NpNW6jjG4QAknJGR-nSiQxcisbm33kSgIqO4063T0M-7oTOlKlw3_QeQ3NwSwNDSSCd_UeHrMmkK_MUY8OqTluWvT_rs7l-L0sh2__nuqHghq5eFYO8JSVTPeWJXRyzqRR9izHo81kj02mgMYcwjfAeAMBn4c_-reEGoYxzqtbgFdfi7SEBMB3HzYLRKzwJgDCTK33Q");
  final userDisplayNameText = TextEditingController(text: "Plugin Test User");
  final userEmailText = TextEditingController(text: "fake@email.com");
  final userAvatarUrlText = TextEditingController();

  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Jitsi Meet Wrapper Test')),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: buildMeetConfig(),
        ),
      ),
    );
  }

  Widget buildMeetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16.0),
          _buildTextField(
            labelText: "Server URL",
            controller: serverText,
            hintText: "Hint: Leave empty for meet.jitsi.si",
          ),
          const SizedBox(height: 16.0),
          _buildTextField(labelText: "Room", controller: roomText),
          const SizedBox(height: 16.0),
          _buildTextField(labelText: "Subject", controller: subjectText),
          const SizedBox(height: 16.0),
          _buildTextField(labelText: "Token", controller: tokenText),
          const SizedBox(height: 16.0),
          _buildTextField(
            labelText: "User Display Name",
            controller: userDisplayNameText,
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            labelText: "User Email",
            controller: userEmailText,
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            labelText: "User Avatar URL",
            controller: userAvatarUrlText,
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(height: 48.0, thickness: 2.0),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () => _joinMeeting(),
              child: const Text(
                "Join Meeting",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 48.0),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    Map<String, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomText.text,
      serverUrl: serverUrl,
      subject: subjectText.text,
      token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: userDisplayNameText.text,
      userEmail: userEmailText.text,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText),
    );
  }
}
