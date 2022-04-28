import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/widgets/bottom_loader.dart';
import 'package:casino_test/src/presentation/ui/widgets/character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202428),
      body: SafeArea(
        child: BlocListener<MainPageBloc, MainPageState>(
          listener: (context, state) {
            if (state is UnSuccessfulMainPageState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Failed to fetch characters'),
                ),
              );
            }
          },
          child: BlocBuilder<MainPageBloc, MainPageState>(
            builder: (context, state) {
              if (state is SuccessfulMainPageState) {
                if (state.characters.isEmpty) {
                  return const Center(child: Text('No Characters loaded'));
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.characters.length
                        ? const BottomLoader()
                        : CharacterWidget(character: state.characters[index]);
                  },
                  itemExtent: 178,
                  itemCount: state.characters.length + 1,
                  // itemCount: state.hasReachedMax
                  //     ? state.posts.length
                  //     : state.posts.length + 1,
                  controller: _scrollController,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MainPageBloc>().add(const GetTestDataOnMainPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.99);
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
