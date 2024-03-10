import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NameEditor extends StatefulWidget {
  const NameEditor({super.key});

  @override
  State<NameEditor> createState() => _NameEditorState();
}

class _NameEditorState extends State<NameEditor> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final String _startName;

  @override
  void initState() {
    final state = BlocProvider.of<PlayerBloc>(context).state;

    if (state is PlayerReadyState) {
      _startName = state.nickname;
    } else {
      _startName = '';
    }

    _controller.text = _startName;

    super.initState();
  }

  void onSubmitted(String text) {
    if (_formKey.currentState!.validate() && text != _startName) {
      context.read<PlayerBloc>().add(SetPlayerNameEvent(text));
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: AppSize.defaultSpace),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              LocaleKeys.nicknameLimits,
              style: TextStyle(color: Colors.blueGrey),
            ).tr(),
          ),
          const SizedBox(height: 14),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              controller: _controller,
              onFieldSubmitted: (value) => onSubmitted(_controller.text),
              maxLength: 18,
              validator: (value) {
                if (value == null || value == '' || value.length < 3) {
                  return LocaleKeys.nicknameValidator.tr();
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я0-9-]')),
              ],
              decoration: InputDecoration(
                labelText: LocaleKeys.nicknameLabel.tr(),
                hintText: LocaleKeys.nicknameHint.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => onSubmitted(_controller.text),
              child: const Text(LocaleKeys.done).tr(),
            ),
          )
        ]),
      ),
    );
  }
}
